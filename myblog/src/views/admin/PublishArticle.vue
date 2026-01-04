<script setup>
import { reactive, ref, inject, provide, nextTick, onMounted, watch } from 'vue'
import Editor from '@tinymce/tinymce-vue'
import { ElMessageBox, ElMessage } from 'element-plus'
import { useStore } from '@/stores/my'
import Cropper from "@/components/Cropper.vue";
import { undefine, nullZeroBlank } from "@/js/tool.js"
import { useRoute } from 'vue-router'
import { Position, MapLocation } from '@element-plus/icons-vue' // 引入图标
import 'leaflet/dist/leaflet.css' // 引入地图样式
import L from 'leaflet' // 引入地图核心库

const store = useStore()
const route = useRoute()
const axios = inject('axios')

let type = "add"
const header = ref("发布文章")

// === 分类相关 ===
const categoryOptions = ref([])
const selectedCategory = ref([])

// === 地图相关变量 ===
const mapVisible = ref(false)
let mapInstance = null
let markerInstance = null

// 加载分类树
function loadCategoryTree() {
  axios.get('/api/category/getTree').then(res => {
    if (res.data.success) {
      categoryOptions.value = res.data.map.data
    }
  })
}

// 图片上传配置 (保持不变)
const image_upload_handler = (blobInfo, progress) => new Promise((resolve, reject) => {
  const xhr = new XMLHttpRequest();
  xhr.withCredentials = false;
  xhr.open('POST', '/api/article/upload');
  xhr.upload.onprogress = (e) => { progress(e.loaded / e.total * 100); };
  xhr.onload = () => {
    if (xhr.status === 403) { reject({ message: 'HTTP Error: ' + xhr.status, remove: true }); return; }
    if (xhr.status < 200 || xhr.status >= 300) { reject('HTTP Error: ' + xhr.status); return; }
    const json = JSON.parse(xhr.response);
    if (!json || !json.map || typeof json.map.url != 'string') { reject('Invalid JSON: ' + xhr.responseText); return; }
    resolve(json.map.url);
  };
  xhr.onerror = () => { reject('Image upload failed. Code: ' + xhr.status); };
  const formData = new FormData();
  formData.append('file', blobInfo.blob(), blobInfo.filename());
  xhr.send(formData);
});

const apiKey = ref('bdddx89zynvfw2qmzfk2mhycdiss6ujej1hkf49al3p0omcc')
const init = reactive({
  language: "zh_CN",
  placeholder: "在这里输入文字",
  plugins: ['image', 'code'],
  toolbar: 'image',
  images_file_types: 'jpg,jpeg,png,gif,bmp',
  images_upload_handler: image_upload_handler,
  convert_urls: false
})

// === 文章对象 (新增 location) ===
let article = reactive({
  "title": "",
  "tags": "",
  "content": "",
  "categories": "",
  "thumbnail": "",
  "location": "" // 新增字段
})

const cropper1 = ref(null)

// === 【新增功能】自动保存草稿 ===
const DRAFT_KEY = 'blog_publish_draft_v1' // 草稿存储Key

// 监听 article 对象变化，自动保存
let draftTimer = null
watch(article, (newVal) => {
  // 防抖处理：如果1秒内连续输入，清除上一次的定时器
  if (draftTimer) clearTimeout(draftTimer)

  draftTimer = setTimeout(() => {
    // 保存关键字段
    const draftData = {
      title: newVal.title,
      tags: newVal.tags,
      content: newVal.content,
      categories: newVal.categories,
      location: newVal.location,
      thumbnail: newVal.thumbnail // 注意：这里保存的是 url，如果是 Cropper 未上传的截图可能无法保存
    }
    localStorage.setItem(DRAFT_KEY, JSON.stringify(draftData))
    // 可以选择在控制台打印日志方便调试
    // console.log('草稿已自动保存', new Date().toLocaleTimeString())
  }, 5000) // 1秒后执行保存
}, { deep: true }) // 深度监听

// === 1. 自动获取定位 ===
function autoLocate() {
  if (!navigator.geolocation) {
    ElMessage.error('您的浏览器不支持地理定位')
    return
  }

  const loadingMsg = ElMessage({
    message: '正在尝试获取定位...',
    type: 'info',
    duration: 0,
    showClose: true
  })

  navigator.geolocation.getCurrentPosition(async (position) => {
    const { latitude, longitude } = position.coords
    try {
      const res = await fetch(`https://nominatim.openstreetmap.org/reverse?format=json&lat=${latitude}&lon=${longitude}&zoom=10&accept-language=zh-CN`)
      const data = await res.json()
      const addr = data.address
      const city = addr.city || addr.town || addr.county || addr.state || '未知位置'
      article.location = city
      loadingMsg.close()
      ElMessage.success('定位成功: ' + city)
    } catch (e) {
      loadingMsg.close()
      ElMessage.error('获取地址名称失败，请手动输入')
    }
  }, (err) => {
    loadingMsg.close()
    ElMessage.error('自动定位失败，请检查浏览器权限或使用地图选取')
  }, { timeout: 10000 })
}

// === 2. 打开地图手动选取 ===
function openMap() {
  mapVisible.value = true
  nextTick(() => {
    initMap()
  })
}

function initMap() {
  if (mapInstance) return
  const defaultLat = 39.9042
  const defaultLng = 116.4074
  mapInstance = L.map('map-container').setView([defaultLat, defaultLng], 4)
  L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
    attribution: '&copy; OpenStreetMap contributors'
  }).addTo(mapInstance)

  mapInstance.on('click', async (e) => {
    const { lat, lng } = e.latlng
    if (markerInstance) {
      markerInstance.setLatLng(e.latlng)
    } else {
      markerInstance = L.marker(e.latlng).addTo(mapInstance)
    }
    try {
      const res = await fetch(`https://nominatim.openstreetmap.org/reverse?format=json&lat=${lat}&lon=${lng}&zoom=10&accept-language=zh-CN`)
      const data = await res.json()
      const addr = data.address
      const locationName = addr.city || addr.town || addr.county || addr.state || data.display_name.split(',')[0]
      article.location = locationName
      ElMessage.success(`已选中: ${locationName}`)
    } catch (err) {
      ElMessage.warning('地址解析失败，请直接输入')
    }
  })
}

// 发布文章
function publishArticle() {
  let thumbnail = cropper1.value.getThumbnail()
  if (undefine(thumbnail) || nullZeroBlank(thumbnail) || thumbnail.indexOf("/api") != 0) {
    article.thumbnail = ""
  } else {
    article.thumbnail = thumbnail
  }

  if (selectedCategory.value && selectedCategory.value.length > 0) {
    article.categories = selectedCategory.value.join('/')
  } else {
    article.categories = "默认分类"
  }

  if (article.tags) {
    let tempTags = article.tags.replace(/，/g, ' ').replace(/,/g, ' ').trim()
    let tagList = tempTags.split(/\s+/)
    article.tags = tagList.map(tag => tag.startsWith('#') ? tag : '#' + tag).join(' ')
  }

  axios({
    method: 'post',
    url: '/api/article/publishArticle?type=' + type,
    data: article,
    timeout: 3000000
  }).then((response) => {
    ElMessageBox.alert(response.data, '结果')
    if ("添加成功！" == response.data || "修改成功！" == response.data) {
      // === 【新增】发布成功，清除草稿 ===
      localStorage.removeItem(DRAFT_KEY)
      // ==============================
      clearData()
      window.scrollTo(0, 0)
    }
  }).catch((error) => {
    ElMessageBox.alert("系统错误！", '结果')
  })
}

const gotoArticleManage = inject("gotoArticleManage")
let isShowCropper = ref(true)

function freshCropper() {
  isShowCropper.value = false
  nextTick(() => { isShowCropper.value = true; })
}
provide("freshCropper", freshCropper)

function clearData() {
  article.title = ""
  article.tags = ""
  article.content = ""
  article.categories = ""
  article.location = ""
  selectedCategory.value = []
  article.thumbnail = ""
  cropper1.value.clearData()
}

onMounted(() => {
  loadCategoryTree()

  // 1. 处理分类回显
  if (route.query.categoryPath) {
    const pathStr = route.query.categoryPath
    selectedCategory.value = pathStr.split('/')
    article.categories = pathStr
  }

  // 2. 检查是否有草稿 (放在编辑模式之前，避免覆盖编辑数据，但用户确认后可覆盖)
  const draftStr = localStorage.getItem(DRAFT_KEY)
  if (draftStr) {
    const draft = JSON.parse(draftStr)
    // 只要标题或内容不为空，就提示恢复
    if (draft.title || draft.content) {
      ElMessageBox.confirm(
        '检测到您上次有未发布的草稿，是否恢复？',
        '恢复草稿',
        {
          confirmButtonText: '恢复内容',
          cancelButtonText: '丢弃',
          type: 'info',
        }
      ).then(() => {
        // 恢复数据
        article.title = draft.title || ""
        article.content = draft.content || ""
        article.tags = draft.tags || ""
        article.location = draft.location || ""
        article.categories = draft.categories || ""
        article.thumbnail = draft.thumbnail || ""

        // 恢复分类选择框
        if (article.categories) {
          selectedCategory.value = article.categories.split('/')
        }
        // 恢复缩略图 (如果缩略图是已上传的图片链接)
        if (article.thumbnail && article.thumbnail.indexOf("/api") == 0 && cropper1.value) {
          cropper1.value.setThumbnail(article.thumbnail)
        }
        ElMessage.success('草稿已恢复')
      }).catch(() => {
        localStorage.removeItem(DRAFT_KEY) // 丢弃草稿
        ElMessage.info('已丢弃草稿')
      })
    }
  }

  // 3. 处理编辑模式 (如果 store.articleId > 0)
  if (store.articleId > 0) {
    type = "edit"
    header.value = "编辑文章"
    axios({
      method: 'post',
      url: '/api/article/selectById?id=' + store.articleId
    }).then((response) => {
      if (response.data.success) {
        let nowArticle = response.data.map.article
        article.id = nowArticle.id
        // 如果用户刚才点了"恢复草稿"，这里的赋值会覆盖草稿。
        // 但通常 axios 是异步的，且"恢复草稿"是需要用户点击确认的。
        // 逻辑顺序：页面加载 -> 弹出询问恢复 -> 发送请求获取编辑数据 -> 请求返回覆盖数据 -> 用户点击恢复覆盖数据。
        // 这样设计是合理的：用户点击恢复的动作通常比请求返回慢，所以草稿最终会覆盖服务器旧数据，达到"恢复未保存工作"的目的。

        article.title = nowArticle.title
        article.tags = nowArticle.tags
        article.content = nowArticle.content
        article.thumbnail = nowArticle.thumbnail
        article.location = nowArticle.location || ""

        if (nowArticle.categories) {
          article.categories = nowArticle.categories
          selectedCategory.value = nowArticle.categories.split('/')
        }

        if (!undefine(article.thumbnail) && !nullZeroBlank(article.thumbnail) && article.thumbnail.indexOf("/api") == 0) {
          cropper1.value.setThumbnail(article.thumbnail)
        }
      } else {
        ElMessageBox.alert(response.data.msg, '结果')
      }
      store.articleId = 0
    }).catch((error) => {
      ElMessageBox.alert("系统错误！", '结果')
      store.articleId = 0
    })
  }
})
</script>

<template>
  <el-row>
    <el-col :span="24">
      <h4>{{ header }}</h4>
    </el-col>
  </el-row>

  <el-row :gutter="20" style="margin-bottom: 20px;">
    <el-col :span="8">
      <el-input v-model="article.title" placeholder="请输入文章标题（必须）" clearable />
    </el-col>

    <el-col :span="8">
      <el-cascader v-model="selectedCategory" :options="categoryOptions"
        :props="{ checkStrictly: true, value: 'name', label: 'name' }" placeholder="请选择文章分类" clearable
        style="width: 100%;" />
    </el-col>

    <el-col :span="8">
      <el-input v-model="article.tags" placeholder="标签: #Java #Spring" clearable />
    </el-col>
  </el-row>

  <el-row :gutter="20" style="margin-bottom: 20px;">
    <el-col :span="12">
      <el-input v-model="article.location" placeholder="发布地点 (可自动获取或手动选择)" clearable>
        <template #prepend>
          <el-icon>
            <MapLocation />
          </el-icon>
        </template>
        <template #append>
          <el-button :icon="Position" @click="autoLocate" title="自动定位" />
          <el-button :icon="MapLocation" @click="openMap" title="在地图上选择" />
        </template>
      </el-input>
    </el-col>
  </el-row>

  <el-row>
    <el-col :span="24">
      <div id="editor">
        <editor v-model="article.content" :init="init" :api-key="apiKey" />
      </div>
    </el-col>
  </el-row>
  <el-row>
    <el-col :span="24">
      <Cropper ref="cropper1" v-if="isShowCropper" />
    </el-col>
  </el-row>
  <el-row>
    <el-col :span="24">
      <div align="right">
        <el-button @click="gotoArticleManage">返回列表</el-button>
        <el-button type="primary" @click="publishArticle">保存文章</el-button>
      </div>
    </el-col>
  </el-row>

  <el-dialog v-model="mapVisible" title="点击地图选择位置" width="600px" append-to-body>
    <div id="map-container" style="height: 400px; width: 100%;"></div>
    <template #footer>
      <span class="dialog-footer">
        <el-button @click="mapVisible = false">确定</el-button>
      </span>
    </template>
  </el-dialog>
</template>

<style scoped>
/* 确保地图容器有z-index，防止遮挡 */
#map-container {
  z-index: 1;
}
</style>
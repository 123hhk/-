<script setup>
import { ref, reactive, onMounted, inject } from 'vue'
import { useStore } from '@/stores/my'
import { ElMessage } from 'element-plus'
import Top from '@/components/Top.vue'
import { User, Timer, Edit, Document, ChatLineRound, Plus } from '@element-plus/icons-vue'

const store = useStore()
const axios = inject('axios')

const activeTab = ref('timeline')
const activities = ref([]) // 足迹
const myArticles = ref([]) // 我的文章
const myComments = ref([]) // 我的评论
const loading = ref(false)

// 表单数据
const userInfoForm = reactive({
  id: '',
  username: '',
  name: '',
  email: '',
  avatar: '' // 头像
})

// --- 核心功能 1: 头像上传 ---
// 上传成功的回调
function handleAvatarSuccess(response, uploadFile) {
  // response 是后端 FileController 返回的 Result 对象
  if (response.success) {
    // response.map.url 就是 /api/file/images/xxx.jpg
    userInfoForm.avatar = response.map.url
    ElMessage.success('头像上传成功，请记得点击“保存修改”按钮！')
  } else {
    ElMessage.error('上传失败: ' + response.msg)
  }
}
function beforeAvatarUpload(rawFile) {
  if (rawFile.type !== 'image/jpeg' && rawFile.type !== 'image/png') {
    ElMessage.error('头像必须是 JPG 或 PNG 格式!')
    return false
  } else if (rawFile.size / 1024 / 1024 > 2) {
    ElMessage.error('头像大小不能超过 2MB!')
    return false
  }
  return true
}

// --- 数据加载 ---
function loadAllData() {
  if (!store.user.user) return
  const u = store.user.user

  // 1. 初始化表单 (修复 Bug: 确保显示正确的数据)
  userInfoForm.id = u.id
  userInfoForm.username = u.username
  userInfoForm.name = u.name || u.username // 如果没昵称，默认显示用户名
  userInfoForm.email = u.email
  userInfoForm.avatar = u.avatar

  // 2. 加载日志
  axios.get('/api/oplog/getMyLogs?userId=' + u.id).then(res => {
    if (res.data.success) activities.value = res.data.map.logs
  })

  // 3. 加载我的文章 (功能 4)
  axios.post('/api/article/getMyArticles?userId=' + u.id).then(res => {
    if (res.data.success) myArticles.value = res.data.map.articles
  })

  // 4. 加载我的评论 (功能 5) - 注意这里传的是用户名，因为评论表存的是author名
  axios.post('/api/comment/getMyComments?username=' + (u.username)).then(res => {
    if (res.data.success) myComments.value = res.data.map.comments
  })
}

// --- 提交修改 ---
function submitUpdate() {
  axios.post('/api/user/updateInfo', userInfoForm).then(res => {
    if (res.data.success) {
      ElMessage.success('修改成功')
      // 关键：更新 Pinia 里的用户信息，解决刷新前显示旧数据的Bug
      store.login(res.data.map.user)
    } else {
      ElMessage.error(res.data.msg)
    }
  })
}

onMounted(() => {
  loadAllData()
})
</script>

<template>
  <el-affix>
    <Top />
  </el-affix>

  <div class="center-container">
    <el-row :gutter="20">

      <el-col :xs="24" :sm="8">
        <el-card class="box-card" shadow="hover">
          <div class="user-header">
            <el-avatar :size="100"
              :src="store.user.user?.avatar || 'https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png'" />

            <h3 class="username">{{ store.user.user?.name || store.user.user?.username }}</h3>

            <p class="reg-time">
              注册于: {{ store.user.user?.created ? store.user.user.created.replace('T', ' ') : '未知时间' }}
            </p>
          </div>
        </el-card>
      </el-col>

      <el-col :xs="24" :sm="16">
        <el-card shadow="hover" class="right-card">
          <el-tabs v-model="activeTab">

            <el-tab-pane name="timeline" label="我的足迹">
              <el-scrollbar max-height="500px">
                <el-timeline v-if="activities.length > 0" style="padding-top: 10px;">
                  <el-timeline-item v-for="(act, i) in activities" :key="i" :timestamp="act.created.replace('T', ' ')"
                    placement="top" :color="act.type === 'COMMENT' ? '#409EFF' : '#909399'">

                    <span v-if="act.targetId && (act.type === 'BROWSE' || act.type === 'COMMENT')"
                      @click="$router.push('/article_comment/' + act.targetId)" style="cursor: pointer; color: #303133;"
                      class="log-content">
                      {{ act.content }}
                    </span>
                    <span v-else>
                      {{ act.content }}
                    </span>

                  </el-timeline-item>
                </el-timeline>
                <el-empty v-else description="暂无足迹" />
              </el-scrollbar>
            </el-tab-pane>

            <el-tab-pane name="articles" label="我的文章">
              <el-scrollbar max-height="500px">
                <div v-if="myArticles.length > 0">
                  <div v-for="art in myArticles" :key="art.id" class="list-item"
                    @click="$router.push('/article_comment/' + art.id)">
                    <span class="item-title">{{ art.title }}</span>
                    <span class="item-date">{{ art.created.replace('T', ' ') }}</span>
                  </div>
                </div>
                <el-empty v-else description="你还没发布过文章" />
              </el-scrollbar>
            </el-tab-pane>

            <el-tab-pane name="comments" label="我的评论">
              <el-scrollbar max-height="500px">
                <div v-if="myComments.length > 0">
                  <div v-for="cmt in myComments" :key="cmt.id" class="list-item">
                    <span class="item-content">{{ cmt.content }}</span>
                    <span class="item-date">{{ cmt.created.replace('T', ' ') }}</span>
                  </div>
                </div>
                <el-empty v-else description="你还没发表过评论" />
              </el-scrollbar>
            </el-tab-pane>

            <el-tab-pane name="settings" label="资料设置">
              <el-form label-width="80px" style="max-width: 500px; margin-top: 20px;">

                <el-form-item label="头像">
                  <el-upload class="avatar-uploader" action="/api/file/upload" :show-file-list="false"
                    :on-success="handleAvatarSuccess" :before-upload="beforeAvatarUpload" name="file">
                    <img v-if="userInfoForm.avatar" :src="userInfoForm.avatar" class="avatar" />
                    <el-icon v-else class="avatar-uploader-icon">
                      <Plus />
                    </el-icon>
                  </el-upload>
                </el-form-item>

                <el-form-item label="昵称">
                  <el-input v-model="userInfoForm.name" />
                </el-form-item>
                <el-form-item label="邮箱">
                  <el-input v-model="userInfoForm.email" />
                </el-form-item>
                <el-form-item>
                  <el-button type="primary" @click="submitUpdate">保存修改</el-button>
                </el-form-item>
              </el-form>
            </el-tab-pane>

          </el-tabs>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<style scoped>
.center-container {
  max-width: 1100px;
  margin: 30px auto;
  padding: 0 15px;
}

.user-header {
  text-align: center;
  padding: 20px 0;
}

.reg-time {
  font-size: 12px;
  color: #999;
  margin-top: 5px;
}

.right-card {
  min-height: 600px;
}

.list-item {
  display: flex;
  justify-content: space-between;
  padding: 15px;
  border-bottom: 1px solid #eee;
  cursor: pointer;
}

.list-item:hover {
  background-color: #f9f9f9;
}

.item-title {
  font-weight: bold;
  color: #333;
}

.item-date {
  font-size: 12px;
  color: #999;
}

/* 头像上传样式 */
.avatar-uploader .el-upload {
  border: 1px dashed var(--el-border-color);
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
  transition: var(--el-transition-duration-fast);
}

.avatar-uploader .el-upload:hover {
  border-color: var(--el-color-primary);
}

.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 100px;
  height: 100px;
  text-align: center;
  line-height: 100px;
}

.avatar {
  width: 100px;
  height: 100px;
  display: block;
}

/* 【新增】鼠标悬停效果 */
.log-content:hover {
  color: #409EFF !important;
  text-decoration: underline;
}
</style>
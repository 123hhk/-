<script setup>
import Top from "@/components/Top.vue";
import { reactive, inject, onMounted, ref, watch } from 'vue'
import { ElMessageBox } from 'element-plus'
import { dateFormat } from "@/js/tool.js";
import { Search, Refresh, Loading } from '@element-plus/icons-vue'

const data = reactive({
  articleCondition: {
    title: "",
    startDate: "",
    endDate: ""
  },
  pageParams: {
    page: 1,
    rows: 5,
    total: 0
  }
})

let myData = reactive({
  articleVOs: [],
})

const axios = inject('axios')
const loading = ref(false)

// 页面加载时自动查询一次
onMounted(() => {
  search()
})

// 防抖函数
function debounce(fn, delay) {
  let timer = null;
  return function () {
    if (timer) {
      clearTimeout(timer)
    }
    timer = setTimeout(() => {
      fn.apply(this, arguments)
    }, delay)
  }
}

// 监听搜索关键词
watch(
  () => data.articleCondition.title,
  debounce((newVal) => {
    data.pageParams.page = 1
    doSearch()
  }, 500)
)

function search() {
  if (data.pageParams.page === 1) {
    doSearch()
  } else {
    data.pageParams.page = 1
    doSearch()
  }
}

function doSearch() {
  loading.value = true
  axios({
    method: 'post',
    url: '/api/article/articleSearch',
    data: data
  }).then((response) => {
    if (response.data.success) {
      myData.articleVOs = response.data.map.articleVOs || []
      data.pageParams.total = response.data.map.pageParams?.total || 0
    } else {
      console.warn(response.data.msg || '查询失败')
      myData.articleVOs = []
      data.pageParams.total = 0
    }
  }).catch((error) => {
    console.error("查询错误:", error)
    myData.articleVOs = []
    data.pageParams.total = 0
  }).finally(() => {
    loading.value = false
  })
}

function handleCurrentChange(page) {
  data.pageParams.page = page
  doSearch()
}

function handleSizeChange(rows) {
  data.pageParams.rows = rows
  data.pageParams.page = 1
  doSearch()
}

function clearSearch() {
  data.articleCondition.title = ""
  data.articleCondition.startDate = ""
  data.articleCondition.endDate = ""
  data.pageParams.page = 1
  doSearch()
}
</script>

<template>
  <el-affix>
    <Top />
  </el-affix>

  <el-row justify="center" style="margin-top:30px">
    <el-col :span="12">
      <el-input v-model="data.articleCondition.title" placeholder="请输入文章标题关键字" clearable>
        <template #prefix>
          <el-icon>
            <Search />
          </el-icon>
        </template>
        <template #suffix v-if="loading">
          <el-icon class="is-loading">
            <Loading />
          </el-icon>
        </template>
      </el-input>
    </el-col>
  </el-row>

  <el-row justify="center" style="margin-top:15px">
    <el-col :span="12">
      <el-space :size="40">
        <el-date-picker value-format="YYYY-MM-DD" v-model="data.articleCondition.startDate" type="date"
          placeholder="起始日期" />
        <el-date-picker value-format="YYYY-MM-DD" v-model="data.articleCondition.endDate" type="date"
          placeholder="结束日期" />
        <el-button type="primary" @click="search" :loading="loading">
          <el-icon v-if="!loading">
            <Search />
          </el-icon>
          开始查询
        </el-button>
        <el-button @click="clearSearch" :disabled="loading">
          <el-icon>
            <Refresh />
          </el-icon>
          重置
        </el-button>
      </el-space>
    </el-col>
  </el-row>

  <el-row>
    <el-col :span="1"></el-col>
    <el-col :span="22">
      <div v-if="loading" style="margin-bottom: 10px; color: #409EFF;">
        <el-icon class="is-loading">
          <Loading />
        </el-icon>
        正在查询中...
      </div>
      <div v-else-if="data.pageParams.total > 0" style="margin-bottom: 10px; color: #666;">
        共找到 {{ data.pageParams.total }} 条记录
      </div>
      <div v-else-if="data.articleCondition.title || data.articleCondition.startDate || data.articleCondition.endDate"
        style="margin-bottom: 10px; color: #999;">
        未找到符合条件的记录
      </div>
      <div v-else style="margin-bottom: 10px; color: #999;">
        请输入查询条件
      </div>

      <el-table :data="myData.articleVOs" stripe border style="width: 100%" v-loading="loading" empty-text="暂无数据">
        <el-table-column prop="categories" label="所属分类" width="150" />
        <el-table-column label="文章标题" width="800">
          <template #default="scope">
            <router-link :to="{ path: '/article_comment/' + scope.row.id }"
              style="text-decoration: none; color: #1890ff;" class="article-title">
              {{ scope.row.title }}
            </router-link>
          </template>
        </el-table-column>
        <el-table-column label="发布时间" width="170">
          <template #default="scope">
            {{ dateFormat(scope.row.created, 'yyyy-MM-dd HH:mm:ss') }}
          </template>
        </el-table-column>
        <el-table-column prop="hits" label="点击量" width="100" />
      </el-table>

      <div v-if="data.pageParams.total > 0 && !loading" style="margin-top: 20px; text-align: center;">
        <el-pagination v-model:current-page="data.pageParams.page" v-model:page-size="data.pageParams.rows"
          :page-sizes="[5, 10, 15, 20]" :total="data.pageParams.total" layout="total, sizes, prev, pager, next, jumper"
          @size-change="handleSizeChange" @current-change="handleCurrentChange" :disabled="loading" />
      </div>
    </el-col>
    <el-col :span="1"></el-col>
  </el-row>
</template>

<style scoped>
.article-title:hover {
  text-decoration: underline;
  color: #10007A;
}

:deep(.el-pagination) {
  justify-content: center;
}

:deep(.el-table .cell) {
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}
</style>
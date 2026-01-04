<script setup>
import { reactive, inject, ref } from 'vue'
import { ElMessage } from 'element-plus'
import { Delete, Back, Document } from '@element-plus/icons-vue'

const axios = inject('axios')

// 数据状态
let myData = reactive({
  "comments": [],
  "pageParams": {
    "page": 1,
    "rows": 10,
    "total": 0,
    "author": "" // 【新增】默认为空串
  },
  "isFilterMode": false,
  "filterAuthor": ""
})

// ==========================================
// 【核心修复】数据标准化适配器
// 仿照父页面的数据格式，修正子页面的字段名差异
// ==========================================
function fixData(commentList) {
  if (!commentList || !Array.isArray(commentList)) {
    return []
  }

  return commentList.map(item => {
    // 1. 修正文章ID (如果后端返回了 article_id 但没返回 articleId)
    if (!item.articleId && item.article_id) {
      item.articleId = item.article_id
    }

    // ============================================================
    // 【修复逻辑开始】解决点击发布人筛选后，"所属文章"显示错误的BUG
    // ============================================================

    // 问题分析：在"回复(Reply)"数据中，后端往往把 targetName 设为"被回复的父评论内容"。
    // 解决方案：我们强制优先查找 articleTitle (文章标题) 并赋值给 targetName。

    if (item.articleTitle) {
      // 如果后端数据里有 articleTitle，直接用它覆盖 targetName
      item.targetName = item.articleTitle
    } else if (item.title) {
      // 如果后端数据里有 title (通常也是指文章标题)，也覆盖 targetName
      item.targetName = item.title
    }

    // 如果上面两个字段都没有，才保留原有的 targetName (兜底逻辑)
    // (代码逻辑：如果 item.targetName 已存在且上面没覆盖，它就保持原样)

    // 补充：为了防止某些极端情况 targetName 依然为空，尝试再次赋值
    if (!item.targetName && item.articleTitle) {
      item.targetName = item.articleTitle
    }

    // ============================================================
    // 【修复逻辑结束】
    // ============================================================

    return item
  })
}

// 1. 获取管理员分页评论列表 (默认模式 - 父页面)
// 统一获取列表接口 (支持分页 + 筛选)
function getAPage() {
  // 这里的 myData.pageParams.author 如果有值，后端就会筛选；没值就是查全部
  axios.post('/api/comment/getAdminPage', myData.pageParams)
    .then((response) => {
      if (response.data.success) {
        // 这里依然建议保留 fixData 以防万一，但其实后端 SQL 已经修好了 targetName
        myData.comments = fixData(response.data.map.comments || [])
        if (response.data.map.pageParams) {
          myData.pageParams.total = response.data.map.pageParams.total
        }
      } else {
        myData.comments = []
        ElMessage.warning(response.data.msg || '获取数据失败')
      }
    })
    .catch(() => ElMessage.error("系统错误"))
}

// 点击用户名时的处理函数 (现在的逻辑变简单了)
function getUserComments(author) {
  myData.isFilterMode = true
  myData.filterAuthor = author

  // 1. 设置筛选条件
  myData.pageParams.author = author
  // 2. 重置页码到第一页
  myData.pageParams.page = 1
  // 3. 调用统一接口
  getAPage()
}

// 4. 返回全部列表 (重置筛选条件)
function resetFilter() {
  // 1. 清除筛选模式标记
  myData.isFilterMode = false
  myData.filterAuthor = ""

  // 2. 关键：清空请求参数中的 author
  myData.pageParams.author = ""

  // 3. 重置回第一页
  myData.pageParams.page = 1

  // 4. 重新获取数据
  getAPage()
}


// 初始化加载
getAPage()

// 分页改变处理
function handleSizeChange(newRows) {
  if (myData.isFilterMode) return
  myData.pageParams.rows = newRows
  myData.pageParams.page = 1
  getAPage()
}

function handleCurrentChange(newPage) {
  //if (myData.isFilterMode) return
  myData.pageParams.page = newPage
  getAPage()
}

// 删除逻辑
const dialogVisible = ref(false)
let deleteTarget = reactive({ id: 0, type: 'COMMENT' })

function showDeleteDialog(row) {
  deleteTarget.id = row.id
  deleteTarget.type = row.type || 'COMMENT'
  dialogVisible.value = true
}

function confirmDelete() {
  let url = '/api/comment/deleteById?id=' + deleteTarget.id
  if (deleteTarget.type === 'REPLY') {
    url = '/api/reply/deleteById?id=' + deleteTarget.id
  }

  axios.post(url)
    .then((response) => {
      if (response.data.success) {
        ElMessage.success("删除成功")
        dialogVisible.value = false
        if (myData.isFilterMode) {
          getUserComments(myData.filterAuthor)
        } else {
          getAPage()
        }
      } else {
        ElMessage.error(response.data.msg)
      }
    })
    .catch(() => ElMessage.error("删除失败"))
}
</script>

<template>
  <el-row>
    <el-col :span="24">
      <h4 style="margin-left: 10px; display: flex; align-items: center; gap: 10px;">
        <el-button v-if="myData.isFilterMode" :icon="Back" circle size="small" @click="resetFilter" title="返回所有评论" />
        <span>{{ myData.isFilterMode ? `用户 "${myData.filterAuthor}" 的所有评论` : '评论管理' }}</span>
      </h4>
    </el-col>
  </el-row>

  <el-row>
    <el-col :span="24">
      <el-table :data="myData.comments" stripe border style="width: 100%">
        <el-table-column prop="id" label="ID" width="70" align="center" />

        <el-table-column label="评论内容" min-width="300">
          <template #default="scope">
            <div style="display: flex; align-items: flex-start; gap: 5px;">
              <el-tag size="small" :type="scope.row.type === 'REPLY' ? 'warning' : 'success'" effect="plain">
                {{ scope.row.type === 'REPLY' ? '回复' : '评论' }}
              </el-tag>

              <router-link v-if="scope.row.articleId"
                :to="{ name: 'articleAndComment', params: { articleId: scope.row.articleId } }" class="content-link"
                title="点击前往文章详情">
                {{ scope.row.content }}
              </router-link>

              <span v-else>{{ scope.row.content }}</span>
            </div>
          </template>
        </el-table-column>

        <el-table-column label="发布人" width="130" align="center">
          <template #default="scope">
            <span class="author-link" @click="getUserComments(scope.row.author)" title="点击筛选该用户">
              {{ scope.row.author }}
            </span>
          </template>
        </el-table-column>

        <el-table-column label="所属文章" width="220" :show-overflow-tooltip="true">
          <template #default="scope">
            <router-link v-if="scope.row.articleId"
              :to="{ name: 'articleAndComment', params: { articleId: scope.row.articleId } }"
              style="text-decoration: none; color: #606266; font-size: 13px; display: flex; align-items: center;">
              <el-icon style="margin-right: 4px;">
                <Document />
              </el-icon>
              {{ scope.row.targetName ? `《${scope.row.targetName}》` : ('文章ID: ' + scope.row.articleId) }}
            </router-link>
            <span v-else>无关联文章</span>
          </template>
        </el-table-column>

        <el-table-column prop="created" label="发布时间" width="160" align="center" />

        <el-table-column label="操作" width="100" align="center">
          <template #default="scope">
            <el-button type="danger" link @click="showDeleteDialog(scope.row)" :icon="Delete">
              删除
            </el-button>
          </template>
        </el-table-column>
      </el-table>
    </el-col>
  </el-row>

  <el-row v-if="!myData.isFilterMode" justify="center" align="middle" style="margin-top: 20px;">
    <el-col :span="24" style="text-align: center;">
      <el-pagination v-model:current-page="myData.pageParams.page" v-model:page-size="myData.pageParams.rows"
        :page-sizes="[5, 10, 20, 50]" layout="total, sizes, prev, pager, next, jumper" :total="myData.pageParams.total"
        @size-change="handleSizeChange" @current-change="handleCurrentChange" />
    </el-col>
  </el-row>

  <el-dialog v-model="dialogVisible" title="警告" width="300px" center>
    <div style="text-align: center;">
      <el-icon color="#F56C6C" size="24px">
        <Delete />
      </el-icon>
      <p>确定要删除这条{{ deleteTarget.type === 'REPLY' ? '回复' : '评论' }}吗？</p>
      <p style="font-size: 12px; color: #999;">操作不可恢复</p>
    </div>
    <template #footer>
      <span class="dialog-footer">
        <el-button @click="dialogVisible = false" size="small">取消</el-button>
        <el-button type="danger" @click="confirmDelete" size="small">确定删除</el-button>
      </span>
    </template>
  </el-dialog>
</template>

<style scoped>
.content-link {
  text-decoration: none;
  color: #606266;
  transition: color 0.2s;
  overflow: hidden;
  text-overflow: ellipsis;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
}

.content-link:hover {
  color: #409EFF;
  text-decoration: underline;
  cursor: pointer;
}

.author-link {
  cursor: pointer;
  color: #409EFF;
  font-weight: 500;
}

.author-link:hover {
  text-decoration: underline;
  color: #66b1ff;
}
</style>
<script setup>
import { reactive, inject, ref } from 'vue'
import { ElMessageBox } from 'element-plus'
import { Edit, Delete } from '@element-plus/icons-vue'
import { nullZeroBlank } from '@/js/tool.js'
import { useStore } from '@/stores/my.js'
import { storeToRefs } from 'pinia' // 添加这行导入

const store = useStore()

const axios = inject('axios')
let myData = reactive({
  "articleVOs": [],
  "pageParams": { "page": 1, "rows": 4, "total": 0 }
})

function getAPage() {
  if (!nullZeroBlank(store.page.pageParams)) {
    myData.pageParams = store.page.pageParams
  }
  axios({
    method: 'post',
    url: '/api/article/getAPageOfArticleVO',
    data: myData.pageParams
  }).then((response) => {
    if (response.data.success) {
      if (response.data.map.articleVOs != null) {
        myData.articleVOs = response.data.map.articleVOs

        // --- 修复重点：从 pageParams 对象中获取 total ---
        if (response.data.map.pageParams && response.data.map.pageParams.total !== undefined) {
          myData.pageParams.total = response.data.map.pageParams.total
        }
        // ---------------------------------------------

      } else {
        ElMessageBox.alert("无文章！", '结果')
      }
      dialogVisible.value = false
    } else {
      // ...
      ElMessageBox.alert(response.data.msg, '结果')
    }
    store.page.pageParams = null
  }).catch((error) => {
    ElMessageBox.alert("系统错误！", '结果')
    store.page.pageParams = null
  })
}

getAPage()
function handleSizeChange(newRows) { // 修改每页记录数时，该方法会被调用。newRows由Pagination组件提供。
  myData.pageParams.rows = newRows
  myData.pageParams.page = 1
  getAPage() // 改变每页记录数后，获取并显示第一页内容
}

function handleCurrentChange(newPage) { // 切换页码时，该方法会被调用。newPage由Pagination组件提供。
  myData.pageParams.page = newPage
  getAPage() // 切换页码后，获取新页的记录
}

const editArticle = inject("editArticle")

function editArticle1(articleId) { // 跳转至编辑文章前，将文章id和页码信息保存到状态，
  store.articleId = articleId     // 以便今后能够访问。
  store.page.pageParams = myData.pageParams
  editArticle() // 跳转至编辑文章vue
}

let selectedArticleId
const dialogVisible = ref(false) // 是否显示对话框

function showDialog(articleId) { // 显示对话框
  selectedArticleId = articleId
  dialogVisible.value = true
}

function deleteArticle() { // 删除文章
  axios({
    method: 'post',
    url: '/api/article/deleteById?id=' + selectedArticleId
  }).then((response) => {
    if (response.data.success) {
      getAPage() // 删除成功后，刷新列表
      dialogVisible.value = false // 关闭对话框
    } else {
      ElMessageBox.alert(response.data.msg, '结果')
    }
  }).catch((error) => { // 请求失败返回的数据
    ElMessageBox.alert("系统错误！", '结果')
  })
}
</script>

<template>
  <el-row>
    <el-col :span="24">
      <h4 style="margin-left: 10px;">文章管理</h4>
    </el-col>
  </el-row>
  <el-row>
    <el-col :span="24">
      <el-table :data="myData.articleVOs" stripe border style="width: 100%">
        <el-table-column label="文章标题" width="360">
          <template #default="scope">
            <router-link :to="{ path: '/article_comment/' + scope.row.id }" style="text-decoration: none;">
              {{ scope.row.title }}
            </router-link>
          </template>
        </el-table-column>
        <el-table-column prop="created" label="发布时间" width="170" />
        <el-table-column prop="hits" label="浏览量" width="70" />
        <el-table-column prop="categories" label="所属分类" width="180" />
        <el-table-column label="操作">
          <template #default="scope">
            <el-button type="primary" @click="editArticle1(scope.row.id)" :icon="Edit" size="small">
              编辑
            </el-button>
            <el-button type="danger" @click="showDialog(scope.row.id)" :icon="Delete" size="small">删除</el-button>
          </template>
        </el-table-column>
      </el-table>
    </el-col>
  </el-row>
  <el-row justify="center" align="middle" style="height: 60px">
    <el-col :span="16">
      <el-pagination v-model:current-page="myData.pageParams.page" v-model:page-size="myData.pageParams.rows"
        :page-sizes="[2, 4, 10, 20]" layout="total, sizes, prev, pager, next, jumper" :total="myData.pageParams.total"
        @size-change="handleSizeChange" @current-change="handleCurrentChange" :pager-count="7" />
    </el-col>
  </el-row>

  <el-dialog v-model="dialogVisible" title="注意" width="30%" center>
    <span>确定要删除吗？</span>
    <template #footer>
      <span class="dialog-footer">
        <el-button @click="dialogVisible = false">取消</el-button>
        <el-button type="primary" @click="deleteArticle">确定</el-button>
      </span>
    </template> <!-- 点击确定后，才执行真正的删除操作 -->
  </el-dialog>
</template>
<style scoped></style>
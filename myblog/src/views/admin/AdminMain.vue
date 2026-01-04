<script setup>
import { reactive, inject } from 'vue'
import { RouterView, useRoute, useRouter } from 'vue-router'
import { View, DArrowRight } from '@element-plus/icons-vue'
import { provide } from 'vue' // 添加这行导入
import { useStore } from '@/stores/my.js' // 2. 引入 store
import { ElMessageBox } from 'element-plus' // 3. 引入消息提示框
import { Rank } from '@element-plus/icons-vue'

const aside_state = reactive({ collapse: false, width: '200px' })
function toggleCollapse() {
  aside_state.collapse = !aside_state.collapse
  if (aside_state.collapse) {
    aside_state.width = '70px'
  } else {
    aside_state.width = '200px'
  }
}

const router = useRouter()
const store = useStore() // 4. 获取 store 实例
const axios = inject('axios') // 5. 注入 axios

function toHome() {
  router.push('/')
}

function editArticle() { // 跳转至编辑文章
  router.push({ name: 'publishArticle' })
}
provide("editArticle", editArticle)

function gotoArticleManage() { // 跳转至管理文章（文章列表）
  router.push({ name: "manageArticle" })
}
provide("gotoArticleManage", gotoArticleManage)
// 6. 新增：退出登录函数 (模仿 Top.vue 的逻辑)
function toExit() {
  axios({
    method: 'post',
    url: '/api/logout' // 与 SecurityConfig 配置的注销 URL 一致
  }).then((response) => {
    // 提示退出成功
    ElMessageBox.alert(response.data.msg, '结果', {
      confirmButtonText: '确定',
      callback: () => {
        store.user.user = null // 清空 Pinia 中的用户信息
        router.push({ name: 'login' }) // 跳转回登录页面 (或者跳转回首页 '/')
      }
    })
  }).catch((error) => {
    ElMessageBox.alert("系统错误！", '结果')
  })
}
</script>

<template>
  <el-container>
    <el-aside width="aside_state.width">
      <el-row>
        <el-col class="left-top" @click="toHome" style="cursor: pointer;">
          <img src="@/assets/bloglogo.jpg" width="50" height="50" />
          <span v-if="!aside_state.collapse" class="big-text">MyBlog</span>
        </el-col>
      </el-row>
      <el-row>
        <el-col>
          <el-menu router active-text-color="white" background-color="#545c64" text-color="#fff"
            :collapse="aside_state.collapse" :collapse-transition="false">
            <el-menu-item>
              <el-icon>
                <Odometer />
              </el-icon>
              <span>仪表盘</span>
            </el-menu-item>
            <el-menu-item index="/admin_Main/publish_article">
              <el-icon>
                <Edit />
              </el-icon>
              <span>发布文章</span>
            </el-menu-item>
            <el-menu-item index="/admin_Main/manage_article">
              <el-icon>
                <Memo />
              </el-icon>
              <span>文章管理</span>
            </el-menu-item>
            <!--评论管理功能-->
            <el-menu-item index="/admin_Main/manage_comment">
              <el-icon>
                <ChatDotSquare />
              </el-icon>
              <span>评论管理</span>
            </el-menu-item>
            <el-menu-item index="/admin/manageCategory">
              <el-icon>
                <Filter />
              </el-icon>
              <span>标签分类</span>
            </el-menu-item>
            <el-menu-item>
              <el-icon>
                <Setting />
              </el-icon>
              <span>系统设置</span>
            </el-menu-item>
          </el-menu>
        </el-col>
      </el-row>
    </el-aside>
    <el-main style="padding:0">
      <!-- 修改后的顶部栏 -->
      <el-row align="middle" style="height:70px; padding: 0 20px;" justify="space-between">
        <el-col :span="4">
          <span @click="toggleCollapse" class="toggle-menu">
            <el-icon :size="30">
              <Fold v-if="!aside_state.collapse" />
              <Expand v-if="aside_state.collapse" />
            </el-icon>
          </span>
        </el-col>
        <el-col :span="4" style="display: flex; justify-content: flex-end;">
          <el-dropdown trigger="click" style="cursor: pointer;">
            <span class="el-dropdown-link">
              <img class="img-circle" src="@/assets/me.jpg" />
            </span>
            <template #dropdown>
              <el-dropdown-menu>
                <el-dropdown-item :icon="View" style="color: black">查看网站</el-dropdown-item>
                <el-dropdown-item :icon="DArrowRight" style="color: black" @click="toExit">用户注销</el-dropdown-item>
                <el-dropdown-item @click="$router.push('/personal_center')">个人中心</el-dropdown-item>
              </el-dropdown-menu>
            </template>
          </el-dropdown>
        </el-col>
      </el-row>
      <el-row>
        <el-col>
          <RouterView />
        </el-col>
      </el-row>
    </el-main>
  </el-container>
</template>

<style scoped>
.img-circle {
  border-radius: 50%;
  height: 36px;
  width: 36px;
}

.toggle-menu {
  margin-left: 5px;
  color: darkgray;
}

.toggle-menu:hover {
  color: black;
  cursor: pointer;
}

.big-text {
  font-size: 28px;
  margin-left: 10px;
  color: black;
}

.left-top {
  display: flex;
  align-items: center;
  justify-content: center;
  height: 70px;
  background-color: #eee;
}
</style>
<script setup>
import { RouterView, useRouter } from 'vue-router'
import { provide, onMounted } from 'vue'
import { useStore } from './stores/my'
// 引入刚才修好的 tool.js，现在它有默认导出了，不会报错了
import request from './js/tool'

const router = useRouter()
const store = useStore() // 初始化 Store

// --- 【修复假登录的核心代码】 ---
// 每次刷新页面时，自动去后端问一下：我的登录还在吗？
onMounted(async () => {
  // 1. 如果前端缓存里显示"已登录" (store.user.user 存在)
  if (store.user.user) {
    try {
      console.log('正在校验登录状态...')
      // 2. 发请求给后端验证
      let result = await request.get('/user/currentUser')

      // 注意：axios 返回的数据在 result.data 里
      if (result.data && result.data.success) {
        // A. 后端确认有效：更新一下 store (防止昵称变了没刷新)
        store.login(result.data.map.user)
        console.log('登录校验通过')
      } else {
        // B. 后端说无效：说明 Session 过期了，这是"假登录"
        console.log('登录已过期，自动退出')
        store.logout()
        // 只有在需要强制跳转回登录页时才开下面这行，否则就在当前页变成未登录状态
        // router.push({ name: 'login' }) 
      }
    } catch (error) {
      // C. 报错（如网络错误、403等）：也视为无效
      console.log('验证失败，自动退出', error)
      store.logout()
    }
  }
})
// ------------------------------

//router.push({ name: 'home' })

const toHome = () => {
  router.push({ name: 'home' })
}

const toLogin = () => {
  router.push({ name: 'login' })
}

const toAdminMain = () => {
  router.push({ name: 'adminMain' })
}

function toArticle() {
  router.push({ name: 'articleAndComment', params: { articleId: 20 } })
}

provide('toAdminMain', toAdminMain)
provide('toArticle', toArticle)
provide('toHome', toHome)
provide('toLogin', toLogin)
</script>

<template>
  <RouterView />
</template>

<style scoped></style>
<script setup>
import { ref, inject, onMounted, onUnmounted } from 'vue'
import { useStore } from '@/stores/my'
import { ElMessageBox, ElMessage } from 'element-plus'
import { Search, Bell } from '@element-plus/icons-vue' // 引入 Bell 图标
import { useRouter } from 'vue-router'

const size = ref(30)
const router = useRouter()
const store = useStore()
const axios = inject('axios')
const toLogin = inject("toLogin")
const toHome = inject("toHome")
const toAdminMain = inject('toAdminMain')

const userName = ref("")
const isLogined = ref(false)
const unreadCount = ref(0) // 未读消息数
const notificationList = ref([]) // 消息列表

// 检查是否已登录
if (store.user.user != null) {
  userName.value = "hi " + store.user.user.username
  isLogined.value = true
}

// === 新增：获取未读数 ===
function getUnreadCount() {
  if (!isLogined.value) return
  axios.get('/api/notification/unreadCount').then(res => {
    if (res.data.success) {
      unreadCount.value = res.data.map.count
    }
  })
}

// === 新增：获取消息列表 ===
function getNotifications() {
  if (!isLogined.value) return
  axios.get('/api/notification/list').then(res => {
    if (res.data.success) {
      notificationList.value = res.data.map.list
    }
  })
}

// === 新增：一键已读 ===
function markAllRead() {
  axios.post('/api/notification/markAllRead').then(res => {
    unreadCount.value = 0
    // 将列表里的状态也改为已读
    notificationList.value.forEach(item => item.isRead = true)
  })
}

// === 新增：定时轮询未读数 (可选，比如每30秒查一次) ===
let timer = null
onMounted(() => {
  if (isLogined.value) {
    getUnreadCount()
    // timer = setInterval(getUnreadCount, 30000) 
  }
})
onUnmounted(() => {
  if (timer) clearInterval(timer)
})

function toExit() {
  axios({
    method: 'post',
    url: '/api/logout'
  }).then((response) => {
    ElMessageBox.alert(response.data.msg, '结果')
    store.user.user = null
    isLogined.value = false
    userName.value = ""
    toHome()
  }).catch((error) => {
    ElMessageBox.alert("系统错误！", '结果')
  })
}

function goToLogin() {
  if (toLogin) {
    toLogin()
  } else {
    router.push('/login')
  }
}
</script>

<template>
  <el-row class="top" align="middle">
    <el-col :span="3"></el-col>
    <el-col :span="12">
      <a @click="toHome">CrazyStone个人博客小站</a>
    </el-col>
    <el-col :span="6">
      <el-space :size="size">

        <el-popover v-if="isLogined" placement="bottom" :width="300" trigger="click" @show="getNotifications">
          <template #reference>
            <el-badge :value="unreadCount" :max="99" :hidden="unreadCount === 0" class="item">
              <el-icon class="searchIcon" :size="20" style="cursor: pointer; margin-top: 5px;">
                <Bell />
              </el-icon>
            </el-badge>
          </template>

          <div class="notification-box">
            <div class="header">
              <span>消息通知</span>
              <el-button link type="primary" size="small" @click="markAllRead">全部已读</el-button>
            </div>
            <el-divider style="margin: 10px 0" />
            <div v-if="notificationList.length === 0" style="text-align: center; color: #999;">暂无消息</div>
            <ul v-else class="msg-list">
              <li v-for="item in notificationList" :key="item.id" :class="{ unread: !item.isRead }">
                <div class="msg-title">
                  <el-tag size="small" :type="item.type === 'COMMENT' ? 'success' : 'warning'">
                    {{ item.type === 'COMMENT' ? '评论' : '回复' }}
                  </el-tag>
                  <span class="sender">{{ item.senderName }}</span>
                </div>
                <div class="msg-content">{{ item.content }}</div>
                <div class="msg-time">{{ item.created }}</div>
              </li>
            </ul>
          </div>
        </el-popover>
        <a @click="goToLogin" v-if="!isLogined">登录</a>
        <a @click="toAdminMain">后台管理</a>
        <a @click="toExit" v-if="isLogined">退出</a>
        <span v-html="userName"></span>
        <router-link title="查询" :to="{ path: '/search' }" style="text-decoration: none;">
          <el-icon>
            <Search class="searchIcon" />
          </el-icon>
        </router-link>
      </el-space>
    </el-col>
    <el-col :span="3"></el-col>
  </el-row>
</template>

<style scoped>
* {
  /* background: #5f9ea0; 注意：Top.vue原本的这个样式可能会影响popover，建议只针对.top设置背景 */
  font-size: 16px;
}

.top {
  background: #5f9ea0;
  /* 移到这里 */
  height: 80px;
  color: #fff;
}

.top a {
  color: #fff;
  text-decoration: none;
  cursor: pointer;
  font-size: 20px;
}

a:hover {
  color: #10007A;
}

.searchIcon {
  color: white;
  /* 修改颜色以适应深色背景 */
}

.searchIcon:hover {
  color: #10007A;
}

/* 消息列表样式 */
.notification-box .header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.msg-list {
  list-style: none;
  padding: 0;
  max-height: 300px;
  overflow-y: auto;
}

.msg-list li {
  padding: 10px 0;
  border-bottom: 1px solid #f0f0f0;
}

.msg-list li.unread .msg-content {
  font-weight: bold;
  color: #333;
}

.msg-title {
  font-size: 12px;
  color: #666;
  margin-bottom: 5px;
}

.sender {
  margin-left: 5px;
  font-weight: bold;
}

.msg-content {
  font-size: 14px;
  color: #666;
  margin-bottom: 5px;
}

.msg-time {
  font-size: 12px;
  color: #999;
}
</style>
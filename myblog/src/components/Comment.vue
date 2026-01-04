<script setup>
import { reactive, ref, inject, onMounted } from 'vue'
import { useStore } from '@/stores/my'
import { ElMessage } from 'element-plus'
import { dateFormat } from '../js/tool' // 确保你的 tool.js 有这个方法

// 接收父组件传递的参数
const props = defineProps(['comment', 'floor'])

const store = useStore()
const axios = inject('axios')

// --- 子评论(回复)相关数据 ---
const replies = ref([])
const replyPage = ref(1)
const replyRows = ref(5) // 每页显示几条回复
const replyTotal = ref(0)
const showAllReplies = ref(false) // 是否展开所有回复

// 回复输入框控制
const showReplyInput = ref(false)
const replyContent = ref('')
const replyPlaceholder = ref('回复层主...')
const currentTargetUid = ref(null) // 记录要回复的目标用户ID (null代表回复层主)

// 加载子评论
function loadReplies() {
  // 增加时间戳防止缓存
  axios.get(`/api/reply/getReplies?commentId=${props.comment.id}&page=${replyPage.value}&rows=${replyRows.value}&_t=${new Date().getTime()}`)
    .then(res => {
      if (res.data.success) {
        replies.value = res.data.map.replies || []
        replyTotal.value = res.data.map.total || 0
      }
    })
    .catch(err => console.error("加载回复失败", err))
}

// 展开/折叠回复
function toggleReplies() {
  if (!showAllReplies.value) {
    // 展开：加载更多
    replyRows.value = 100 // 或者设置一个较大的数
    loadReplies()
  } else {
    // 折叠：恢复默认
    replyRows.value = 5
    loadReplies()
  }
  showAllReplies.value = !showAllReplies.value
}

// 点击“回复”按钮 (准备回复)
// targetUser: 目标用户对象 (如果传null，表示回复层主)
function prepareReply(targetUser) {
  // 1. 检查登录
  if (!store.user.user) {
    ElMessage.warning("请先登录！")
    return
  }

  // 2. 设置目标
  if (targetUser) {
    currentTargetUid.value = targetUser.id  // 记录目标ID (后端需要这个字段)
    replyPlaceholder.value = `回复 @${targetUser.username}:`
  } else {
    currentTargetUid.value = null // 回复层主（后端可能默认处理）
    replyPlaceholder.value = `回复 @${props.comment.author}:`
  }

  // 3. 显示输入框
  showReplyInput.value = true
  replyContent.value = ""
}

// 发送回复
function sendReply() {
  if (!replyContent.value.trim()) {
    ElMessage.warning("请输入回复内容")
    return
  }

  let param = {
    content: replyContent.value,
    commentId: props.comment.id,
    userId: store.user.user.id, // 发送者ID
    toUid: currentTargetUid.value // 【关键修复】带上目标用户ID
  }

  axios.post('/api/reply/insert', param)
    .then(res => {
      if (res.data.success) {
        ElMessage.success("回复成功")
        showReplyInput.value = false
        replyContent.value = ""
        // 重新加载回复列表
        loadReplies()
      } else {
        ElMessage.error(res.data.msg || "回复失败")
      }
    })
    .catch(() => ElMessage.error("系统繁忙"))
}

// 初始化加载
onMounted(() => {
  if (props.comment.id) {
    loadReplies()
  }
})
</script>

<template>
  <div class="comment-item">
    <div class="main-comment">
      <div class="user-avatar">
        <img :src="comment.avatar || '/api/images/default.png'" alt="avatar">
      </div>
      <div class="content-box">
        <div class="user-info">
          <span class="username">{{ comment.author }}</span>
          <span class="floor-tag">#{{ floor }}楼</span>
        </div>
        <div class="comment-text">{{ comment.content }}</div>
        <div class="comment-actions">
          <span class="time-text">{{ dateFormat(comment.created, 'yyyy-MM-dd HH:mm:ss') }}</span>
          <span class="location-text" v-if="comment.location" style="margin-left: 10px; color: #999; font-size: 12px;">
            IP属地：{{ comment.location }}
          </span>
          <span class="action-btn" @click="prepareReply(null)">回复</span>
        </div>
      </div>
    </div>

    <div class="sub-reply-container" v-if="replies.length > 0 || showReplyInput">
      <div v-for="reply in replies" :key="reply.id" class="reply-item">
        <div class="reply-line">
          <img class="mini-avatar" :src="reply.avatar || '/api/images/default.png'" />

          <span class="reply-user">{{ reply.username }}</span>

          <span v-if="reply.targetName" style="color: #409EFF; margin: 0 4px; font-size: 12px;">
            回复 @{{ reply.targetName }} :
          </span>
          <span v-else class="reply-colon"> : </span>

          <span class="reply-text">{{ reply.content }}</span>
        </div>

        <div class="reply-actions">
          <span class="time-text">{{ dateFormat(reply.created, 'yyyy-MM-dd HH:mm:ss') }}</span>
          <span class="location-text" v-if="comment.location" style="margin-left: 10px; color: #999; font-size: 12px;">
            IP属地：{{ comment.location }}
          </span>
          <span class="action-btn" @click="prepareReply({ id: reply.userId, username: reply.username })">
            回复
          </span>
        </div>
      </div>

      <div v-if="replyTotal > 5" class="expand-btn" @click="toggleReplies">
        {{ showAllReplies ? '收起回复' : `查看剩余 ${replyTotal - replies.length} 条回复` }}
      </div>

      <div v-if="showReplyInput" class="reply-input-box">
        <el-input v-model="replyContent" :placeholder="replyPlaceholder" size="small" style="margin-bottom: 5px;" />
        <div style="text-align: right;">
          <el-button size="small" @click="showReplyInput = false">取消</el-button>
          <el-button type="primary" size="small" @click="sendReply">发送</el-button>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.comment-item {
  padding: 15px 0;
  border-bottom: 1px solid #f0f0f0;
}

.main-comment {
  display: flex;
  gap: 15px;
}

.user-avatar img {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  object-fit: cover;
}

.content-box {
  flex: 1;
}

.user-info {
  margin-bottom: 5px;
  display: flex;
  justify-content: space-between;
}

.username {
  font-weight: bold;
  color: #333;
  font-size: 14px;
}

.floor-tag {
  color: #999;
  font-size: 12px;
}

.comment-text {
  font-size: 14px;
  line-height: 1.6;
  color: #333;
  margin-bottom: 8px;
  word-break: break-all;
}

.comment-actions {
  font-size: 12px;
  color: #999;
}

.action-btn {
  margin-left: 15px;
  cursor: pointer;
  color: #666;
}

.action-btn:hover {
  color: #409EFF;
}

/* 子回复样式 */
.sub-reply-container {
  margin-top: 10px;
  margin-left: 55px;
  /* 缩进 */
  background-color: #f9f9f9;
  padding: 10px;
  border-radius: 4px;
}

.reply-item {
  margin-bottom: 8px;
  padding-bottom: 8px;
  border-bottom: 1px dashed #eee;
}

.reply-line {
  display: flex;
  align-items: center;
  flex-wrap: wrap;
  font-size: 13px;
  margin-bottom: 4px;
}

.mini-avatar {
  width: 20px;
  height: 20px;
  border-radius: 50%;
  margin-right: 6px;
  vertical-align: middle;
}

.reply-user {
  font-weight: 500;
  color: #333;
}

.reply-text {
  color: #555;
}

.reply-actions {
  font-size: 12px;
  color: #aaa;
  padding-left: 30px;
  /* 对齐文字 */
}

.expand-btn {
  font-size: 12px;
  color: #409EFF;
  cursor: pointer;
  margin-top: 5px;
}

.reply-input-box {
  margin-top: 10px;
  padding: 10px;
  background: #fff;
  border: 1px solid #ebeef5;
  border-radius: 4px;
}
</style>
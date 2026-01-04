<script setup>
import { defineProps, inject } from 'vue'
import { Sugar } from '@element-plus/icons-vue' // 使用糖果图标代替点赞

const props = defineProps(['comment', 'floor'])
const axios = inject('axios')

// === 评论点赞 ===
function likeThisComment() {
  // 如果需要检查登录，可以在这里加 store 判断，或者依赖后端返回错误
  axios.post('/api/comment/likeComment?commentId=' + props.comment.id)
    .then(res => {
      if (res.data.success) {
        if (!props.comment.likes) props.comment.likes = 0;

        if (res.data.msg === "点赞成功") {
          props.comment.likes++;
          // ElMessage.success("点赞 +1");
        } else if (res.data.msg === "取消点赞") {
          props.comment.likes--;
          // ElMessage.info("点赞 -1");
        }
      } else {
        ElMessage.warning(res.data.msg);
      }
    });
}
</script>

<template>
  <el-row>
    <el-col :span="2">
      <el-avatar :size="50" src="https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png" />
    </el-col>
    <el-col :span="22">
      <div class="comment-header">
        <span class="author-name">{{ comment.author || '匿名用户' }}</span>
        <span class="floor">{{ floor }}楼</span>
      </div>

      <div class="comment-content">
        {{ comment.content }}
      </div>

      <div class="comment-footer">
        <span class="time">{{ comment.created }}</span>

        <span v-if="comment.location" class="location">
          IP属地：{{ comment.location }}
        </span>

        <div class="action-right">
          <el-button type="primary" link @click="likeThisComment">
            <el-icon style="margin-right: 4px;">
              <Sugar />
            </el-icon>
            点赞 ({{ comment.likes || 0 }})
          </el-button>
        </div>
      </div>
    </el-col>
  </el-row>
</template>

<style scoped>
.comment-header {
  display: flex;
  justify-content: space-between;
  margin-bottom: 8px;
}

.author-name {
  font-weight: bold;
  color: #333;
  font-size: 14px;
}

.floor {
  color: #999;
  font-size: 12px;
}

.comment-content {
  font-size: 14px;
  color: #666;
  line-height: 1.6;
  margin-bottom: 10px;
}

.comment-footer {
  display: flex;
  align-items: center;
  font-size: 12px;
  color: #999;
}

.time {
  margin-right: 15px;
}

.location {
  margin-right: 15px;
}

.action-right {
  margin-left: auto;
  /* 靠右对齐 */
}
</style>
<script setup>
const props = defineProps(['comment'])
</script>

<template>
  <el-row style="margin-bottom:10px">
    <el-col>
      <div class="comment-header">
        <img class="avatar" src="@/assets/avatars.jpg" />
        <span class="comment-author" v-html="props.comment.author"></span>
      </div>
    </el-col>
  </el-row>
  <el-row style="margin-bottom:10px">
    <el-col class="comment-content">
      <div v-html="props.comment.content"></div>
    </el-col>
  </el-row>
  <el-row style="margin-bottom:10px" justify="end">
    <el-col :span="3">
      <div class="comment-time" v-html="props.comment.created"></div>
    </el-col>
  </el-row>
</template>

<style scoped>
.comment-header {
  display: flex;
  align-items: center;
  gap: 10px;
  /* 头像和姓名之间的间距 */
  height: 40px;
}

.avatar {
  width: 40px;
  height: 40px;
  border: 1px solid #eaeaea;
  border-radius: 50%;
  flex-shrink: 0;
  /* 防止头像被压缩 */
}

.comment-author {
  font-size: 11px;
  color: #5f5f5f;
  white-space: nowrap;
  /* 防止姓名换行 */
  overflow: hidden;
  text-overflow: ellipsis;
  /* 如果姓名太长显示省略号 */
  max-width: 200px;
  /* 限制姓名最大宽度 */
}

.comment-content {
  font-size: 18px;
}

.comment-time {
  font-size: 12px;
  color: #5f5f5f;
}
</style>
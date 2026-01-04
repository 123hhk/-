<script setup>
import Top from '@/components/Top.vue';
import Comment from '@/components/Comment.vue';
import { useRoute } from 'vue-router';
import { inject, reactive } from 'vue';
import { ElMessageBox, ElMessage } from 'element-plus'; // 引入 ElMessage
import { ref, computed, onMounted, watch } from 'vue'
import { useStore } from '@/stores/my'
import { marked } from 'marked'

const route = useRoute();
const axios = inject('axios');
const store = useStore();

// 数据结构
let articleAndComment = reactive({
  "article": { "content": "" },
  "comments": []
});

let pageParams = { "page": 1, "rows": 5 } // 建议每页多一点，比如5条

const noMore = ref(false)
const loading = ref(false)
const disabled = computed(() => loading.value || noMore.value)

const commentContent = ref('')
const canComment = ref(false)

// 过滤有效评论
const validComments = computed(() => {
  return articleAndComment.comments.filter(comment => comment && comment.id)
})

// 监听用户状态，更新权限
watch(() => store.user.user, (newUser) => {
  updateCommentPermission(newUser)
}, { immediate: true })

function updateCommentPermission(user) {
  // 假设只有普通用户 'ROLE_common' 可以评论，或者是管理员也可以？视需求而定
  // 这里保持你原有的逻辑
  if (user && user.authorities && user.authorities[0] == "ROLE_common") {
    canComment.value = true
  } else {
    // 如果管理员也能评论，可以加一个判断 || user.authorities[0] == "ROLE_admin"
    canComment.value = false
  }
}

onMounted(() => {
  loadArticleAndComments()
})

// 加载文章和第一页评论
function loadArticleAndComments() {
  axios({
    method: 'post',
    url: '/api/article/getArticleAndFirstPageCommentByArticleId?articleId=' + route.params.articleId,
    data: pageParams
  }).then((response) => {
    if (response.data.success) {
      if (response.data.map.article != null) {
        articleAndComment.article = response.data.map.article
        articleAndComment.comments = response.data.map.comments || []

        // 检查是否还有更多
        if (!response.data.map.comments || response.data.map.comments.length < pageParams.rows) {
          noMore.value = true;
        }
      } else {
        ElMessageBox.alert("无文章！", '结果')
      }
    } else {
      ElMessageBox.alert(response.data.msg, '结果')
    }
  }).catch((error) => {
    console.error(error)
    ElMessageBox.alert("系统错误！", '结果')
  })
}

// Markdown 解析
const compiledContent = computed(() => {
  return articleAndComment.article.content ? marked.parse(articleAndComment.article.content) : ''
})

// 无限滚动加载更多评论
const load = () => {
  if (loading.value || noMore.value) return

  loading.value = true
  pageParams.page++

  axios({
    method: 'post',
    url: '/api/comment/getAPageCommentByArticleId?articleId=' + route.params.articleId,
    data: pageParams
  }).then((response) => {
    if (response.data.success) {
      let comments = response.data.map.comments
      if (comments && comments.length > 0) {
        articleAndComment.comments.push(...comments) // 使用 spread 语法更简洁
      } else {
        noMore.value = true
      }
    } else {
      ElMessageBox.alert(response.data.msg, '结果')
    }
    loading.value = false
  }).catch(() => {
    loading.value = false
    ElMessageBox.alert("系统错误！", '结果')
  })
}

// 提交评论
function submit() {
  if (!store.user.user) {
    ElMessage.warning("请先登录！")
    return
  }

  if (!commentContent.value.trim()) {
    ElMessage.warning("评论内容不能为空！")
    return
  }

  axios({
    method: 'post',
    url: '/api/comment/insert',
    // 这里的 author 字段虽然传了，但建议后端 controller 里强制覆盖为当前登录用户，更安全
    data: {
      "articleId": route.params.articleId,
      "content": commentContent.value,
      "author": store.user.user.username || store.user.user.name
    }
  }).then((response) => {
    if (response.data.success) {
      ElMessage.success("评论成功")
      commentContent.value = ""

      // --- 关键修复点 ---
      // 1. 后端返回的 Map key 可能是 "Comment" (大写) 或 "comment" (小写)，视 Controller 写法而定
      //    建议先打印看看 response.data.map
      const newComment = response.data.map.Comment || response.data.map.comment

      if (newComment) {
        // 2. 将新评论加入列表头部
        articleAndComment.comments.unshift(newComment)
      } else {
        // 3. 如果没返回对象，这就比较尴尬，只能重新加载列表
        // 重置分页并刷新
        pageParams.page = 1
        noMore.value = false
        articleAndComment.comments = [] // 清空当前列表
        loadArticleAndComments()
      }

    } else {
      ElMessage.error(response.data.msg)
    }
  }).catch(() => {
    ElMessage.error("系统错误")
  })
}
</script>

<template>
  <el-affix>
    <Top />
  </el-affix>

  <el-row>
    <el-col :span="14" :offset="5">
      <h1 style="text-align: center; margin-top: 20px; font-size: 28px;">
        {{ articleAndComment.article.title }}
      </h1>

      <div style="text-align: center; color: #999; margin-bottom: 20px;">
        <span v-if="articleAndComment.article.created">
          发布于: {{ articleAndComment.article.created }}
        </span>
      </div>

      <el-divider />
    </el-col>
  </el-row>

  <el-row>
    <el-col :span="14" :offset="5">
      <div v-html="compiledContent" class="markdown-body"></div>
    </el-col>
  </el-row>

  <el-row style="background-color: #f7f7f7; margin-top: 20px;">
    <el-col :span="14" :offset="5">

      <ul v-infinite-scroll="load" :infinite-scroll-disabled="disabled" class="infinite-list">

        <li class="infinite-list-item" v-if="canComment">
          <el-row>
            <el-col>
              <el-input v-model="commentContent" :autosize="{ minRows: 4 }" type="textarea" placeholder="写下你的评论..."
                maxlength="200" show-word-limit />
            </el-col>
          </el-row>

          <el-row justify="end">
            <el-col :xs="8" :sm="6" :md="4">
              <el-button @click="submit" type="primary" round style="margin-top: 10px;">
                提交评论
              </el-button>
            </el-col>
          </el-row>
        </li>

        <li v-for="(comment, index) in validComments" :key="comment.id" class="infinite-list-item">
          <Comment :comment="comment" :floor="validComments.length - index"></Comment>
        </li>

      </ul>

      <p v-if="loading" style="text-align: center; color: #999;">加载中...</p>
      <p v-if="noMore && validComments.length > 0" style="text-align: center; color: #999; padding-bottom: 20px;">
        没有更多评论了</p>
      <p v-if="validComments.length === 0 && !loading" style="text-align: center; color: #999; padding: 20px;">
        暂无评论，快来抢沙发吧！</p>

    </el-col>
  </el-row>
</template>

<style scoped>
.infinite-list {
  padding: 0;
  margin: 0;
  list-style: none;
}

.infinite-list-item {
  background: #fff;
  margin-bottom: 10px;
  margin-top: 10px;
  padding: 20px;
  border-radius: 4px;
  /* 圆角美化 */
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
  /* 阴影美化 */
}

/* Markdown 样式微调 */
.markdown-body {
  line-height: 1.8;
  color: #333;
}

.markdown-body img {
  max-width: 100%;
}
</style>
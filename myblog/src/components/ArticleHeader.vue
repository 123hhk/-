<script setup>
import { defineProps, inject } from 'vue'
// 【新增】引入 Loading 和 Picture 图标
import { Calendar, User, LocationInformation, Loading, Picture } from '@element-plus/icons-vue'

const props = defineProps(['article'])
const toArticle = inject('toArticle')

function gotoArticle() {
  toArticle(props.article)
}
</script>

<template>
  <el-card class="article-card" shadow="hover" @click="gotoArticle">
    <div class="card-content">
      <div class="thumbnail-wrapper" v-if="article.thumbnail">
        <el-image :src="article.thumbnail" fit="cover" class="thumbnail" lazy>

          <template #placeholder>
            <div class="image-slot loading-slot">
              <el-icon class="is-loading">
                <Loading />
              </el-icon>
              <span style="margin-left: 5px; font-size: 12px;">加载中...</span>
            </div>
          </template>

          <template #error>
            <div class="image-slot error-slot">
              <el-icon>
                <Picture />
              </el-icon>
            </div>
          </template>

        </el-image>
      </div>

      <div class="info-wrapper">
        <h3 class="title">{{ article.title }}</h3>

        <p class="summary">
          {{ article.content ? article.content.replace(/<[^>]+>/g, '').substring(0, 120) + '...' : '暂无摘要' }}
        </p>

        <div class="meta-footer">
          <div class="meta-left">
            <el-tag size="small" type="info" effect="plain" class="meta-tag">
              <el-icon>
                <Calendar />
              </el-icon> 发布于: {{ article.created }}
            </el-tag>

            <el-tag v-if="article.location" size="small" type="success" effect="plain" class="meta-tag">
              <el-icon>
                <LocationInformation />
              </el-icon> {{ article.location }}
            </el-tag>
          </div>

          <div class="meta-right">
            <span class="author">
              <el-icon>
                <User />
              </el-icon> {{ article.author || '匿名' }}
            </span>
          </div>
        </div>
      </div>
    </div>
  </el-card>
</template>

<style scoped>
.article-card {
  margin-bottom: 20px;
  cursor: pointer;
  transition: all 0.3s;
}

.article-card:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

.card-content {
  display: flex;
  height: 160px;
}

.thumbnail-wrapper {
  width: 240px;
  margin-right: 20px;
  flex-shrink: 0;
  overflow: hidden;
  border-radius: 4px;
}

.thumbnail {
  width: 100%;
  height: 100%;
  transition: transform 0.3s;
}

/* === 【新增】占位图样式 === */
.image-slot {
  display: flex;
  justify-content: center;
  align-items: center;
  width: 100%;
  height: 100%;
  color: #fff;
  font-size: 20px;
}

/* 加载中的背景色：你指定的 #5f9ea0 (卡杰特蓝) */
.loading-slot {
  background-color: #5f9ea0;
}

/* 加载失败的背景色：淡灰色 */
.error-slot {
  background-color: #f5f7fa;
  color: #909399;
}

.article-card:hover .thumbnail {
  transform: scale(1.05);
}

.info-wrapper {
  flex: 1;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
}

.title {
  margin: 0 0 10px 0;
  font-size: 20px;
  color: #303133;
  font-weight: bold;
}

.title:hover {
  color: #409EFF;
}

.summary {
  font-size: 14px;
  color: #606266;
  line-height: 1.6;
  margin: 0;
  flex: 1;
  overflow: hidden;
  text-overflow: ellipsis;
  display: -webkit-box;
  -webkit-line-clamp: 3;
  -webkit-box-orient: vertical;
}

.meta-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-top: 10px;
  padding-top: 10px;
  border-top: 1px dashed #eee;
}

.meta-left {
  display: flex;
  gap: 10px;
}

.meta-right {
  font-size: 14px;
  color: #606266;
  font-weight: bold;
}

.author {
  display: flex;
  align-items: center;
  gap: 4px;
}
</style>
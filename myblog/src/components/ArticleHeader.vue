<script setup>
import { dateFormat } from "@/js/tool.js"
import { ref, computed } from 'vue'

const props = defineProps(['article'])
const size = ref(40)

const formatDate = (dateInput) => {
  if (!dateInput) return '未知日期'
  try {
    let date
    if (typeof dateInput === 'number' || /^\d+$/.test(dateInput)) {
      const timestamp = typeof dateInput === 'number' ? dateInput : parseInt(dateInput)
      if (timestamp.toString().length === 10) {
        date = new Date(timestamp * 1000)
      } else {
        date = new Date(timestamp)
      }
    } else {
      date = new Date(dateInput)
    }
    if (isNaN(date.getTime())) return '无效日期'
    return dateFormat(date, 'yyyy-MM-dd HH:mm:ss')
  } catch (error) {
    return '日期错误'
  }
}

const formattedDate = computed(() => {
  return formatDate(props.article.created)
})
</script>

<template>
  <el-row>
    <el-col :sm="24" :md="11">
      <el-image :src="props.article.thumbnail" />
    </el-col>
    <el-col :sm="0" :md="1"></el-col>
    <el-col :sm="24" :md="12">
      <el-row align="middle">
        <el-space :size="size">
          <span id="categories" class="categories-height" v-html="props.article.categories"></span>

          <span class="categories-height" v-if="props.article.authorName">
            <el-icon style="vertical-align: middle; margin-right: 2px">
              <User />
            </el-icon>
            {{ props.article.authorName }}
          </span>

          <span class="categories-height">发布于 {{ formattedDate }}</span>
        </el-space>
      </el-row>
      <el-row align="middle">
        <router-link :to="{ name: 'articleAndComment', params: { articleId: props.article.id } }" class="title-link">
          <span class="title" v-html="props.article.title"></span>
        </router-link>
      </el-row>
      <el-row align="middle">
        <span v-if="props.article.content" v-html="props.article.content.substring(0, 90)"></span>
        <span v-else style="color: #999; font-size: 14px;">(暂无摘要)</span>
      </el-row>
    </el-col>
    <el-col :span="1"></el-col>
  </el-row>
  <el-divider />
</template>

<style scoped>
#categories:hover {
  color: #10007A;
}

.categories-height {
  line-height: 40px;
}

.title {
  color: #0f9ae0;
  font-size: 20px;
  line-height: 40px;
}

.title-link {
  text-decoration: none;
}

.title-link:hover .title {
  color: #10007A;
  cursor: pointer;
}
</style>
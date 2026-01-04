<script setup>
import { defineProps, inject } from 'vue'

// 接收父组件传来的排行榜数据
const props = defineProps(['articleVOs'])
const toArticle = inject('toArticle')

function gotoArticle(article) {
    toArticle(article)
}
</script>

<template>
    <el-card shadow="never" class="ranking-card">
        <div v-for="(article, index) in articleVOs" :key="article.id" class="item">
            <div class="rank-num" :class="{ 'top3': index < 3 }">{{ index + 1 }}</div>
            <div class="content" @click="gotoArticle(article)">
                <div class="title">{{ article.title }}</div>
                <div class="likes">
                    <el-icon>
                        <StarFilled />
                    </el-icon> {{ article.likes || 0 }} 赞
                </div>
            </div>
        </div>
        <div v-if="!articleVOs || articleVOs.length == 0" class="empty">暂无排行数据</div>
    </el-card>
</template>

<style scoped>
/* 这里可以复用 ReadRanking 的样式，或者简单写一下 */
.item {
    display: flex;
    align-items: center;
    margin-bottom: 12px;
    cursor: pointer;
}

.rank-num {
    width: 24px;
    height: 24px;
    text-align: center;
    line-height: 24px;
    background: #eee;
    border-radius: 4px;
    margin-right: 10px;
    font-size: 12px;
    color: #666;
}

.top3 {
    background: #ff9800;
    /* 前三名橙色 */
    color: #fff;
}

.content {
    flex: 1;
    overflow: hidden;
}

.title {
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    font-size: 14px;
}

.title:hover {
    color: #409EFF;
}

.likes {
    font-size: 12px;
    color: #999;
    margin-top: 2px;
}

.empty {
    text-align: center;
    color: #999;
    padding: 10px;
}
</style>
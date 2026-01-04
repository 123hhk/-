<script setup>
import { reactive, watch } from 'vue'

const props = defineProps(['articleVOs'])
let rankings = reactive([])

/*
 * 监听 props.articleVOs 的变化
 * 当对象发生变化时，vue会自动调用此方法
 */
watch(() => props.articleVOs, (newValue, oldValue) => {
    rankings.length = 0

    // 添加空值检查
    if (!newValue || !Array.isArray(newValue)) {
        return
    }

    for (let index = 0; index < newValue.length; index++) {
        // 添加属性存在性检查
        if (newValue[index] && newValue[index].title) {
            // 修改点：这里不再存字符串，而是存对象，以便在模板中分别处理
            rankings.push({
                index: index + 1,
                id: newValue[index].id,
                title: newValue[index].title,
                hits: newValue[index].hits || 0
            })
        }
    }
})
</script>

<template>
    <div class="read-ranking-container">
        <el-row v-for="item in rankings" :key="item.id">
            <el-col :span="24">
                <span>{{ item.index }}、</span>

                <router-link :to="{ name: 'articleAndComment', params: { articleId: item.id } }"
                    class="ranking-title-link">
                    {{ item.title }}
                </router-link>

                <span> {{ item.hits }}</span>

                <el-divider class="divider" />
            </el-col>
        </el-row>

        <el-row v-if="rankings.length === 0">
            <el-col :span="24">
                <div style="text-align: center; color: #999; padding: 20px;">
                    暂无排行数据
                </div>
            </el-col>
        </el-row>
    </div>
</template>

<style scoped>
.read-ranking-container {
    margin-bottom: 20px;
}

.divider {
    margin-top: 8px;
    margin-bottom: 8px
}

/* 链接基础样式：去除下划线，使用默认文字颜色 */
.ranking-title-link {
    text-decoration: none;
    color: inherit;
    cursor: pointer;
}

/* 鼠标悬停时变色 */
.ranking-title-link:hover {
    color: #10007A;
}
</style>
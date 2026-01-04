<script setup>
import { ref, onMounted, inject } from 'vue'
import * as echarts from 'echarts' // 引入 ECharts
import { DataAnalysis, View, ChatLineRound, Trophy } from '@element-plus/icons-vue' // 引入图标

const axios = inject('axios')

// 数据卡片
const stats = ref({
    totalArticles: 0,
    totalHits: 0,
    totalComments: 0
})

// 图表 DOM 引用
const pieChartRef = ref(null)
const radarChartRef = ref(null)

function initCharts(data) {
    // === 1. 初始化饼图 (分类占比) ===
    const pieChart = echarts.init(pieChartRef.value)
    const pieOption = {
        title: {
            text: '创作分类分布',
            left: 'center'
        },
        tooltip: {
            trigger: 'item'
        },
        legend: {
            orient: 'vertical',
            left: 'left'
        },
        series: [
            {
                name: '文章分类',
                type: 'pie',
                radius: '50%', // 饼图大小
                data: data.categoryStats, // 后端返回的 [{name: 'Java', value: 10}, ...]
                emphasis: {
                    itemStyle: {
                        shadowBlur: 10,
                        shadowOffsetX: 0,
                        shadowColor: 'rgba(0, 0, 0, 0.5)'
                    }
                }
            }
        ]
    }
    pieChart.setOption(pieOption)

    // === 2. 初始化雷达图 (技能分布) ===
    if (data.radarIndicator && data.radarIndicator.length > 0) {
        const radarChart = echarts.init(radarChartRef.value)
        const radarOption = {
            title: {
                text: '热门标签 TOP6',
                left: 'center'
            },
            tooltip: {},
            radar: {
                indicator: data.radarIndicator // [{ name: 'Java', max: 20 }, ...]
            },
            series: [
                {
                    name: '标签频率',
                    type: 'radar',
                    data: [
                        {
                            value: data.radarData,
                            name: '我的技能树'
                        }
                    ],
                    areaStyle: {
                        color: 'rgba(64, 158, 255, 0.2)' // 填充颜色
                    }
                }
            ]
        }
        radarChart.setOption(radarOption)
    }

    // 窗口大小改变时自动重绘
    window.addEventListener('resize', () => {
        pieChart.resize()
        radarChart && radarChart.resize()
    })
}

onMounted(() => {
    // 请求后端聚合数据
    axios.get('/api/statistic/dashboard').then(res => {
        if (res.data.success) {
            const map = res.data.map
            stats.value.totalArticles = map.totalArticles
            stats.value.totalHits = map.totalHits
            stats.value.totalComments = map.totalComments

            // 初始化图表
            initCharts(map)
        }
    })
})
</script>

<template>
    <div class="dashboard-container">
        <el-row :gutter="20" class="stat-cards">
            <el-col :span="8">
                <el-card shadow="hover" class="card-item">
                    <div class="card-content">
                        <el-icon :size="48" color="#409EFF">
                            <DataAnalysis />
                        </el-icon>
                        <div class="text-info">
                            <div class="label">总文章数</div>
                            <div class="value">{{ stats.totalArticles }}</div>
                        </div>
                    </div>
                </el-card>
            </el-col>

            <el-col :span="8">
                <el-card shadow="hover" class="card-item">
                    <div class="card-content">
                        <el-icon :size="48" color="#67C23A">
                            <View />
                        </el-icon>
                        <div class="text-info">
                            <div class="label">总阅读量</div>
                            <div class="value">{{ stats.totalHits }}</div>
                        </div>
                    </div>
                </el-card>
            </el-col>

            <el-col :span="8">
                <el-card shadow="hover" class="card-item">
                    <div class="card-content">
                        <el-icon :size="48" color="#E6A23C">
                            <ChatLineRound />
                        </el-icon>
                        <div class="text-info">
                            <div class="label">总评论数</div>
                            <div class="value">{{ stats.totalComments }}</div>
                        </div>
                    </div>
                </el-card>
            </el-col>
        </el-row>

        <el-row :gutter="20" style="margin-top: 20px;">
            <el-col :xs="24" :sm="12">
                <el-card shadow="hover">
                    <div ref="pieChartRef" style="width: 100%; height: 350px;"></div>
                </el-card>
            </el-col>

            <el-col :xs="24" :sm="12">
                <el-card shadow="hover">
                    <div ref="radarChartRef" style="width: 100%; height: 350px;"></div>
                </el-card>
            </el-col>
        </el-row>

        <el-row style="margin-top: 20px;">
            <el-col :span="24">
                <el-card shadow="never" style="text-align: center; background: #fdf6ec; color: #e6a23c;">
                    <h3><el-icon>
                            <Trophy />
                        </el-icon> 坚持写作是一种修行，继续加油！</h3>
                </el-card>
            </el-col>
        </el-row>
    </div>
</template>

<style scoped>
.dashboard-container {
    padding: 10px;
}

.card-content {
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 10px 20px;
}

.text-info {
    text-align: right;
}

.label {
    color: #909399;
    font-size: 14px;
}

.value {
    font-size: 24px;
    font-weight: bold;
    color: #303133;
    margin-top: 5px;
}
</style>
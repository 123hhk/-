import { createRouter, createWebHistory } from 'vue-router'
import ArticleAndComment from '@/views/admin/ArticleAndComment.vue' // 确保引入了这个组件

// 路由规则单独提取，便于阅读
const routes = [
  // ==============================
  // 公共区域 (首页、登录注册、搜索)
  // ==============================
  {
    path: '/',
    name: 'home',
    component: () => import('@/views/index.vue'),
  },
  {
    path: '/login',
    name: 'login',
    component: () => import('@/views/common/Login.vue'),
  },
  {
    path: '/register',
    name: 'register', // 统一改为小写驼峰
    component: () => import('@/views/common/Register.vue'),
  },
  {
    path: '/search',
    name: 'search',
    component: () => import('@/views/admin/Search.vue'),
  },

  // 文章详情页
  {
    path: '/article_comment/:articleId',
    name: 'articleAndComment',
    component: () => import('@/views/admin/ArticleAndComment.vue'),
  },

  // ==============================
  // 用户中心
  // ==============================
  {
    path: '/personal_center',
    name: 'personalCenter',
    component: () => import('@/views/user/PersonalCenter.vue'),
  },

  // ==============================
  // 后台管理区域 (嵌套路由)
  // ==============================
  {
    path: '/admin_Main',
    name: 'adminMain',
    component: () => import('@/views/admin/AdminMain.vue'),
    redirect: '/admin_Main/dashboard', // 【新增】默认跳到仪表盘

    children: [
      {
        path: 'dashboard', // 子路由路径
        name: 'Dashboard',
        component: () => import('@/views/admin/Dashboard.vue'),
        meta: { title: '数据仪表盘' },
      },
      {
        path: 'publish_article',
        name: 'publishArticle',
        component: () => import('@/views/admin/PublishArticle.vue'),
        meta: { title: '发布文章' }, // 可选：添加meta信息用于面包屑或标题
      },
      {
        path: 'edit_article',
        name: 'editArticle',
        component: () => import('@/views/admin/EditArticle.vue'),
        meta: { title: '编辑文章' },
      },
      {
        path: 'manage_article',
        name: 'manageArticle',
        component: () => import('@/views/admin/ManageArticle.vue'),
        meta: { title: '文章管理' },
      },
      {
        path: 'manage_comment',
        name: 'manageComment',
        component: () => import('@/views/admin/ManageComment.vue'),
        meta: { title: '评论管理' },
      },
      // 在 admin 的 children 数组中添加：
      {
        path: '/admin/manageCategory', // 访问路径
        name: 'ManageCategory',
        component: () => import('../views/admin/ManageCategory.vue'), // 对应刚才创建的文件
        meta: {
          requireAuth: true,
        },
      },
    ],
  },
]

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes,
  // 优化：切换路由时滚动条回到顶部
  scrollBehavior(to, from, savedPosition) {
    if (savedPosition) {
      return savedPosition
    } else {
      return { top: 0 }
    }
  },
})

export default router

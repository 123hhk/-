import { createApp } from 'vue'
import { createPinia } from 'pinia'
import piniaPluginPersistedstate from 'pinia-plugin-persistedstate' // 引入持久化插件

import App from './App.vue'
import router from './router'

/* import the fontawesome core */
import { library } from '@fortawesome/fontawesome-svg-core'
/* import font awesome icon component */
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome'

// 引入图标
import { faWeibo, faGithub } from '@fortawesome/free-brands-svg-icons'
library.add(faWeibo)
library.add(faGithub)

const app = createApp(App)

// 1. 创建 Pinia 实例
const pinia = createPinia()
// 2. 将插件添加到这个实例中
pinia.use(piniaPluginPersistedstate)

app.component('font-awesome-icon', FontAwesomeIcon)

// 3. 【关键修复】使用刚才创建并配置好的 pinia 实例，而不是 createPinia()
app.use(pinia)
app.use(router)

// --- 合并 ElementPlus 的引入 ---
import ElementPlus from 'element-plus'
import 'element-plus/dist/index.css'
import zhCn from 'element-plus/dist/locale/zh-cn.mjs'
import * as ElementPlusIconsVue from '@element-plus/icons-vue'

app.use(ElementPlus, {
  locale: zhCn,
})

for (const [key, component] of Object.entries(ElementPlusIconsVue)) {
  app.component(key, component)
}

// 引入axios和vue-axios
import axios from 'axios'
import VueAxios from 'vue-axios'
app.use(VueAxios, axios)
app.provide('axios', app.config.globalProperties.axios)

import vueCropper from 'vue-cropper'
import 'vue-cropper/dist/index.css'
app.use(vueCropper)

app.mount('#app')

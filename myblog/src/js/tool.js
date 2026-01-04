import axios from 'axios'

// --- 1. 定义 Axios 实例 ---
const request = axios.create({
  // 注意：这里假设你在 vite.config.js 里配置了 /api 代理转发到后端
  // 如果没配置代理，可以直接写 'http://localhost:8080'
  baseURL: '/api',
  timeout: 5000,
})

// 请求拦截器（可以在这里自动带上 token）
request.interceptors.request.use(
  (config) => {
    config.headers['Content-Type'] = 'application/json;charset=utf-8'
    // 如果你有 token 逻辑，可以在这里加，例如：
    // const user = JSON.parse(localStorage.getItem('user'))
    // if (user && user.token) {
    //   config.headers['token'] = user.token
    // }
    return config
  },
  (error) => {
    return Promise.reject(error)
  },
)

// 响应拦截器
request.interceptors.response.use(
  (response) => {
    // 可以在这里统一处理后端返回的错误码
    return response
  },
  (error) => {
    console.log('请求出错：' + error)
    return Promise.reject(error)
  },
)

// --- 2. 原有的工具函数 (保持不变) ---
function undefine(i) {
  if ('undefined' == typeof i) {
    return true
  } else {
    return false
  }
}

function nullZeroBlank(i) {
  if (i == null) return true
  else if (typeof i == 'string') {
    let str = i.replace(/\[\]/g, ' ').trim()
    if (str.length == 0) return true
  } else if (i == 0) return true

  return false
}

function notNullZeroBlank(i) {
  return !nullZeroBlank(i)
}

function dateFormat(dateString, format) {
  try {
    let date = new Date(dateString)
    // 补零函数
    const pad = (n) => (n < 10 ? '0' + n : n)

    if ('yyyy-MM-dd' == format) {
      let dateFormat = date.getFullYear() + '-'
      dateFormat += date.getMonth() + 1 + '-'
      dateFormat += date.getDate()
      return dateFormat
    }
    // 【新增】支持时分秒格式
    else if ('yyyy-MM-dd HH:mm:ss' == format) {
      let str = date.getFullYear() + '-'
      str += pad(date.getMonth() + 1) + '-'
      str += pad(date.getDate()) + ' '
      str += pad(date.getHours()) + ':'
      str += pad(date.getMinutes()) + ':'
      str += pad(date.getSeconds())
      return str
    } else {
      return '无此格式！'
    }
  } catch (e) {
    return '格式转换错误！'
  }
}

// --- 3. 导出 ---
// 【关键】默认导出 request，解决 "does not provide an export named default" 报错
export default request

// 同时也保留命名导出，不影响其他地方引用工具函数
export { undefine, nullZeroBlank, notNullZeroBlank, dateFormat }

<script setup>
import { reactive, ref, inject } from 'vue'
import { ElMessageBox } from 'element-plus'
import { useRouter } from 'vue-router'
import { useStore } from '@/stores/my.js'
import qs from 'qs'

// 【新增】导入背景图片
import backImg from '@/assets/back.jpg'

const router = useRouter()
const store = useStore()
const axios = inject('axios')

const formSize = ref('default')
const ruleFormRef = ref()

// 用户数据模型
const user = reactive({
  username: '',
  password: ''
})

// 表单验证规则
const rules = reactive({
  username: [
    { required: true, message: '请输入用户名！', trigger: 'blur' },
    { min: 2, max: 100, message: '长度3-100', trigger: 'blur' }
  ],
  password: [
    { required: true, message: '请输入密码！', trigger: 'blur' },
    { min: 4, max: 100, message: '长度3-100', trigger: 'blur' },
    {
      pattern: /[A-Za-z0-9_\~\u4e00-\u9fa5]+/,
      message: '请输入正确的密码',
      trigger: ['blur', 'change']
    }
  ]
})

// 跳转到主页
const toHome = () => {
  router.push({ path: '/' })
}

// 跳转到管理页面
const toAdminMain = () => {
  router.push({ path: '/admin_Main' })
}

// 表单提交
const submitForm = async (formEl) => {
  if (!formEl) return

  await formEl.validate((valid, fields) => {
    if (valid) { // 如果通过验证，则可以提交表单数据
      axios({
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        method: 'post',
        url: '/api/login', // 要和服务器端Security设置的登录网址一致
        data: qs.stringify(user)
      }).then((response) => {
        if (response.data.success) {
          store.user.user = response.data.map.user

          // 根据权限跳转到不同页面
          if (response.data.map.user.authorities[0] == "ROLE_common") {
            toHome() // 普通用户跳转到主页
          } else if (response.data.map.user.authorities[0] == "ROLE_admin") {
            toAdminMain() // 管理员用户跳转至管理页面
          }
        } else {
          ElMessageBox.alert(response.data.msg, '结果')
        }
      }).catch((error) => { // 请求失败返回的数据
        ElMessageBox.alert("系统错误！", '结果')
      })
    } else {
      ElMessageBox.alert("验证失败！", '结果')
    }
  })
}

//跳转注册页面
const goToRegister = () => {
  router.push('/register')
}
</script>

<template>
  <div class="log" :style="{ backgroundImage: `url(${backImg})` }">
    <el-row justify="center">
      <el-col :span="10">
        <h1 class="log-title">欢迎登录博客</h1>
      </el-col>
    </el-row>
    <el-row justify="center">
      <el-col :span="8">
        <el-form ref="ruleFormRef" :model="user" status-icon :rules="rules" :size="formSize" label-width="120px">
          <el-form-item label="用户名：" prop="username">
            <el-input v-model="user.username" />
          </el-form-item>
          <el-form-item label="密码：" prop="password">
            <el-input v-model="user.password" type="password" />
          </el-form-item>
          <el-form-item>
            <el-button type="primary" @click="submitForm(ruleFormRef)">登录</el-button>
            <el-button @click="goToRegister">注册</el-button>
          </el-form-item>
        </el-form>
      </el-col>
    </el-row>
    <el-row justify="center">
      <el-col :span="8">
        <p style="margin: 80px; color: #2E203C">
          2022 © Powered By <a style="color: #0e90d2">CrazyStone</a>
        </p>
      </el-col>
    </el-row>
  </div>
</template>

<style scoped>
.log-title {
  font-size: 4rem;
  color: black;
  margin-top: 180px;
}

.log {
  width: 100%;
  height: 100%;
  /* background: url('/src/assets/back.jpg') black no-repeat;  <-- 删除这行 */
  /* background-size: 100% 100%;  <-- 删除这行 */
  background-size: cover;
  /* 建议改成 cover */
  background-position: center;
  background-repeat: no-repeat;
  height: 624px;
}
</style>
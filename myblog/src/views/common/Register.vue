<template>
  <div class="register-container">
    <el-row justify="center">
      <el-col :span="10">
        <h1 class="register-title">用户注册</h1>
      </el-col>
    </el-row>
    <el-row justify="center">
      <el-col :span="8">
        <el-form ref="registerFormRef" :model="registerForm" :rules="registerRules" :size="formSize"
          label-width="120px">
          <el-form-item label="用户名：" prop="username">
            <el-input v-model="registerForm.username" placeholder="请输入用户名" />
          </el-form-item>
          <el-form-item label="邮箱：" prop="email">
            <el-input v-model="registerForm.email" placeholder="请输入邮箱" />
          </el-form-item>
          <el-form-item label="密码：" prop="password">
            <el-input v-model="registerForm.password" type="password" placeholder="请输入密码" />
          </el-form-item>
          <el-form-item label="确认密码：" prop="confirmPassword">
            <el-input v-model="registerForm.confirmPassword" type="password" placeholder="请再次输入密码" />
          </el-form-item>
          <el-form-item>
            <el-button type="primary" @click="submitRegister(registerFormRef)">注册</el-button>
            <el-button @click="goToLogin">返回登录</el-button>
          </el-form-item>
        </el-form>
      </el-col>
    </el-row>
    <el-row justify="center">
      <el-col :span="8">
        <p style="margin-top: 20px; color: #666">
          已有账号？<el-link type="primary" @click="goToLogin">立即登录</el-link>
        </p>
      </el-col>
    </el-row>
  </div>
</template>

<script setup>
import { reactive, ref } from 'vue'
import { ElMessageBox } from 'element-plus'
import { useRouter } from 'vue-router'
import axios from 'axios'

const router = useRouter()
const formSize = ref('default')
const registerFormRef = ref()

const registerForm = reactive({
  username: '',
  email: '',
  password: '',
  confirmPassword: ''
})

// 密码验证函数
const validatePassword = (rule, value, callback) => {
  if (value === '') {
    callback(new Error('请输入密码'))
  } else if (value.length < 6) {
    callback(new Error('密码长度不能小于6位'))
  } else {
    callback()
  }
}

const validateConfirmPassword = (rule, value, callback) => {
  if (value === '') {
    callback(new Error('请再次输入密码'))
  } else if (value !== registerForm.password) {
    callback(new Error('两次输入密码不一致'))
  } else {
    callback()
  }
}

const registerRules = reactive({
  username: [
    { required: true, message: '请输入用户名', trigger: 'blur' },
    { min: 3, max: 20, message: '用户名长度在3到20个字符', trigger: 'blur' }
  ],
  email: [
    { required: true, message: '请输入邮箱地址', trigger: 'blur' },
    { type: 'email', message: '请输入正确的邮箱地址', trigger: ['blur', 'change'] }
  ],
  password: [
    { required: true, validator: validatePassword, trigger: 'blur' }
  ],
  confirmPassword: [
    { required: true, validator: validateConfirmPassword, trigger: 'blur' }
  ]
})

// 提交注册
const submitRegister = async (formEl) => {
  if (!formEl) return

  await formEl.validate(async (valid, fields) => {
    if (valid) {
      try {
        // 只发送必要的字段，不包括确认密码
        const { confirmPassword, ...registerData } = registerForm

        const response = await axios.post('/api/user/register', registerData)

        if (response.data.success) {
          ElMessageBox.alert('注册成功！', '提示', {
            confirmButtonText: '确定',
            callback: () => {
              // 注册成功后跳转到登录页
              router.push('/login')
            }
          })
        } else {
          ElMessageBox.alert(response.data.msg, '错误')
        }
      } catch (error) {
        ElMessageBox.alert('注册失败，请稍后重试', '系统错误')
        console.error('注册错误:', error)
      }
    } else {
      console.log('表单验证失败:', fields)
    }
  })
}

// 跳转到登录页
const goToLogin = () => {
  router.push('/login')
}
</script>

<style scoped>
.register-container {
  padding: 60px 20px;
  min-height: 100vh;
  background-color: #f5f5f5;
}

.register-title {
  font-size: 2.5rem;
  color: #333;
  text-align: center;
  margin-bottom: 40px;
}

.el-form {
  background: white;
  padding: 40px 30px;
  border-radius: 8px;
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
}
</style>
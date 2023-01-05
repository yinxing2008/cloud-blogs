 <!--
 * 厦门大学计算机专业 | 前华为工程师
 * 专注《零基础学编程系列》  http://lblbc.cn/blog
 * 包含：Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
 * 公众号：蓝不蓝编程
 -->
<template>
  <van-nav-bar
    title="登录/注册"
    left-text="返回"
    left-arrow
    @click-left="onClickLeft"
  />

  <div class="container">
    <div class="input-content">
      <van-cell-group class="inputs">
        <van-field placeholder="用户名" v-model="userName" />
        <van-field placeholder="密码" :type="'password'" v-model="password" />
      </van-cell-group>
      <div class="login-row">
        <van-button
          @click="doLogin"
          class="confirm-btn"
          type="primary"
          size="large"
          >登录</van-button
        >
        <van-button
          @click="doRegister"
          class="confirm-btn"
          type="primary"
          size="large"
          >注册</van-button
        >
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { login, register } from '@/api/api'
import { Toast } from 'vant'

const router = useRouter()
const userName = ref('lblbc')
const password = ref('1')

const onClickLeft = () => history.back()

const doLogin = async () => {
  var params = {
    name: userName.value,
    password: password.value
  }
  const resp = await login(params)
  if (resp.code === 0) {
    const token = resp.data.token
    sessionStorage.setItem('token', token)
    router.push('/blog')
  } else {
    Toast.fail(resp.msg)
  }
}

const doRegister = async () => {
  var params = {
    name: userName.value,
    password: password.value
  }
  const resp = await register(params)
  if (resp.code === 0) {
    const token = resp.data.token
    sessionStorage.setItem('token', token)
    router.push('/blog')
  } else {
    Toast.fail(resp.msg)
  }
}

defineExpose({
  userName,
  password
})
</script>

<style>
.container {
  margin-top: 200px;
}

.input-content {
  padding: 0 50px;
}

.login-row {
  display: flex;
  margin-top: 40px;
}

.confirm-btn {
  width: 120px;
  height: 40px;
  border-radius: 2rem;
  margin: 20px auto 0;
  background-color: #418df9;
  color: #fff;
}
</style>

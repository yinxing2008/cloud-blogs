 <!--
 * 厦门大学计算机专业 | 前华为工程师
 * 专注《零基础学编程系列》  http://lblbc.cn/blog
 * 包含：Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
 * 公众号：蓝不蓝编程
 -->
<template>
  <div class="login-warpper">
    <el-form ref="loginForm" :model="form" :rules="rules" label-width="80px" class="login-box">
      <h3 class="login-title">欢迎登录</h3>
      <el-form-item label="账号" prop="username">
        <el-input type="text" placeholder="请输入账号" v-model="form.username"/>
      </el-form-item>
      <el-form-item label="密码" prop="password">
        <el-input type="password" placeholder="请输入密码" v-model="form.password"/>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" v-on:click="submitLogin()">登录</el-button>
        <el-button type="primary" v-on:click="submitRegister()">注册</el-button>
      </el-form-item>
    </el-form>

    <el-dialog title="温馨提示" :visible.sync="dialogVisible" width="30%">
      <span>{{ msg }}</span>
      <span slot="footer" class="dialog-footer">
            <el-button type="primary" @click="dialogVisible = false">确 定</el-button>
        </span>
    </el-dialog>
  </div>
</template>

<script>
import {login, register} from "../api/login";

export default {
  name: "Login",
  data() {
    return {
      form: {
        username: '',
        password: ''
      },
      msg: '',
      // 表单验证，需要在 el-form-item 元素中增加 prop 属性
      rules: {
        username: [{
          required: true,
          message: '账号不可为空',
          trigger: 'blur'
        }],
        password: [{
          required: true,
          message: '密码不可为空',
          trigger: 'blur'
        }]
      },

      // 对话框显示和隐藏
      dialogVisible: false
    }
  },
  methods: {
    async submitLogin() {
      let _this = this;
      login(_this.form).then(res => {
        if (res.data.code === 0) {
          const token = res.data.data.token
          sessionStorage.setItem('user_token', token)
          this.$router.push("/blog/list");
        } else {
          this.msg = res.data.msg;
          this.dialogVisible = true;
          return false;
        }
      }).catch(error => {
        alert('账号或密码错误');
        console.log(error);
      });
    },
    async submitRegister() {
      let _this = this;
      register(_this.form).then(res => {
        if (res.data.code === 0) {
          const token = res.data.data.token
          sessionStorage.setItem('user_token', token)
          this.$router.push("/blog/list");
        } else {
          this.msg = res.data.msg;
          this.dialogVisible = true;
          return false;
        }
      }).catch(error => {
        alert('账号或密码错误');
        console.log(error);
      });
    }
  },
  created() {
    var that = this;
    document.onkeydown = function () {
      var key = window.event.keyCode;
      if (key == 13 || key == 100) {
        that.submitLogin();
      }
    }
  }
}
</script>

<style>
.login-warpper {
  position: absolute;
  background-color: #324057;
  height: 100%;
  width: 100%;
}

.login-box {
  border: 1px solid #DCDFE6;
  width: 350px;
  margin: 15% auto;
  padding: 35px 35px 15px 35px;
  border-radius: 5px;
  -webkit-border-radius: 5px;
  -moz-border-radius: 5px;
  box-shadow: 0 0 25px #909399;
  background: #efefef;
}

.login-title {
  text-align: center;
  margin: 0 auto 40px auto;
  color: #303133;
}
</style>

 <!--
 * 厦门大学计算机专业 | 前华为工程师
 * 专注《零基础学编程系列》  http://lblbc.cn/blog
 * 包含：Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
 * 公众号：蓝不蓝编程
 -->
 <template>
  <el-page-header :icon="ArrowLeft" title="返回" @back="onClickLeft">
    <template #content>
      <span> 登录/注册 </span>
    </template>
  </el-page-header>

  <div class="container">
    <div class="input-content">
      <div class="inputs">
        <el-input v-model="userName" placeholder="用户名" />
        <el-input
          v-model="password"
          type="password"
          placeholder="密码"
          show-password
        />
      </div>
      <div class="login-row">
        <el-button class="confirm-btn" @click="doLogin">登录</el-button>
        <el-button class="confirm-btn" @click="doRegister">注册</el-button>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from "vue";
import { useRouter } from "vue-router";
import { login, register } from "@/api/api";
import { ArrowLeft } from "@element-plus/icons-vue";
import { ElMessage } from "element-plus";

const router = useRouter();
const userName = ref("lblbc");
const password = ref("1");

const onClickLeft = () => history.back();

const doLogin = async () => {
  var params = {
    name: userName.value,
    password: password.value,
  };
  const resp = await login(params);
  if (resp.code === 0) {
    const token = resp.data.token;
    sessionStorage.setItem("token", token);
    router.push("/blog");
  } else {
    ElMessage.error(resp.msg);
  }
};

const doRegister = async () => {
  var params = {
    name: userName.value,
    password: password.value,
  };
  const resp = await register(params);
  if (resp.code === 0) {
    const token = resp.data.token;
    sessionStorage.setItem("token", token);
    router.push("/blog");
  } else {
    ElMessage.error(resp.msg);
  }
};

defineExpose({
  userName,
  password,
});
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
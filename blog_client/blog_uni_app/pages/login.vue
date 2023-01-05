<template>
	<view class="container">
		<view class="wrapper">
			<view class="input-content">
				<view class="input-item">
					<input :value="phone" placeholder="请输入账号" data-key="phone" @input="inputChange">
				</view>
				<view class="input-item">
					<input type="mobile" value="" placeholder="请输入密码" placeholder-class="input-empty" maxlength="20"
						password data-key="password" @input="inputChange">
				</view>
			</view>
			<view class="login-row">
				<button class="confirm-btn" @click="onLogin">
					登录
				</button>
				<button class="confirm-btn" @click="onRegister">
					注册
				</button>
			</view>
		</view>
	</view>
</template>

<script>
import { login,register } from '@/common/api'
export default {
	data() {
		return {
			phone: '',
			password: '',
		}
	},
	methods: {
		inputChange(e) {
			  const key = e.currentTarget.dataset.key
			  this[key] = e.detail.value
			},
		onLogin() {
			var params = {
				name: this.phone,
				password: this.password
			}
			login(params).then(resp => {
				if (!resp.data.code) {
					uni.setStorageSync('token',resp.data.data.token)
					uni.navigateTo({
						url: '/pages/blog-list'
					})
				}
			})
		},
		onRegister() {
			var params = {
				name: this.phone,
				password: this.password
			}
			register(params).then(resp => {
				if (!resp.data.code) {
					uni.setStorageSync('token',resp.data.data.token)
					uni.navigateTo({
						url: '/pages/blog-list'
					})
				}
			})
		},
	}
}
</script>

<style lang='scss'>
	page {
		background: #fff;
	}

	.container {
		padding-top: 100rpx;
		overflow: hidden;
	}

	.wrapper {
		position: relative;
	}

	.input-content {
		padding: 0 50rpx;
	}

	.input-item {
		display: flex;
		flex-direction: column;
		align-items: flex-start;
		justify-content: center;
		padding: 0 30rpx;
		height: 100rpx;
		border-radius: 2rem;
		border-color: #418DF9;
		border:1px solid darkgray;
		margin-top: 10rpx;
	}

	.confirm-btn {
		width: 200rpx;
		border-radius: 2rem;
		margin: 50rpx auto 0;
		background-color: #418DF9;
		color: #fff;
	}
	.login-row{
		display: flex;
	}
</style>

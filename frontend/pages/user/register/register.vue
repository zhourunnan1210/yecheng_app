<template>
	<view>
		<view class="loginBox">
			<u-field v-model="form.phone" label="手机号" placeholder="请输入手机号" required></u-field>
			<u-field v-model="form.password" :password="true" label="密码" placeholder="请输入密码" required></u-field>
			<u-field v-model="form.confirmedPassword" :password="true" label="确认密码" placeholder="请再次输入密码" required>
			</u-field>
		</view>
		<br>
		<br>
		<view class="custom-style">
			<u-button type="primary" shape="circle" @click="register">注册</u-button>
		</view>
		<view>
			<u-toast ref="uToast" />
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				form: {
					phone: '',
					password: '',
					confirmedPassword: ''
				}

			}
		},

		methods: {
			async register() {
				if (this.form.phone.length != 11) {
					this.$refs.uToast.show({
						title: '请输入正确的手机号',
						type: 'error',
						position: "top"

					})
					return
				}
				if (this.form.password.length < 6 || this.form.password.length > 20) {
					this.$refs.uToast.show({
						title: '密码为6-20位',
						type: 'error',
						position: "top"

					})
					return
				}
				if (this.form.password.length != this.form.confirmedPassword.length) {
					this.$refs.uToast.show({
						title: '两次密码不一致',
						type: 'error',
						position: "top"

					})
					return
				}
				const res = await this.$myRequest({
					url: '/user/register',
					method: 'POST',
					data: this.form,
					Header: {
						'content-type': 'application/x-www-form-urlencoded'
					},
				})

				uni.showToast({
					title: '注册成功!',
					mask: true,
					duration: 1500
				});
				uni.reLaunch({
					url: "../login/login"
				});

			}
		}
	}
</script>

<style>
	.loginBox {
		width: 650rpx;
		height: 200rpx;
		background-color: rgba(255, 255, 255, .7);
		margin: auto;
		margin-top: 30rpx;
		padding: 30rpx;
	}

	.custom-style {
		margin-top: 60rpx;
		margin: 100rpx;
	}
</style>

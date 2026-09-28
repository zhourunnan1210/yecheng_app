<template>
	<view>
		<!-- <u-image width="750rpx" height="250rpx" :src="logo" ></u-image> -->
		<view class="loginBox">
			<u-field v-model="form.phone" label="手机号" placeholder="请输入手机号" required></u-field>
			<u-field v-model="form.password" :password="true" label="密码" placeholder="请输入密码" required></u-field>
		</view>

		<view class="custom-style">
			<u-button type="primary" shape="circle" @click="tologin">登录</u-button>
			<br>
			<u-button type="primary" shape="circle" plain @click="toregister">点击注册</u-button>
			<br>
			<u-button type="primary" shape="circle" plain @click="cancel">返回</u-button>
		</view>
		<view>
			<u-toast ref="uToast" />
		</view>
	</view>
</template>

<script>
	import {
		mapstate,
		mapMutations
	} from 'vuex';
	//import logo from '@/static/logo.png';
	export default {
		data() {
			return {
				form: {
					phone: '',
					password: '',
				}

			}
		},
		methods: {
			async tologin() {
				if (this.form.phone.length != 11) {
					this.$refs.uToast.show({
						title: '请输入正确的手机号',
						type: 'error',
						position: "top"
						// url: '/pages/user/index'
					})
					return
				}
				const res = await this.$myRequest({
					url: '/user/login',
					method: 'POST',
					data: JSON.stringify(this.form),
					header: {
						'content-type': 'application/json'
					}
				})
				console.log(res)
				// 存储本地user的uid信息
				if (res.data.code == 0) {
					localStorage.setItem('user',res.data.data.uid)
					localStorage.setItem('userType',res.data.data.type)
					this.login(res.data.data); //全局login更改状态，存储userinfo
					uni.switchTab({
					    url: '/pages/mine/mine'
					});
				} else {
					this.$refs.uToast.show({
						title: res.data.msg,
						type: 'error',
						position: "top"
					// url: '/pages/user/index'
					})
				}
			
			},
			toregister() {
				uni.navigateTo({
					url: '../register/register'
				})
			},
			cancel() {
				uni.reLaunch({
					url: '../../mine/mine'
				})
			},
			// tofirstpage(provider){
			// 	this.login(provider);
			// 	uni.reLaunch({
			// 		url:''
			// 	})
			// }
			...mapMutations(['login'])
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
		position: relative;
		top: 100rpx;
	}

	.alternative {
		color: $u-tips-color;
		display: flex;
		justify-content: space-between;
		margin-top: 30rpx;
	}

	.custom-style {
		position: relative;
		top: 300rpx;
		margin-top: 60rpx;
		margin: 130rpx;
	}

	.buttons {
		type: primary;
		shape: circle;

	}
</style>

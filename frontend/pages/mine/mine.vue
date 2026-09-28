<template>
	<view>
		<u-navbar :is-back="false" title="" :background="background" boder-bottom="false"> </u-navbar>
		<view class="content">
			<view class="u-flex user-box u-p-l-30 u-p-r-20 u-p-b-30 ">
				<view v-if="isLogin" class="u-m-l-40">
					<u-avatar src="../../static/avatar.png" size="130"></u-avatar>
				</view>
				<view v-if="!isLogin" style="margin-bottom: 10px; display: flex;" @click="login()">
					<u-button shape="circle" size="medium" :ripple="true" @click="login()" class="custom-style">账号登录
					</u-button>
					<!-- <view style="color: #FFFFFF; font-size: 80rpx;">登录</view> -->
				</view>
				<view class="u-flex-1 username" v-if="isLogin" style="display: flex; flex-direction: column; align-items: flex-start; justify-content: center; padding-left: 80rpx;">
					<view style="color: #FFFFFF; padding-bottom: 10rpx;" v-if="username != ''">用户名：一颗小椰子</view>
					<view style="color: #FFFFFF; padding-bottom: 10rpx;" v-if="companyName != ''">企业名称：{{companyName}}</view>
					<view style="color: #FFFFFF;">认证状态：{{authStatus}}</view>
				</view>


			</view>
			<view class="u-m-t-20">
				<u-cell-group>
					<u-cell-item v-show="roleType == 0" title="认证" class="u-font-18" @click="authorize"></u-cell-item>
				</u-cell-group>
			</view>

			<view class="u-m-t-20">
				<u-cell-group>
					<!-- <u-cell-item v-if="roleType != 0 && roleType != undefined" icon="star" title=" 我的发布"
						@click="jump('depPublish')"></u-cell-item> -->
					<u-cell-item v-if="roleType != 0 && roleType != undefined" icon="question" title=" 问题咨询"
						@click="jump('myQuestion')">
						<u-badge :count="count" :absolute="false" slot="right-icon"></u-badge>
					</u-cell-item>
					<!-- <u-cell-item v-if="roleType == 1 || roleType == 2 || roleType == 3" icon="photo" title="活动"></u-cell-item>
				<u-cell-item v-if="roleType == 1" icon="coupon" title="人才需求"></u-cell-item>
				<u-cell-item v-if="roleType == 3" icon="heart" title="人才供应"></u-cell-item>
				<u-cell-item v-if="roleType == 1 || roleType == 3" icon="heart" title="科技成果"></u-cell-item>
				<u-cell-item v-if="roleType == 1" icon="heart" title="科技需求"></u-cell-item>
				<u-cell-item v-if="roleType == 2" icon="heart" title="政策"></u-cell-item>
				<u-cell-item v-if="roleType == 2" icon="heart" title="政策解读"></u-cell-item>
				<u-cell-item v-if="roleType == 4" icon="heart" title="金融产品"></u-cell-item>
				<u-cell-item v-if="roleType == 5" icon="heart" title="服务产品"></u-cell-item>
				<u-cell-item v-if="roleType == 1" icon="heart" title="融资需求"></u-cell-item>
				<u-cell-item v-if="roleType == 1" icon="heart" title="意见"></u-cell-item> -->
					<u-cell-item v-if="isLogin" icon="bookmark" title=" 退出登录" @click="logout"></u-cell-item>
				</u-cell-group>

			</view>

			<u-tabbar :list="tabbar"  active-color="#1296db" height="110"></u-tabbar>
		</view>
	</view>
</template>

<script>
	import {
		mapState,
		mapMutations
	} from 'vuex';
	import global from '../../store/global.js'
	export default {
		data() {
			return {
				count: '',
				pic: 'https://uviewui.com/common/logo.png',
				show: true,
				tabbar: [],
				username: "2",
				companyName: "",
				background: {
					backgroundColor: '#1296db',

				}
			};
		},
		computed: {
			...mapState({
				uid: state => state.userInfo.uid,
				// gid: state => state.userInfo.gid,
				roleType: state => state.userInfo.type,
				isLogin: state => state.isLogin,
				authStatus: state => state.userInfo.authStatus,
			})
		},
		watch: {
			isLogin(value) { //value3是已经在data中定义的属性，value是该属性发生改变的时候的值
				location.reload()
			}
		},


		onLoad(options) {
			this.tabbar = global.tabbar;
			this.getCount();
			this.getCompanyName();

		},
		methods: {
			...mapMutations(['logout1']),
			jump(myUrl) {
				let temp = './' + myUrl + '/' + myUrl
				console.log(temp)
				uni.navigateTo({
					url: temp
				});

			},
			async getCount() {
				let res = await this.$myRequest({
					url: '/consultation/countNoReply'
				});

				this.count = res.data.count;
			},
			async getCompanyName() {
				if (this.roleType != 1 || !this.uid) {
					this.companyName = '';
					return;
				}
				try {
					const res = await this.$myRequest({
						url: '/businessInfo/getByUserId/' + this.uid
					});
					if (res.data.code === 0 && res.data.data) {
						this.companyName = res.data.data.name || '';
					}
				} catch (e) {
					console.error('获取企业名称失败', e);
				}
			},
			login() {
				uni.redirectTo({
					url: '../user/login/login'
				});
			},
			authorize() {
				uni.navigateTo({
					url: '../index1/index'
				});
			},
			logout() {
				this.logout1()
				localStorage.removeItem('user')
			}

		}
	}
</script>

<style lang="scss" scoped>
	.camera {
		width: 54px;
		height: 44px;

		&:active {
			background-color: #ededed;
		}
	}

	.custom-style {
		height: 80rpx;
		width: 240rpx;
		font-weight: 900;
	}

	.user-box {
		background-color: #1296db;
		height: 150px;
		text-align: center;
		border-radius: 0 0 50% 50%;
		display: flex;
		justify-content: center;
	}

	// .userback {
	// 		width: 100%;
	// 		// background-image: url('../../static/bg2.jpg');
	// 		background-repeat: no-repeat;
	// 		background-size: 100%;
	// 		text-align: center
	// 	}
	/* 	.username {
		float: center;
	} */
</style>

<template>
	<view class="">
		<view class="container" v-if="type == 0" style="text-align: center;">请先通过认证</view>
			
		<view class="container" v-if="type == 1">
			<view class="title">
				企业发布
			</view>

			<navigator url="people/people">
				<view class="shape ">
					<view class="imagebox">
						<image class="icon" src="../../static/font/rencai.png"></image>
					</view>
					<view class="container2">
						<text style="font-weight: 900; margin-bottom: 20rpx; font-size: 32rpx;">人才需求</text>
						<view class="u-line-2 u-flex-wrap u-font-12" style="">对接高校发布人才需求，招聘大学毕业生、高层次人才</view>
					</view>

				</view>
			</navigator>
			<navigator url="technologyNeed/technologyNeed">
				<view class="shape ">
					<view class="imagebox">
						<image class="icon" src="../../static/font/jishu.png"></image>
					</view>
					<view class="container2">
						<text style="font-weight: 900; margin-bottom: 20rpx; font-size: 32rpx;">技术需求</text>
						<view class="u-line-2 u-flex-wrap u-font-12" style="">企业发布技术需求或难题，寻求技术帮助</view>
					</view>

				</view>
			</navigator>
			<navigator url="financing/financing">
				<view class="shape ">
					<view class="imagebox">
						<image class="icon" src="../../static/font/rongzi.png"></image>
					</view>
					<view class="container2">
						<text style="font-weight: 900; margin-bottom: 20rpx; font-size: 32rpx;">融资需求</text>
						<view class="u-line-2 u-flex-wrap u-font-12" style="">各金融机构发布对高企的金融服务信息、高企发布融资需求信息</view>
					</view>

				</view>
			</navigator>
			<navigator url="achievement/achievement">
				<view class="shape ">
					<view class="imagebox">
						<image class="icon" src="../../static/font/chengguo.png"></image>
					</view>
					<view class="container2">
						<text style="font-weight: 900; margin-bottom: 20rpx; font-size: 32rpx;">科技成果</text>
						<view class="u-line-2 u-flex-wrap u-font-12" style="">高企新技术、新产品发布、介绍和推广，展示企业科研、生产动态</view>
					</view>

				</view>
			</navigator>

		</view>
		<view class="container" v-if="type ==3">
			<view class="title">
				高校发布
			</view>
			
			<navigator url="givePeople/givePeople">
				<view class="shape" style="background: rgba(236, 165, 99, 0.2);">
					<view class="imagebox">
						<image class="icon" src="../../static/font/rencaigongying.png"></image>
					</view>
					<view class="container2">
						<text style="font-weight: 900; margin-bottom: 20rpx; font-size: 32rpx;">人才供应</text>
						<view class="u-line-2 u-flex-wrap u-font-12" style="">高校发布人才信息</view>
					</view>
			
				</view>
			</navigator>
			<navigator url="achievement/achievement">
				<view class="shape " style="background: rgba(236, 165, 99, 0.2);">
					<view class="imagebox">
						<image class="icon" src="../../static/font/xuexiaochengguo.png"></image>
					</view>
					<view class="container2">
						<text style="font-weight: 900; margin-bottom: 20rpx; font-size: 32rpx;">科技成果</text>
						<view class="u-line-2 u-flex-wrap u-font-12" style="">高校或科研院所最新科研成果展示</view>
					</view>
			
				</view>
			</navigator>
		<!-- 	<navigator url="../service/service">
				<view class="shape" style="background: rgba(236, 165, 99, 0.2);">
					<view class="imagebox">
						<image class="icon" src="../../static/font/zhaopin.png"></image>
					</view>
					<view class="container2">
						<text style="font-weight: 900; margin-bottom: 20rpx; font-size: 32rpx;">招聘宣讲</text>
						<view class="u-line-2 u-flex-wrap u-font-12" style="">高校发布招聘、宣讲等活动邀请</view>
					</view>
			
				</view>
			</navigator> -->

		</view>
		<view class="container" v-if="type ==5">
			<view class="title">
				服务机构发布
			</view>
			<navigator url="fuwuPro/fuwuPro">
				<view class="shape" style="background: rgba(99, 204, 91,0.2) ;">
					<view class="imagebox">
						<image class="icon" src="../../static/font/fuwu.png"></image>
					</view>
					<view class="container2">
						<text style="font-weight: 900; margin-bottom: 20rpx; font-size: 32rpx;">服务产品</text>
						<view class="u-line-2 u-flex-wrap u-font-12" style="">可为高企提供涉及知识产权、财税服务、法律资讯等内容的服务产品</view>
					</view>

				</view>
			</navigator>

		</view>
		<view class="container" v-if="type==2">
			<view class="title">
				政策发布
			</view>
			<navigator url="latestpolicy/latestpolicy">
				<view class="shape" >
					<view class="imagebox">
						<image class="icon" src="../../static/font/zhengcefabu.png"></image>
					</view>
					<view class="container2">
						<text style="font-weight: 900; margin-bottom: 20rpx; font-size: 32rpx;">最新政策</text>
						<view class="u-line-2 u-flex-wrap u-font-12" style="">发布与高企有关的政策、法规等内容</view>
					</view>
		
				</view>
			</navigator>
			<navigator url="anaylsepolicy/anaylsepolicy">
				<view class="shape" >
					<view class="imagebox">
						<image class="icon" src="../../static/font/jiedu.png"></image>
					</view>
					<view class="container2">
						<text style="font-weight: 900; margin-bottom: 20rpx; font-size: 32rpx;">政策解读</text>
						<view class="u-line-2 u-flex-wrap u-font-12" style="">发布与高企有关的政策、法规相关解读</view>
					</view>
					
				</view>
			</navigator>
		
		</view>
		<view class="container" v-if="type==4">
			<view class="title">
				金融机构发布
			</view>
			
			<navigator url="financingProduct/financingProduct">
				<view class="shape" style="background: rgba(236, 165, 99, 0.2);">
					<view class="imagebox">
						<image class="icon" src="../../static/font/jinrongchanpin.png"></image>
					</view>
					<view class="container2">
						<text style="font-weight: 900; margin-bottom: 20rpx; font-size: 32rpx;">金融产品</text>
						<view class="u-line-2 u-flex-wrap u-font-12" style="">各金融机构发布金融服务信息</view>
					</view>
			
				</view>
			</navigator>
		</view>
		
		<u-tabbar :list="tabbar" active-color="#1296db" height="110"></u-tabbar>
	</view>
</template>
<script>
	import {
		mapState,
		mapMutations
	} from 'vuex';
	export default {
		data() {
			return {
				tabbar: '',
			};
		},
		computed:{
			...mapState({
				type: state => state.userInfo.type,
				isLogin: state => state.isLogin,
			})
		},
		watch:{
			isLogin: function(value) {
				uni.switchTab({
					url:'../mine/mine'
				})
			}
		},
		
		onLoad() {
			this.tabbar = [{
					iconPath: "/static/font/home.png",
					selectedIconPath: "/static/font/home-blue.png",
					text: '首页',
					pagePath: "/pages/index/index"
				},
				{
					iconPath: "/static/font/zhengce-blue.png",
					selectedIconPath: "/static/font/zhengce.png",
					text: '政策',
					pagePath: "/pages/policy/policy"
				},
				{
					iconPath: "/static/font/badd.png",
					text: '发布',
					selectedIconPath: "/static/font/add.png",
					midButton: true,
					pagePath: "/pages/add/add"
				},
				{
					iconPath: "/static/font/park.png",
					selectedIconPath: "/static/font/parkblue.png",
					text: '园区',
					pagePath: "/pages/park/park"
				},
				{
					iconPath: "/static/font/mine.png",
					selectedIconPath: "/static/font/mineblue.png",
					text: '我的',
					pagePath: "/pages/mine/mine"
				},
			];
			console.log(this.type)
			if (this.isLogin == false) {
				uni.redirectTo({
					url:'../user/login/login'
				})
			}
			
		}
	}
</script>

<style lang="scss" scoped>
	.title {
		font-size: 32rpx;
		position: relative;
		line-height: 1;
		padding-left: 22rpx;
		font-weight: 900;
		margin: 20rpx 0;
		color: $uni-color-title;

		&:before {
			width: 4px;
			height: 16px;
			border-radius: 100rpx;
			background-color: $uni-color-primary;
			content: '';
			position: absolute;
			left: 6rpx;
			top: -1px;
		}
	}

	.mainclass {
		height: 100%;
	}

	.box {
		background: rgba(152, 196, 234, 0.5);
		height: 250rpx;
		padding: 10rpx;
		margin: 15rpx;
		border-radius: 12rpx;
	}

	.container {
		height: 100%;
		display: flex;
		justify-content: space-between;
		flex-direction: column;
		padding: 20rpx 0;
		margin: 20rpx 0;
		background: #FFFFFF;
	}


	.container2 {
		margin: 20rpx;
		margin-left: 10rpx;
		width: 65%;
		display: flex;
		justify-content: space-around;
		flex-direction: column;
	}

	.shape {
		height: 200rpx;
		background: rgba(152, 196, 234, 0.2);
		margin: 10rpx 20rpx;
		border-radius: 15rpx;
		padding-right: 20rpx;
		display: flex;
		align-items: center;
		justify-content: space-around;
	}

	.imagebox {
		height: 100rpx;
		width: 100rpx;
		margin-left: 40rpx;

		.icon {
			width: 100%;
			height: 100rpx;

		}
	}


</style>

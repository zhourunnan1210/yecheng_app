<template>
	<view class="content">
		<u-swiper
		            :list="list1"
		            indicator
		            indicatorMode="line"
		            circular
		    ></u-swiper>
		<u-grid :col="3" class="grid">
			<u-grid-item v-for="(item,index) in list" :key="index" @click="jumpto(item.src)">
				<image :src="item.imgsrc" class="icon"></image>
				<view>{{item.name}}</view>
			</u-grid-item>
		</u-grid>
		<view class="header">
			<text class="title">成果展示</text>
			<text class="subTitle" @click="jumpToTechManage">更多</text>
		</view>
		<view class="box" >
			<u-row class="item" >
				<u-col style="margin-top: 20rpx;" span="6" v-for="(item,i) in TAList" @click="jumpToTechDetail(item.technologyAchievementId)">
					<view class="iconbox">
						<img :src="item.image"></img>
					</view>
					<view class="title">{{item.title}}</view>
				</u-col>						
			</u-row>		
		</view>
		<u-tabbar :list="tabbar" active-color="#1296db" height="110"></u-tabbar>
	</view>
</template>

<script>
	import estimate from './estimate/estimate.vue'
	import match from './match/match.vue'
	import process from './process/process.vue'
	import research from './research/research.vue'
	import global from '../../../store/global.js'
	export default {
		components:{
			estimate,
			match,
			research,
			process
		},
		data() {
			return {
				DEFAULT_IMAGE:'static/defaultImage/1.png',
				TAList:[],
				TNList:[],
				keywords: '',
				list1: [
				    '/static/pic1.png',
				    '/static/pic2.png',
				    '/static/pic3.png',
				],
				list: [{
					imgsrc: '/static/font/manage.png',
					name: '成果管理',
					src: '/manage/manage'
				}, {
					imgsrc: '/static/font/demand.png',
					name: '技术需求',
					src: '/demand/demand',
				}, {
					imgsrc: '/static/font/process.png',
					name: '产品研发进度',
					src: '/process/process'
				}, {
					imgsrc: '/static/font/match.png',
					name: '成果需求匹配',
					src: '/match/match'
				}, {
					imgsrc: '/static/font/research.png',
					name: '我要发布',
					src: '/publish/publish',
				}, {
					imgsrc: '/static/font/estimate.png',
					name: '成果评估',
					src: '/estimate/estimate'
				}]
			}
		},
		onLoad() {
			this.tabbar = global.tabbar;
			this.getTAList()
		},
		methods: {
			// 获取成果列表
			async getTAList() {
				const res = await this.$myRequest({
					url: '/technologyAchievement/listByConditions',
					method: 'POST',
					header: {
						'content-type': 'application/json'
					},
					data: {
						"duration": '全部',
						"field":'全部',
						"level": '全部',
						"maturity":'全部'	
					}
				});
				this.TAList = res.data.data.filter((item,index)=>index<4)
				this.TAList.forEach(item => {
					// if (!item.image) {
						item.image = this.DEFAULT_IMAGE
					// }
					// 去掉发布日期的时分秒
					item.publishTime=/\d{4}-\d{1,2}-\d{1,2}/g.exec(item.publishTime)
				})
				console.log(this.TAList)
			},
			jumpto(val) {
				uni.navigateTo({
					url: '/pages/detail/transform' + val
				});
			},
			jumpToTechDetail(item) {
				uni.navigateTo({
					url:'/pages/detail/transform/manage/manageDetail?item='+item
				})
			},
			jumpToTechManage(val) {
				uni.navigateTo({
					url: '/pages/detail/transform/manage/manage'
				});
				
			}
		}
	}
</script>

<style lang="scss" scoped>
.content {
	padding: 20rpx 30rpx;
	background-color: #f3f4f6;
	// background-color: blue-green;
	.search {
		background-color: #f3f4f6!important;
	}
	.grid {
		margin-top: 30rpx;
		font-size: 28rpx;
		// font-weight: 550;
		.icon {
		  height: 75rpx;
		  width: 75rpx;
		  margin-bottom: 8rpx;
		}
	}
	.header {
		height: 100rpx;
		line-height: 100rpx;
		margin-top: 10rpx;
		// border-bottom: 1rpx solid #ccc;
		.title {
			margin-left: 10rpx;
			font-size: 40rpx;
			font-weight: 550;
		}
		.subTitle {
			float: right;
			font-size: 35rpx;
			color: blue;
		}
	}
	.icons{
		display: flex;
		height: 200rpx;
		justify-content: center;
		align-items: center;
		.icon-box{
			flex: 1;
			height: 200rpx;
			background: -webkit-linear-gradient(left top,  white, lightskyblue);
			margin: 0 10rpx;
			.icon {
				left: 50%;
				transform: translateX(-50%);
				height: 100rpx;
				width: 100rpx;
				margin-top: 20rpx;
				border-radius: 50rpx;
				background-color: #fff;
			}
			.name{
				font-weight: 550;
				text-align: center;
				padding-top: 10rpx;
			}
		}
	}
	.box {
		background-color: #fff;
		.item{
			.iconbox{
				width: 170rpx;
				height: 140rpx;
				margin:0 auto;
				img{
					width: 100%;
					height: 100%;
				}
			}
			.title{
				margin-bottom: 20rpx;
				font-size: 33rpx;
				text-align: center;
			}
		}
	}
}
</style>

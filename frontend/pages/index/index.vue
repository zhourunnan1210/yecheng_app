<template>
	<view class="mainclass">
		<view class="topbox">
			<!-- 轮播图 -->
			<view class="swiper">
				<u-swiper :list="list" height="330" bg-color="#1296db"></u-swiper>
			</view>
		</view>
		<view class="bottom">
			<!-- 宫格导航区 -->
			<grid></grid>
			<!-- 消息区 -->
			<view class="message-box">
				<u-notice-bar mode="vertical" :list="message" volume-icon="false" type="primary"></u-notice-bar>
			</view>
			<!-- 卡片示图区 -->
			<view class="cardbox">
				<u-card title="动态新闻" sub-title="查看更多" full margin="17rpx" title-size="35"
					@head-click="clickitem('/news/news')">
					<view class="" slot="body">
						<view class="u-body-item u-flex u-border-bottom u-col-between u-p-t-0" v-for="(item,index) in dynamicInfo.news"
							@click="getNews(item.id)">
							<view class="u-body-item-title u-line-2 u-font-28 title">{{item.title}}</view>
						</view>
					</view>
				</u-card>
				<u-card title="园区展示" sub-title="查看更多" full margin="17rpx" title-size="35"
					@head-click="more('/park/park')">
					<view class="" slot="body">
						<view class="u-body-item u-flex u-border-bottom u-col-between u-p-t-0 list-content" v-for="(item,index) in dynamicInfo.park"
							@click="getPDesc(item.parkId)">
							<view class="u-body-item-title u-line-2 u-font-28 title">
								{{item.parkName}}</view>
							<image :src=item.avatar
								mode="aspectFill" lazy-load class="park-image"></image>
						</view>
					
					</view>
				</u-card>
				
			</view>
		</view>
		<u-tabbar :list="tabbar" active-color="#1296db" height="110"></u-tabbar>
	</view>
</template>

<script>
	import grid from './grid.vue';
	import global from '../../store/global.js'
	export default {
		components: {
			grid
		},
		data() {
			return {
				tabbar: [],
				list: [{
						image: "/static/parkDesc/haikou_gaoxin.jpg",
					},
					{
						image: "/static/pic1.png",
					},
					{
						image: "/static/pic2.png",
					},
					{
						image: "/static/pic3.png",
					},
					{
						image: "/static/parkDesc/haida.jpg",
					}
				],
			    message: ["海南省支持高新技术企业发展若干政策现已发布", "自贸港政策汇编", "人才认定政策汇编"],
				title: "动态新闻",
				subTitle: "查看更多",
				PList: [],
				policyList: [],
				dynamicInfo: {},
			};
		},
		onLoad() {
			this.tabbar = global.tabbar;
			this.getPolicy();
			this.getParkList();
			this.getDynamicInfo();
		},
		methods: {
			async getPolicy() {
				const res = await this.$myRequest({
					url: "/policy/getlist",
					method: "POST",
				});
				for (let i = 0; i < 3; i++) {
					this.message[i] = res.data.data[i].title + ";";
				}

			},
			getPolicyDesc(item) {
				uni.navigateTo({
					url: "/pages/policy/policydesc/policydesc?item=" + item,
				});
			},
			getNews(item) {
				uni.navigateTo({
					url: "/pages/news/newsDesc/newsDesc?item=" + item,
				});
			},
			more(item) {
				uni.switchTab({
					url: "/pages" + item,
				});
			},
			clickitem(index) {
				uni.navigateTo({
					url: "/pages" + index,
				});
			},
			
			// 获取园区列表
			async getParkList() {
				const res = await this.$myRequest({
					url: "/park/getlist",
				});
				//	console.log(res)
				if (res.data.code == 0) {
					for (let i = 0; i < 2; i++) {
						this.PList[i] = res.data.data[i];
					}
				}
				const res1 = await this.$myRequest({
					url: "/policy/getlist",
					method: "POST",
					header: {
						"content-type": "application/json",
					},
				});
				for (let i = 0; i < 2; i++) {
					this.policyList[i] = res1.data.data[i];
				}
			},
			getPDesc(item) {
				uni.navigateTo({
					url: "/pages/park/parkDesc/parkDesc?item=" + item,
				});
			},
			
			//获取首页动态展示的信息
			async getDynamicInfo() {
				const res = await this.$myRequest({
					method: "POST",
					url: "/index/dynamic/info",
				});
				this.dynamicInfo = res.data.dynamicInfo;
			}
		},
	};
</script>

<style lang="scss" scoped>
	.topbox {
		background-color: #1296db;
		width: 100%;
		height: 450rpx;
	}

	.swiper {
		padding: 20rpx;
	}

	.bottom {
		background: #efefef;
		position: absolute;
		top: 380rpx;
		height: 100%;
		width: 100%;
		//border-radius: 50rpx 50rpx;
	}

	.cardbox {
		height: 84%;
	}



	.iconminbox {
		padding: 10rpx;
		height: 80rpx;
		width: 80rpx;
	}


	.title {
		font-size: 29rpx;
		position: relative;
		line-height: 1.3;
		padding-left: 25rpx;
		margin-top: 10rpx;
		margin-bottom: 30rpx;
		color: $uni-color-title;

		&:before {
			width: 4px;
			height: 12px;
			border-radius: 100rpx;
			background-color: $uni-color-primary;
			content: "";
			position: absolute;
			left: 6rpx;
			top: 50px;
		}
	}

	.message-box {
		height: 100rpx;
		margin-top: 15rpx;
		border-radius: 15rpx;
		background: #ffffff;
		padding: 17rpx 0;
	}

	.u-card-wrap {
		background-color: $u-bg-color;
		padding: 1px;
	}

	.u-body-item {
		font-size: 32rpx;
		color:#333;
		padding: 20rpx 10rpx;
	}

	.u-body-item image {
		width: 120rpx;
		flex: 0 0 120rpx;
		height: 120rpx;
		border-radius: 8rpx;
		margin-left: 12rpx;
	}
	.list-content {
		justify-content: space-between;
	}
	.mainclass {
		height: 100%;

	}
</style>

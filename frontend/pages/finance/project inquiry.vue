<template>
	<view class="wrap">
		<view class="u-tabs-box">
			<u-tabs-swiper activeColor="#1296db" ref="tabs" :list="list" :current="current" @change="tebchange"
				:is-scroll="false" swiperWidth="750" inactive-color="#000000"></u-tabs-swiper>
				<swiper class="swiper-box" :current="swiperCurrent" @transition="transition"
					@animationfinish="animationfinish" style="height: 100vh;">
					<swiper-item class="swiper-item" style="height: 100%;width: 100%;">
						<scroll-view scroll-y style="height: 100%;width: 100%;" @scrolltolower="reachBottom">
							
								<view class="Button" style="display:flex;margin-left: 30rpx;margin-top: 60rpx;">
								<u-button @click="gettouzi()" type="primary" :ripple="true" size="medium">投资项目申请</u-button>
								<u-button @click="getrongzi()" type="primary" :ripple="true" size="medium">融资项目申请</u-button>
								</view>
								<!-- <view class="box" v-for="(item,i) in TBList" >
									
									<u-row>
										"{{item.projectName}}"项目的进度为：{{item.progressDescription}}
									</u-row>
								</view>	 -->
								<!-- <view>{{process}}</view> -->
							</scroll-view>
							</swiper-item>
							<swiper-item class="swiper-item" style="height: 100%;width: 100%;">
								<scroll-view scroll-y style="height: 100%;width: 100%;" @scrolltolower="reachBottom">
									<view class="search">
									<u-search placeholder="请输入项目名称或备案号" v-model="keyWord" shape="square":show-action="false"></u-search>
									</view>
									<view class="Button">
									<u-button @click="getTAList()" type="primary" :ripple="true" size="medium">查询</u-button>
									</view>
									<view class="result">
										<view class="box" v-for="(item,i) in TAList" >
										<u-grid :col="1">
											<u-grid-item>
												<u-image width="150px" height="150px" :src="checkImage(item.image)"></u-image>
											</u-grid-item>
										</u-grid>
											<u-row>
												{{item.projectName}}
											</u-row>
											<u-row>
												<u-col span="12">
													<view class="text u-flex-nowrap">开始时间：
														<text class="u-main-color">
															{{$u.timeFormat(item.startDate, 'yyyy-mm-dd')}}
											
														</text>
													</view>
												</u-col>
												<u-col span="12">
													<view class="text u-flex-nowrap">截止时间：
														<text class="u-main-color">
															{{$u.timeFormat(item.endDate, 'yyyy-mm-dd')}}
																							
														</text>
													</view>
												</u-col>
												<u-col span="12">
													<view class="text">备案号：
														<text class="u-main-color">
															{{item.projectRecordNumber}}
														</text>
													</view>
												</u-col>
												<u-col span="12">
													<view class="text">项目进度：
														<text class="u-main-color">
															{{item.progressDescription}}
														</text>
													</view>
												</u-col>
												</u-row>
											<u-row>
												<u-col span="12">
													<view class="text">联系人：
														<text class="u-main-color">
															{{item.contactName}}
														</text>
													</view>
												</u-col>
												<u-col span="12">
													<view class="text">联系电话：
														<text class="u-main-color">
															{{item.contactPhone}}
														</text>
													</view>
												</u-col>
											</u-row>
											<u-row>
												<u-col span="12">
													<view class="title">
														项目介绍
													</view>
													<text decode class="u-content-color u-m-r-20 u-m-l-20 u-m-t-80 u-font-28 textbox">{{item.projectDescription}}
													</text>
												</u-col>
											</u-row>
											<u-row>
												<u-col span="12">
													<view class="title">
														成功案例
													</view>
													<text decode class="u-content-color u-m-r-20 u-m-l-20 u-m-t-80 u-font-28 textbox u-m-b-30">{{item.successFlag}}
													</text>
												</u-col>
											</u-row>
											
										</view>

									</view>
									</scroll-view>
									</swiper-item>
				</swiper-item>
		   </swiper>
		  
		</view>
		
		
	</view>
</template>

<script>
	import { needDefaultImage, isStaleOssUrl } from '../../utils/imageUrl.js'
	export default {
		data() {
			return {
				DEFAULT_IMAGE:'/static/defaultImage/1.png',
				keyword:'',
				TAList:[],
				TBList:[],
				current: 0,
				swiperCurrent: 0,
				tabsHeight: 0,
				dx: 0,
				tabbar: [],
				keyWord:'',
				process:'',
				imgList:[],
				list: [{
						name: '项目申请'
					},
					{
						name: '项目查询'
					},
					
				],
			}
		},
/* 		onLoad() {
			this.getTAList(),
			this.getTBList()
			// this.getQueListByCategory()
		}, */
		methods: {
			async getTAList() {
				const res = await this.$myRequest({
					url: '/investFinancialProj/getByNameOrRecordNum/'+this.keyWord,
					method: 'GET',
					header: {
						'content-type':'application/json'
					},
					data: {
						// "nameornum": this.keyWord
					
					},
				});
				console.log(res,'111111')
				if (res.data.data.length == 0){
					// console.log(666666)
					return uni.showToast({
						title: '未查询到该项目',
						icon: 'none'
					})
					
					
				}
				this.TAList = res.data.data
				
				
					
			},
			// async getTBList() {
			// 	const res = await this.$myRequest({
			// 		url: '/investFinancialProj/getProgressDescriptionByProjectName/'+this.keyword,
			// 		method: 'GET',
			// 		header: {
			// 			'content-type':'application/json'
			// 		},
			// 		data: {
			// 			// "nameornum": this.keyWord
					
			// 		}
			// 	});
			// 	console.log(res,'111111')
			// 	this.TBList = res.data.data
				
			// },
			async getTAlistDesc(item) {
				uni.navigateTo({
					url:  '/pages/detail/financing/financingNeed/financingNeed'
				});
			
			},
			async gettouzi() {
				uni.navigateTo({
					url:  '/pages/finance/investProject'
				});
			
			},
			async getrongzi() {
				uni.navigateTo({
					url:  '/pages/finance/financingProject'
				});
			
			},
			checkImage(url) {
				if (needDefaultImage(url)
					|| url.trim() === '') {
					return this.DEFAULT_IMAGE
				}
				return url
			},
			tebchange(index) {
				this.swiperCurrent = index;
			
			},
			transition({
				detail: {
					dx
				}
			}) {
				this.$refs.tabs.setDx(dx);
			},
			animationfinish({
				detail: {
					current
				}
			}) {
				this.$refs.tabs.setFinishCurrent(current);
				this.swiperCurrent = current;
				this.current = current;
			},
		}
	}
</script>

<style>
	.swiper-box {
		flex: 1;
	}
	.Button{
		margin-left:300rpx;
		margin-top: 30rpx;
		margin-bottom: 30rpx;
	}
	.search{
		margin-top: 60rpx;
		margin-left: 15rpx;
		margin-right: 15rpx;
	}
	.result{
		background-color: #F2F2F2;
		height: 100%;
		padding-bottom: 54px;
	}
	.u-row {
		margin-top: 20rpx;
		background: #FFFFFF;
		font-size: 18px;
		padding: 20px;
		color: #000000;
		letter-spacing: 2px;
	
	}
	
	.text {
		font-size: 14px;
		color: #949494;
		line-height: 2;
	
	}
	
	.title {
		font-size: 28rpx;
		position: relative;
		line-height: 1;
		padding-left: 20rpx;
		font-weight: 900;
		margin-bottom: 20px;
		color: $uni-color-title;
	
		&:before {
			width: 4px;
			height: 16px;
			border-radius: 100rpx;
			background-color: $uni-color-primary;
			content: '';
			position: absolute;
			left: 1rpx;
			top: -1px;
		}
	}
</style>

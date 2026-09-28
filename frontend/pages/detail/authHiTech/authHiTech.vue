<template>
	<view class="content">
		<view class="wrap">
			<view class="u-tabs-box">
				<u-tabs-swiper activeColor="#1296db" ref="tabs" :list="list" :current="current" @change="tebchange"
					:is-scroll="false" swiperWidth="750" inactive-color="#000000"></u-tabs-swiper>
			</view>

			<swiper class="swiper-box" :current="swiperCurrent" @transition="transition"
				@animationfinish="animationfinish" style="height: 100vh;">
				<!-- 认定指南 -->
				<swiper-item class="swiper-item">
					<scroll-view scroll-y style="height: 100%;width: 100%;">
						<view v-for="(item,i) in helpList"  v-model="helpList">
							<uni-list-item direction="column" v-slot:body>
								<template>
											<view v-html="item.content">{{item.content}}</view>
								</template>
							</uni-list-item>
						</view>
					</scroll-view>
				</swiper-item>
				
				<!-- 认定咨询 -->
				<swiper-item class="swiper-item">
					<scroll-view scroll-y style="height: 100%;width: 100%;">
						<view v-for="(item,i) in questionList" v-if="item.child" v-model="questionList">
							<uni-list-item direction="column" v-slot:body>
								<view @click="getQueDesc(item)">
									<!-- 标题 -->
									<template>
										<view class="uni-title title1 u-line-1">{{item.content}}
										</view>
									</template>
									<!-- 回复 -->
									<template>
										<view class="uni-list-box">
											<view class="content">
												<view class="u-line-2 u-m-b-20 u-m-r-20 u-m-l-20">{{item.child.content}}</view>
											</view>
										</view>
									</template>
								</view>
							</uni-list-item>
						</view>

					</scroll-view>
				</swiper-item>
			</swiper>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				category: '',
				categoryP: "",
				categoryPA: "",
				stable: 1,
				type: 1,
				options1: [],
				options2: [],
				list: [{
						name: '认定指南'
					},
					{
						name: '认定咨询'
					}
				],
				current: 0,
				swiperCurrent: 0,
				tabsHeight: 0,
				dx: 0,
				loadStatus: ['loadmore', 'loadmore', 'loadmore', 'loadmore'],
				tabbar: [],
				hiTechList: [],
				questionList: [],
				helpList:[]
			};
		},
		onLoad() {
			this.getListByCategory()
		},
		methods: {
			
			/* 获取高企认定政策 */
			async getListByCategory() {
				const res = await this.$myRequest({
					url: '/policy/get/list',
					method:'POST',
					data:{
						category:'认定指南'
					},
					header: {
						'content-type': 'application/x-www-form-urlencoded'
					}
				});
				this.helpList = res.data.data
				console.log(data)
			},
			// getPolicyAnalyseDesc(item) {
			// 	uni.navigateTo({
			// 		url: '/pages/policy/policyAnalyseDesc/policyAnalyseDesc?item=' + item
			// 	});
			// },

			// getPolicyDesc(item) {
			// 	console.log(item)
			// 	uni.navigateTo({
			// 		url: '/pages/policy/policydesc/policydesc?item=' + item
			// 	});
			// },
			
			/* 点击进入详情页 */
			getQueDesc(item) {
				let obj = {
					"item": item
				}
				uni.navigateTo({
					url: '/pages/question/questionList/questionDetil',
					success: function(res) {
						res.eventChannel.emit('obj', {item: item})
					}
				});
			},
			getHelpDesc(item) {
				uni.navigateTo({
					url: '/pages/policy/policydesc/policydesc?item=' + item
				});
			},
			reachBottom() {
				// 此tab为空数据
				if (this.current != 2) {
					this.loadStatus.splice(this.current, 1, "loading")
					setTimeout(() => {}, 1200);
				}
			},

			// tab栏切换
			tebchange(index) {
				this.swiperCurrent = index;
				
				if (index == 1) {
					this.getQueList();
				}else{
					this.getListByCategory();
				}
			},

			/* 根据索引获取咨询列表 */
			async getQueList() {
				
				const res = await this.$myRequest({
					url: '/consultation/list/combine',
					data: {
						category: '高企申报咨询'
					},
					header: {
						'content-type': 'x-www-form-urlencoded'
					}
				});
				this.questionList = res.data.data;		
			},
			async getHelpList() {
				const res = await this.$myRequest({
					url: '/consultation/list/combine',
					data: {
						category: '认定指南'
					},
					header: {
						'content-type': 'application/x-www-form-urlencoded'
					}
				});
				this.helpList = res.data.data;
			},
		
			async getHelpList() {
				const res = await this.$myRequest({
					url: '/consultation/list/combine',
					data: {
						category: '认定指南'
					},
					header: {
						'content-type': 'application/x-www-form-urlencoded'
					}
				});
				this.helpList = res.data.data;
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
			}
		}
	}
</script>



<style lang="scss" scoped>
	.swiper-box {
		flex: 1;
	}

	.swiper-item {
		height: 100%;
	}



	.mainclass {
		background-color: #F2F2F2;

	//	padding-bottom: 54px;
	}
	.uni-note {
		font-size: 13px;
		color: #adafb3;
		position: relative;
		left: 80%;
	}
	.u-row {
		margin-bottom: 20rpx;
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
	}
	.content {
		font-size: 13px;
		color: #adafb3;
	}
	
	.title1 {
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
			content: '';
			position: absolute;
			left: 6rpx;
			top: 3px;
		}
	}
</style>

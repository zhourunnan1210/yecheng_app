<template>
	<view class="content">
		<view class="wrap">
			<view class="u-tabs-box">
				<u-tabs-swiper activeColor="#1296db" ref="tabs" :list="list" :current="current" @change="tebchange"
					:is-scroll="false" swiperWidth="750" inactive-color="#000000"></u-tabs-swiper>
			</view>

			<swiper class="swiper-box" :current="swiperCurrent" @transition="transition"
				@animationfinish="animationfinish" style="height: 100vh;">
				<swiper-item class="swiper-item" style="height: 100%;width: 100%;">
					<scroll-view scroll-y style="height: 100%;width: 100%;" @scrolltolower="reachBottom">
						<view v-for="(item,i) in policyList">
							<!-- 垂直排列，无略缩图，主标题+副标题显示 -->
							<uni-list-item direction="column" v-slot:body>
								<template>
									<view class="uni-title title" @click="getPolicyDesc(item.policyId)">
										{{item.title}}
									</view>
								</template>
								<template>
									<view class="uni-list-box">
										<view class="uni-content">
											<!-- <view class="uni-title-sub uni-ellipsis-2 u-line-1">{{item.content}}</view> -->
											<view class="uni-note">
													{{$u.timeFormat(item.publishTime, 'yyyy-mm-dd')}}
											</view>
										</view>
									</view>
								</template>

							</uni-list-item>
						</view>

					</scroll-view>
				</swiper-item>
				<swiper-item class="swiper-item">
					<scroll-view scroll-y style="height: 100%;width: 100%;">
						<view v-for="(item,i) in questionList" v-if="item.child" v-model="questionList">
							<uni-list-item direction="column" v-slot:body>
								<view @click="getQueDesc(item)">
									<!-- 标题 -->
									<template>
										<view class="uni-title title u-line-1">{{item.content}}
										</view>
									</template>
									<!-- 回复 -->
									<template>
										<view class="uni-list-box">
											<view class="content">
												<view class="u-line-2 u-m-b-20 u-m-r-20 u-m-l-20">{{item.child.content}}
												</view>
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
				stable: 1,
				type: 1,
				list: [{
						name: '项目申报'
					},
					{
						name: '申报咨询'
					}
				],
				current: 0,
				swiperCurrent: 0,
				tabsHeight: 0,
				dx: 0,

				policyList: [],
				policyAnalyseList: [],
				questionList:''
			};
		},
		onLoad() {

			this.getListByCategory()
		},
		methods: {
			async getListByCategory() {
				const res = await this.$myRequest({
					url: '/policy/getlist',
					method: 'POST',
					data: {
						category: '项目申报政策'
					},
					header: {
						'content-type': 'application/x-www-form-urlencoded'
					}
				});
		
				let data = res.data.data
				this.policyList = data
			},

			/* 根据索引获取咨询列表 */
			async getQueListByCategory() {
				console.log(this.category, "111")
				const res = await this.$myRequest({
					url: '/consultation/list/combine',
					data: {
						category: '项目申报咨询'
					},
					header: {
						'content-type': 'x-www-form-urlencoded'
					}
				});
				console.log(res)
				let data = res.data.data
				this.questionList = data
				console.log(this.questionList)
			},


			// tab栏切换
			tebchange(index) {
				this.swiperCurrent = index;
				if (index == 1) {
					this.getQueListByCategory();
				}
			},
			/* 点击进入详情页 */
			getQueDesc(item) {
				let obj = {
					"item": item
				}
				uni.navigateTo({
					url: '/pages/question/questionList/questionDetil',
					success: function(res) {
						res.eventChannel.emit('obj', {
							item: item
						})
					}
				});
				// this.$router.push({
				// 	path: '/pages/question/questionList/questionDetil',
				// 	query: obj
				// })
			},

			async getPolicyAnalyse() {
				console.log(this.category)
				const res = await this.$myRequest({
					url: '/policyanalyse/getlist',
					method: 'POST',
					header: {
						'content-type': 'application/json'
					}
				});
				// console.log(res)
				let data = res.data.data
				this.policyAnalyseList = data

			},

			/* 进入详情页 */
			getPolicyAnalyseDesc(item) {
				uni.navigateTo({
					url: '/pages/policy/policyAnalyseDesc/policyAnalyseDesc?item=' + item
				});
			},

			getPolicyDesc(item) {
				console.log(item)
				uni.navigateTo({
					url: '/pages/policy/policydesc/policydesc?item=' + item
				});
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



	.uni-note {
		font-size: 13px;
		color: #adafb3;
		position: relative;
		left: 80%;
	}

	.text {
		font-size: 14px;
		color: #949494;
		line-height: 2;

	}

	.content {
		font-size: 13px;
		color: #adafb3;
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
			content: '';
			position: absolute;
			left: 6rpx;
			top: 3px;
		}
	}
</style>

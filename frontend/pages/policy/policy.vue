<template>
	<view class="content">
		<view class="wrap">
			<view class="u-tabs-box">
				<u-tabs-swiper activeColor="#1296db" ref="tabs" :list="list" :current="current" @change="tebchange"
					:is-scroll="false" swiperWidth="750" inactive-color="#000000"></u-tabs-swiper>
			</view>

			<swiper class="swiper-box" :current="swiperCurrent" @transition="transition"
				@animationfinish="animationfinish" style="height: 100vh;">
				<!-- 政策tab -->
				<swiper-item class="swiper-item" style="height: 100%;width: 100%;">
					<scroll-view scroll-y style="height: 100%;width: 100%;" @scrolltolower="reachBottom">
						<!-- 政策分类 -->
						<u-dropdown>
							<u-dropdown-item v-model="categoryP" title="分类" :options="options1" @change="changepolicy">
							</u-dropdown-item>
						</u-dropdown>
						<!-- 政策列表 -->
						<view v-for="(item,i) in policyList">
							<uni-list-item direction="column" v-slot:body>
								<template>
									<view class="uni-title title" @click="getPolicyDesc(item.policyId)">{{item.title}}
									</view>
								</template>
								<template>
									<view class="uni-list-box">
										<view class="uni-content">
											<!-- <view class="uni-title-sub uni-ellipsis-2 u-line-1">{{item.content}}</view> -->
											<view class="uni-note">{{$u.timeFormat(item.publishTime, 'yyyy-mm-dd')}}
											</view>
										</view>
									</view>
								</template>

							</uni-list-item>
						</view>


					</scroll-view>
				</swiper-item>
				<!-- 咨询tab -->
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

		<u-tabbar :list="tabbar" active-color="#1296db" height="110"></u-tabbar>
	</view>
</template>

<script>
	import global from '../../store/global.js';
	export default {
		data() {
			return {
				category: [],
				categoryP: "",
				categoryPA: "",
				stable: 1,
				type: 1,
				options1: [],
				options2: [],
				list: [{
						name: '政策汇总'
					},
					{
						name: '政策咨询'
					}
				],
				current: 0,
				swiperCurrent: 0,
				tabsHeight: 0,
				dx: 0,
				loadStatus: ['loadmore', 'loadmore', 'loadmore', 'loadmore'],
				tabbar: [],
				policyList: [],
				policyAnalyseList: [],
				questionList:[]
			};
		},
		onLoad() {
			this.tabbar = global.tabbar;
			this.getList();

		},
		methods: {
			// 获取政策索引
			async getList() {
				const res = await this.$myRequest({
					url: `/list`,
					method: 'POST',
					data: {
						indexName: '政策索引'
					},
					header: {
						'content-type': 'application/x-www-form-urlencoded'
					}

				});
				let obj = {
					key: '1'
				}
				let data = res.data.data[0].keys
				data.forEach((item, index) => {
					const option = {
						label: item,
						value: index + 2
					}
					this.options1.push(option);
				})
				this.options1.unshift({
					label: '全部',
					value: 1
				})
				this.changepolicy(1);

			},


			/* 点击进入政策详情页 */
			getPolicyDesc(item) {

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
					this.getQueListByCategory();
				}
			},
			//进入资讯详情页面
			getQueDesc(item){
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
			},
			/* 根据索引获取咨询列表 */
			async getQueListByCategory() {
				const res = await this.$myRequest({
					url: '/consultation/list/combine',
					data: {
						category: '其他政策咨询'
					},
					header: {
						'content-type': 'x-www-form-urlencoded'
					}
				});		
				console.log(res.data.data)
				let data = res.data.data
				this.questionList = data
			},

			async changepolicy(index) {
				this.category.push(this.options1[index - 1].label)
				const res = await this.$myRequest({
					url: '/policy/get/list',
					method: 'POST',
					header: {
						'content-type': 'application/x-www-form-urlencoded'
					},
					data: {
						category: this.category
					}
				});

				this.policyList = res.data.data

				this.category = []
			},
			/*  */
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

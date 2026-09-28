<template>
	<view class="content">
		<view class="wrap">
			<view class="u-tabs-box">
				<u-tabs-swiper activeColor="#1296db" ref="tabs" :list="list" :current="current" @change="tebchange"
					:is-scroll="false" swiperWidth="750" inactive-color="#000000"></u-tabs-swiper>
			</view>

			<swiper class="swiper-box" :current="swiperCurrent" @transition="transition"
				@animationfinish="animationfinish" style="height: 100vh;">

				<swiper-item class="swiper-item">
					<scroll-view scroll-y style="height: 100%;width: 100%;">
						<!-- <u-dropdown>
							<u-dropdown-item v-model="ensureMethod1" title="担保方式" :options="optionsEnsureMethod" @change="change3"></u-dropdown-item>
							<u-dropdown-item v-model="loanMoney1" title="贷款额度" :options="optionsLoanMoney" @change="change4"></u-dropdown-item>
							<u-dropdown-item v-model="loanDeadline1" title="贷款期限" :options="optionsLoanDeadline" @change="change5"></u-dropdown-item>
						</u-dropdown> -->
						<!-- 金融政策 -->
						<view>


							<view v-for="(item,i) in FPList">
								<!-- 垂直排列，无略缩图，主标题+副标题显示 -->
								<uni-list-item direction="column" v-slot:body>
									<template>
										<view class="uni-title title" @click="getFPDesc(item.financialProductId)">
											{{item.title}}
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
							<!-- <view class="box" v-for="(item,i) in FPList" @click="getFPDesc(item.financialProductId)">
								<u-row>
									<u-col span="4">
										<view class="iconbox">

											<image :src="item.image"lazy-load></image>

										</view>
									</u-col>
									<u-col span="8">
										<view class="textbox">{{item.title}}
										</view>
										<view class="notebox u-line-2">参考利率：{{item.rate}}</view>
										<view class="notebox u-line-2">贷款额度：{{item.loanMoney}}</view>
										<view class="notebox u-line-2">贷款期限：{{item.loanDeadline}}</view>
									
									</u-col>
								</u-row>

							</view> -->
						</view>
					</scroll-view>
				</swiper-item>
				<!-- 融资咨询 -->
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
				investField: '',
				investMoney: '',
				ensureMethod: '',
				loanMoney: '',
				loanDeadline: '',
				publishTime: '全部',
				filed: '全部',
				investField1: '',
				investMoney1: '',
				ensureMethod1: '',
				loanMoney1: '',
				loanDeadline1: '',
				publishTime1: '',
				filed1: '',
				stable: 1,
				type: 1,
				optionsInvestField: [],
				optionsInvestMoney: [],
				optionsEnsureMethod: [],
				optionsLoanMoney: [],
				optionsLoanDeadline: [],
				optionsPublishTime: [],
				optionsField: [],
				list: [
					/* {
											name: '金融机构'
										}, */
					{
						name: '金融政策'
					},
					{
						name: '融资咨询'
					}
				],
				current: 0,
				swiperCurrent: 0,
				tabsHeight: 0,
				dx: 0,
				loadStatus: ['loadmore', 'loadmore', 'loadmore', 'loadmore'],
				tabbar: [],
				FIList: [],
				FPList: [],
				FNList: [],
				questionList: []

			};
		},
		onLoad() {


			this.getFPList()

			this.getIndex()
			this.getQueListByCategory()

		},
		methods: {

			async getQueListByCategory() {

				const res = await this.$myRequest({
					url: '/consultation/list/combine',
					data: {
						category: '金融政策咨询'
					},
					header: {
						'content-type': 'x-www-form-urlencoded'
					}
				});

				let data = res.data.data
				this.questionList = data

			},

			//获取金融产品列表
			async getFPList() {
				const res = await this.$myRequest({
					url: '/financialproduct/getlist',
					method: 'POST',
					header: {
						'content-type': 'application/json'
					},
					data: {
						"ensureMethod": this.ensureMethod,
						"loanDeadline": this.loanDeadline,
						"loanMoney": this.loanMoney
					}
				});
				// console.log(res)
				this.FPList = res.data.data
				// console.log(this.FPList)
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

			async getIndex() {
				//投资领域
				const investField = await this.$myRequest({
					url: '/investfieldindex/getlist'
				});
				let res = this.changeKeyName(investField.data.data)
				this.optionsInvestField = res

				//投资金额
				const investMoney = await this.$myRequest({
					url: '/investmoneyindex/getlist'
				});
				this.optionsInvestMoney = this.changeKeyName(investMoney.data.data)

				//担保方式
				const ensureMethod = await this.$myRequest({
					url: '/ensuremethodindex/getlist'
				});
				this.optionsEnsureMethod = this.changeKeyName(ensureMethod.data.data)
				//贷款额度
				const loanMoney = await this.$myRequest({
					url: '/ensuremoneyindex/getlist'
				});
				this.optionsLoanMoney = this.changeKeyName(loanMoney.data.data)
				//贷款期限
				const loanDeadline = await this.$myRequest({
					url: '/loandeadlineindex/getlist'
				});
				this.optionsLoanDeadline = this.changeKeyName(loanDeadline.data.data)
				//发布时间
				const publishTime = await this.$myRequest({
					url: '/timeindex/getlist'
				});
				this.optionsPublishTime = this.changeKeyName(publishTime.data.data)
				//行业领域
				// const field = await this.$myRequest({
				// 	url: '/professionfieldindex/getlist'
				// });
				this.optionsField = this.changeKeyName(field.data.data)
			},

			changeKeyName(objArr) {
				const keyMap = {
					name: "label",
					id: "value",
				};
				for (let i = 0; i < objArr.length; i++) {
					let obj = objArr[i];
					for (let key in obj) {
						let newKey = keyMap[key];
						if (newKey == "value") {
							obj[key] = i + 2
						}
						if (newKey) {
							obj[newKey] = obj[key];
							delete obj[key];
						}
					}
				}
				objArr.unshift({
					label: "全部",
					value: 1
				})
				return objArr
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

			},

			async getFIDesc(item) {
				uni.navigateTo({
					url: './financingInst/financingInst?item=' + JSON.stringify(item),
				});

			},
			async getFPDesc(item) {
				uni.navigateTo({
					url: './financingPro/financingPro?item=' + item,
				});

			},
			getFNDesc(item) {
				uni.navigateTo({
					url: '/pages/detail/financing/financingNeed/financingNeed?item=' + item
				});
			},
			change1(index) {
				if (index == 1) {
					this.investField = ''
				} else {
					this.investField = this.optionsInvestField[index - 1].label
				}
				this.getFIList()
			},
			change2(index) {
				if (index == 1) {
					this.investMoney = ''
				} else {
					this.investMoney = this.optionsInvestMoney[index - 1].label
				}
				this.getFIList()
			},
			change3(index) {
				if (index == 1) {
					this.ensureMethod = ''
				} else {
					this.ensureMethod = this.optionsEnsureMethod[index - 1].label
				}
				this.getFPList()
			},
			change4(index) {
				if (index == 1) {
					this.loanMoney = ''
				} else {
					this.loanMoney = this.optionsLoanMoney[index - 1].label
				}
				this.getFPList()
			},
			change5(index) {
				if (index == 1) {
					this.loanDeadline = ''
				} else {
					this.loanDeadline = this.optionsLoanDeadline[index - 1].label
				}
				this.getFPList()
			},
			change6(index) {
				if (index == 1) {
					this.publishTime = '全部'
				} else {
					this.publishTime = this.optionsPublishTime[index - 1].label
				}
				this.getFNList()
			},
			change7(index) {
				if (index == 1) {
					this.filed = '全部'
				} else {
					this.filed = this.optionsField[index - 1].label
				}
				this.getFNList()
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

	.box {
		border-bottom: 1px solid;
		border-color: #e6e6e6;
		height: 200rpx;
		background: #FFFFFF;


		.iconbox image {
			margin-left: 40rpx;
			margin-top: 28rpx;
			width: 80px;
			height: 80px;

		}


		.textbox {
			margin: 0 10rpx 5rpx 10rpx;
			padding: 10rpx 10rpx 5rpx 10rpx;
			font-weight: 500;
			color: #000000;
			line-height: 1.2;
			font-size: 28rpx;
		}

		.notebox {

			padding: 0 20rpx;
			font-size: 12px;
			color: #949494;
			line-height: 1.5;
		}

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

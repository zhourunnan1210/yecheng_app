<template>
	<view class="content">
		<view class="wrap">
			<view class="u-tabs-box">
				<u-tabs-swiper activeColor="#1296db" ref="tabs" :list="list" :current="current" @change="tebchange" :is-scroll="false"
				 swiperWidth="750" inactive-color="#000000"></u-tabs-swiper>
			</view>

			<swiper class="swiper-box" :current="swiperCurrent" @transition="transition" @animationfinish="animationfinish"
			 style="height: 100vh;">
				<swiper-item class="swiper-item" style="height: 100%;width: 100%;">
					<scroll-view scroll-y style="height: 100%;width: 100%;" @scrolltolower="reachBottom">
						<view v-for="(item,i) in policyList">
							<!-- 垂直排列，无略缩图，主标题+副标题显示 -->
							<uni-list-item direction="column" v-slot:body >
								<template>
									<view class="uni-title title"  @click="getPolicyDesc(item.policyId)">{{item.title}}</view>
								</template>
								<template>
									<view class="uni-list-box">
										<view class="uni-content">
											<!-- <view class="uni-title-sub uni-ellipsis-2 u-line-1">{{item.content}}</view> -->
											<view class="uni-note">{{$u.timeFormat(item.publishTime, 'yyyy-mm-dd')}}</view>
										</view>
									</view>
								</template>

							</uni-list-item>
						</view>


					</scroll-view>
				</swiper-item>
				<swiper-item class="swiper-item">
					<scroll-view scroll-y style="height: 100%;width: 100%;">
						<view>
							<view v-for="(item,i) in policyAnalyseList">
								<!-- 垂直排列，无略缩图，主标题+副标题显示 -->
								<uni-list-item direction="column">
									<template v-slot:header>
										<view class="uni-title title" @click="getPolicyAnalyseDesc(item.policyAnalyseId)">{{item.title}}</view>
									</template>
									<template v-slot:body>
										<view class="uni-list-box">
											<view class="uni-content">

												<view class="uni-note">{{item.publishTime}}</view>
											</view>
										</view>
									</template>

								</uni-list-item>
							</view>
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
				list: [{
						name: '政策'
					},
					{
						name: '政策解读'
					}
				],
				gid: 1,
				type: '',
				current: 0,
				swiperCurrent: 0,
				tabsHeight: 0,
				dx: 0,
				loadStatus: ['loadmore', 'loadmore', 'loadmore', 'loadmore'],
				tabbar: [],
				policyList: [],
				policyAnalyseList: []
			};
		},
		onLoad() {
			// this.gid = this.$store.state.userInfo.gid
			this.type = this.$store.state.userInfo.type
			this.getPolicyAnalyse(),
			this.getPolicy()
		},
		methods: {
			async getPolicyAnalyse() {
				const res = await this.$myRequest({
					url: '/policyanalyse/getlist/' + this.gid,
					method: 'GET',
				});
				let data = res.data.data
				this.policyAnalyseList = data
			
			},
			async getPolicy() {
				const res = await this.$myRequest({
					url: '/policy/getlist/'+this.gid,
					method: 'GET',
				});
				console.log(res)
				let data = res.data.data
				this.policyList = data
			},
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
					this.getPolicyAnalyse();
				}
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


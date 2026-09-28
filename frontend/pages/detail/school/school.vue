<template>
	<view class="content">
		<view class="wrap">
			<scroll-view scroll-y style="height: 100%;width: 100%;" @scrolltolower="reachBottom">
				<view class="box" v-for="(item,i) in schoolList" @click="getschoolDesc(item.schoolId)">
					<u-row>
						<u-col span="4">
							<view class="iconbox">
								<image :src="item.imageUrl"></image>
							</view>
						</u-col>
						<u-col span="8">
							<view class="textbox">{{item.name}}
							</view>
							<view class="notebox u-line-1">网站：{{item.website}}</view>
							<view class="notebox u-line-1">位置：{{item.location}}</view>
							<view class="notebox u-line-1">统一社会信用代码：{{item.code}}</view>
						</u-col>
					</u-row>
				</view>
			</scroll-view>
		</view>

	</view>
</template>

<script>
	export default {
		data() {
			return {
				current: 0,
				swiperCurrent: 0,
				tabsHeight: 0,
				dx: 0,
				loadStatus: ['loadmore', 'loadmore', 'loadmore', 'loadmore'],
				tabbar: [],
				schoolList: [],
			};
		},
		onLoad() {
			this.getschoolList()
			
		},
		methods: {
			//获取科技成果列表
			async getschoolList() {
				const res = await this.$myRequest({
					url: '/schoolinfo/getlist',
					method: 'GET',
					header: {
						'content-type': 'application/json'
					}
				});
				// console.log(res)
				this.schoolList = res.data.data
			},
	
			async getschoolDesc(item) {
				uni.navigateTo({
					url: './schoolDetail/schoolDetail?item=' + JSON.stringify(item),
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



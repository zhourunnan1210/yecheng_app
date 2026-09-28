<template>
	<view class="mainclass">
		<u-swiper :list="imgList" mode="number" height=350></u-swiper>
		<u-row>
			{{financing.parkName}}
		</u-row>
		<u-row>
			<u-col span="12">
				<view class="text">联系电话：
					<text class="u-main-color">
						{{financing.parkPhone}}
					</text>
				</view>
			</u-col>
			<u-col span="12">
				<view class="text">官网：
					<text class="u-main-color">
						{{financing.parkWebsite}}
					</text>
				</view>
			</u-col>

		</u-row>


		<u-row>
			<u-col span="12">
				<view class="title">
					园区简介
				</view>
				<u-read-more :toggle="true">
					<rich-text :nodes="financing.parkIntroduction"></rich-text>
				</u-read-more>
				<!-- 	<text decode class="u-content-color u-m-r-20 u-m-l-20 u-m-t-80 u-font-28 textbox">{{financing.parkIntroduction}}	</text> -->
			</u-col>
		</u-row>
		<u-row>
			<u-col span="12">
				<view class="title">
					配套设施
				</view>
				<text decode
					class="u-content-color u-m-r-20 u-m-l-20 u-m-t-80 u-font-28 textbox">{{financing.parkSupporting}}
				</text>
			</u-col>
		</u-row>
		<u-row>
			<u-col span="12">
				<view class="title">
					产业定位
				</view>
				<text decode
					class="u-content-color u-m-r-20 u-m-l-20 u-m-t-80 u-font-28 textbox">{{financing.productPositioning}}
				</text>
			</u-col>
		</u-row>
		<u-row>
			<u-col span="12">
				<view class="title">
					招商重点
				</view>
				<text decode
					class="u-content-color u-m-r-20 u-m-l-20 u-m-t-80 u-font-28 textbox">{{financing.keyPoints}} </text>
			</u-col>
		</u-row>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				financing: "",
				imgList: [],
				contact: ''
			}
		},
		methods: {

		},
		onLoad: async function(options) { //option为object类型，会序列化上个页面传递的参数
			let item = options.item
			const res = await this.$myRequest({
				url: '/park/get/' + item,

				header: {
					'content-type': 'application/x-www-form-urlencoded'
				}
			});
			this.financing = res.data.data
			if (this.financing && this.financing.parkImageUrl) {
				this.imgList = this.financing.parkImageUrl.split(';')
			}
		}
	}
</script>

<style scoped lang="scss">
	.mainclass {
		background-color: #F2F2F2;
		height: 100%;
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

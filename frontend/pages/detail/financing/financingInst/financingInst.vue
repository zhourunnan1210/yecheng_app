<template>
	<view class="mainclass">
		<u-grid :col="1">
			<u-grid-item>
				<u-image width="150px" height="150px" :src="checkImage(financing.investImag)"></u-image>
			</u-grid-item>
		</u-grid>
		<u-row>
			<u-col span="12">
				{{financing.companyName}}
			</u-col>
		</u-row>
		<u-row>
			<u-col span="12" >
				<view class="text u-flex-nowrap" >投资类型：
					<text class="u-main-color">
						{{financing.investType}}
					</text>
				</view>
			</u-col>
			<u-col span="12">
				<view class="text">投资方式：
				<text class="u-main-color">
					{{financing.investWay}}
				</text>
				</view>
			</u-col>
			<u-col span="12">
				<view class="text">投资金额：
					<text class="u-main-color">
						{{financing.investingMoney}}
					</text>
				</view>
			</u-col>
		
		</u-row>
		<!-- <u-row>
			<u-col span="12" >
				<view class="text u-flex-nowrap" >审核进度：
					<text class="u-main-color">
						{{financing.investType}}
					</text>
				</view>
			</u-col>
			
	
		
		</u-row> -->
		<u-row >
			
			<u-col span="12" >
				<view class="text" >联系电话：
				<text class="u-main-color" >
					{{financing.contactPhone}}
				</text>
				</view>
			</u-col>
			<u-col span="12">
				<view class="text">联系人姓名：
				<text class="u-main-color ">
					{{financing.contactName}}
				</text>
				</view>
			</u-col>
		</u-row>
		<u-row>
			<u-col span="12">
			<view class="title">
				投资说明
			</view>
				<text decode class="u-content-color u-m-r-20 u-m-l-20 u-m-t-80 u-font-28 textbox">{{financing.investDescription}}	</text>
			</u-col>
		</u-row>
		<u-row >
			<u-col span="12" >
			<view class="title" >
				公司介绍
			</view>
				<text decode class="u-content-color u-m-r-20 u-m-l-20 u-m-t-80 u-font-28 textbox u-m-b-30">{{financing.companyIntroduction}}	</text>
			</u-col>
		</u-row>
		<u-row >
			<u-col span="12" >
			<view class="title" >
				成功案例
			</view>
				<text decode class="u-content-color u-m-r-20 u-m-l-20 u-m-t-80 u-font-28 textbox u-m-b-30">{{financing.successCase}}	</text>
			</u-col>
		</u-row>
	</view>
</template>

<script>
	import { needDefaultImage, isStaleOssUrl } from '../../../../utils/imageUrl.js'
	export default {
		data() {
			return {
				DEFAULT_IMAGE: '/static/defaultImage/1.png',
				financing: "",
				
			}
		},
		methods: {
			checkImage(url) {
				if (needDefaultImage(url)
					|| url.trim() === '') {
					return this.DEFAULT_IMAGE
				}
				return url
			}
		},
		onLoad: async function(options) { //option为object类型，会序列化上个页面传递的参数
			// console.log(options.item)
			let item = options.item
			// console.log(item)
			const res = await this.$myRequest({
				url: '/investingneed/get/' + item,
				/* data: {
					policyId: item
				}, */
				header: {
					'content-type': 'application/x-www-form-urlencoded'
				}
			});
			// console.log(res)
			this.financing = res.data.data
			console.log(res)
		
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

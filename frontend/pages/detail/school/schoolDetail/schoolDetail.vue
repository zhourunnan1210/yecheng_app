<template>
	<view class="mainclass">
		<u-grid :col="1">
			<u-grid-item>
				<u-image  height="200px" :src="financing.imageUrl"></u-image>
			</u-grid-item>
		</u-grid>
		<u-row>
			<u-col span="12">
				{{financing.name}}
			</u-col>
		</u-row>
	<u-row>
			
			<u-col span="12">
				<view class="text">联系电话：
				<text class="u-main-color">
					{{financing.telephone}}
				</text>
				</view>
			</u-col>
			<u-col span="12">
				<view class="text">地址：
				<text class="u-main-color ">
					{{financing.address}}
				</text>
				</view>
			</u-col>
			<u-col span="12 u-line-1">
				<view class="text">官网：
				<text class="u-main-color u-line-1">
					{{financing.website}}
				</text>
				</view>
			</u-col>
		</u-row>
		</view>
</template>

<script>
	export default {
		data() {
			return {
				financing: "",
			}
		},
		methods: {

		},
		onLoad: async function(options) { //option为object类型，会序列化上个页面传递的参数
			console.log(options.item)
			let item = options.item
			console.log(item)
			const res = await this.$myRequest({
				url: '/schoolinfo/get/' + item,
				/* data: {
					policyId: item
				}, */
				header: {
					'content-type': 'application/x-www-form-urlencoded'
				}
			});
			console.log(res)
			this.financing = res.data.data
		
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

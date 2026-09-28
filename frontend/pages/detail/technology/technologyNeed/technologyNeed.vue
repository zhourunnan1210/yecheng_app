<template>
	<view class="mainclass">
	

			
					<u-swiper :list="imgList" mode="number" height=350></u-swiper>
		
	
		<u-row>
		{{financing.title}}
		</u-row>
		<u-row>
			<u-col span="12" >
				<view class="text u-flex-nowrap" >发布时间：
					<text class="u-main-color">
						{{$u.timeFormat(financing.publishTime, 'yyyy-mm-dd')}}
			
					</text>
				</view>
			</u-col>
			<u-col span="12">
				<view class="text">行业领域：
				<text class="u-main-color">
					{{financing.field}}
				</text>
				</view>
			</u-col>
		
		
		</u-row>
		<u-row>
			<u-col span="12">
				<view class="text">关键词：
				<text class="u-main-color">
					{{financing.category}}
				</text>
				</view>
			</u-col>
		
		
		</u-row>
		<u-row>
			<u-col span="12">
				<view class="text">联系人：
				<text class="u-main-color">
					{{financing.contactName}}
				</text>
				</view>
			</u-col>
			<u-col span="12">
				<view class="text">联系电话：
				<text class="u-main-color">
					{{financing.contactPhone}}
				</text>
				</view>
			</u-col>
		</u-row>
		<u-row>
			<u-col span="12">
			<view class="title">
				需求描述
			</view>
				<text decode class="u-content-color u-m-r-20 u-m-l-20 u-m-t-80 u-font-28 textbox">{{financing.description}}	</text>
			</u-col>
		</u-row>
	
	</view>
</template>

<script>
	export default {
		data() {
			return {
				financing: "",
				imgList:[]
			}
		},
		methods: {

		},
		onLoad: async function(options) { //option为object类型，会序列化上个页面传递的参数
			console.log(options.item)
			let item = options.item
			console.log(item)
			const res = await this.$myRequest({
				url: '/technologyneed/details/' + item,
				/* data: {
					policyId: item
				}, */
				header: {
					'content-type': 'application/x-www-form-urlencoded'
				}
			});
			this.financing = res.data.technologyNeed
			if(this.financing){
				this.imgList = this.financing.image.split(';')
				console.log(this.imgList)
				
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

<template>
	<view class="mainclass">
		<u-grid :col="1">
			<u-grid-item>
				<u-image width="150px" height="150px" :src="checkImage(financing.image)"></u-image>
			</u-grid-item>
		</u-grid>
		<u-row>
			<u-col span="12">
				{{financing.title}}
			</u-col>
		</u-row>
		<u-row>
			<u-col span="12" >
				<view class="text u-flex-nowrap" >利率范围：
					<text class="u-main-color">
						{{financing.rate}}
					</text>
				</view>
			</u-col>
			<u-col span="12">
				<view class="text">贷款额度：
				<text class="u-main-color">
					{{financing.loanMoney}}
				</text>
				</view>
			</u-col>
			<u-col span="12">
				<view class="text">担保方式：
					<text class="u-main-color">
						{{financing.ensureMethod}}
					</text>
				</view>
			</u-col>
			<u-col span="12">
				<view class="text">贷款期限：
				<text class="u-main-color">
					{{financing.loanDeadline}}
				</text>
				</view>
			</u-col>
		</u-row>
	
		<u-row>
			<u-col span="12">
			<view class="title">
				主要内容
			</view>
				<text decode class="u-content-color u-m-r-20 u-m-l-20 u-m-t-80 u-font-28 textbox">{{financing.description}}	</text>
			</u-col>
		</u-row>
		<u-row >
			<u-col span="12" >
			<view class="title" >
				其他介绍
			</view>
				<text decode class="u-content-color u-m-r-20 u-m-l-20 u-m-t-80 u-font-28 textbox u-m-b-30">{{financing.applyCondition}}	</text>
			</u-col>
		</u-row>
		<u-row  v-if="contact.name != '' && contact.phone != '' ">
			<u-col span="12">
				<view class="text"  >联系人：
				<text class="u-main-color">
					{{contact.name}}
				</text>
				</view>
			</u-col>
			<u-col span="12">
				<view class="text" >联系电话：
				<text class="u-main-color">
					{{contact.phone}}
				</text>
				</view>
			</u-col>
		</u-row>
	<!-- <que-button @clicked="clicked()"></que-button> -->
		</view>
	
	
	</template>
	
	<script>
	import { needDefaultImage, isStaleOssUrl } from '../../../../utils/imageUrl.js'
		import queButton from '../../../../components/queButton/queButton.vue'
		export default {
			components: {
				queButton
			},
		data() {
			return {
				DEFAULT_IMAGE: '/static/defaultImage/1.png',
				financing: "",
				contact:""
			}
		},
		methods: {
			checkImage(url) {
				if (needDefaultImage(url)
					|| url.trim() === '') {
					return this.DEFAULT_IMAGE
				}
				return url
			},
			clicked(item){
				uni.navigateTo({
					url: '../../../question/question'
				});
			}
		},
		onLoad: async function(options) { //option为object类型，会序列化上个页面传递的参数
			
			let item = options.item
			console.log(item)
			const res = await this.$myRequest({
				url: '/financialproduct/get/' + item,
				/* data: {
					policyId: item
				}, */
				header: {
					'content-type': 'application/x-www-form-urlencoded'
				}
			});
			
			this.financing = res.data.data.financing
			this.contact = {
				name: res.data.data.contactName || '',
				phone: res.data.data.contactPhone || ''
			}
			
		
		}
	}
</script>

<style scoped lang="scss">
	.mainclass {
		background-color: #F2F2F2;
		height: 100%;
		padding-bottom: 54px;
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

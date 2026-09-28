<template>
	<view class="mainclass">
		
		<u-row>
			<u-col span="10" class="u-font-39 ">
				{{financing.position}}
			</u-col>

			<u-col span="2" class="u-font-12 ">
				{{$u.timeFormat(financing.publishTime, 'mm/dd')}}
			</u-col>
		</u-row>
		<u-row>
			<u-col span="12">
				<view class="text">公司名称：
					<text class="u-main-color">
						{{business.name}}
					</text>
				</view>
			</u-col>
			<u-col span="12">
				<view class="text u-line-1">工作地址：
				<text class="u-main-color u-line-1">
					{{financing.address}}
				</text>
				</view>
			</u-col>
		
			<u-col span="12">
				<view class="text">公司官网：
				<text class="u-main-color">
					{{business.website}}
				</text>
				</view>
			</u-col>
		</u-row>
		<u-row>
			<u-col span="12">
				<view class="text">联系人：
				<text class="u-main-color">
					{{contact.name}}
				</text>
				</view>
			</u-col>
			<u-col span="12">
				<view class="text">联系电话：
				<text class="u-main-color">
					{{contact.phone}}
				</text>
				</view>
			</u-col>
		</u-row>
		<u-row>
			<u-col span="12">
			<view class="title">
				职位描述
			</view>
				<text decode class="u-content-color u-m-r-20 u-m-l-20 u-m-t-80 u-font-28 textbox">{{financing.job}}	</text>
			</u-col>
		</u-row>
		<u-row >
			<u-col span="12" >
			<view class="title" >
				任职要求
			</view>
				<text decode class="u-content-color u-m-r-20 u-m-l-20 u-m-t-80 u-font-28 textbox u-m-b-30">{{financing.demand}}	</text>
			</u-col>
		</u-row>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				financing: "",
				business:"",
				contact:''
			}
		},
		methods: {

		},
		onLoad: async function(options) { //option为object类型，会序列化上个页面传递的参数
			console.log(options.item)
			let item = options.item
			console.log(item)
			const res = await this.$myRequest({
				url: '/talentneed/get/' + item,
				/* data: {
					policyId: item
				}, */
				header: {
					'content-type': 'application/x-www-form-urlencoded'
				}
			});
			console.log(res)
			this.financing = res.data.data
			if(this.financing){
				let item = this.financing.businessId
				const res = await this.$myRequest({
					url: '/businessinfo/get/' + item,
					/* data: {
						policyId: item
					}, */
					header: {
						'content-type': 'application/x-www-form-urlencoded'
					}
				});
				this.business = res.data.data
				let id = this.financing.contactId
			
				const res1 = await this.$myRequest({
					url: '/contact/info/' + id,
					header: {
						'content-type': 'application/x-www-form-urlencoded'
					}
				});
				console.log(res)
				this.contact = res1.data.contact
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

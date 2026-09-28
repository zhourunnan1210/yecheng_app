<template>
	<view>
		<view class="item">
			<u-row>
				<u-col span="6" v-for="(item,i) in TBlist" @click="getTBlistDesc(item.projectId)">
					<view class="iconbox">
						<img :src="item.projectImage" width="128rpx" height="89rpx"></img>
						<!-- <img src="static/font/chongdianzhuangy.jpeg"></img> -->
					</view>
					<!-- </view> -->
					<view class="detail">【{{item.projectName}}】</view>
				</u-col>
				
			</u-row>
			
			
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				TBlist: [],
				projectImage:'',
			}
		},
		onLoad() {
			
			this.getTBlist()
			
		},
		methods: {
			async getTBlist() {
			
				const res = await this.$myRequest({
					url: '/investFinancialProj/getSuccessList1',
					method: 'POST',
					header: {
						'content-type': 'application/json'
					},
					data: {
						
					}
				});
				console.log(res.data,'22222')
				this.TBlist = res.data.data
				this.TBlist.forEach(item => {
					if (!item.projectImage) {
						item.projectImage = this.DEFAULT_IMAGE
					}
				})
				
					
			},
			async getTBlistDesc(item) {
				uni.navigateTo({
					url:   '/pages/detail/financing/financingInst/financingInst?item=' + JSON.stringify(item),
				});
			
			},
		}
	}
</script>

<style lang="scss" scoped>
	.item{
		height:600rpx;
		margin-top: 20rpx;
		padding-left: 20rpx;
		border-bottom: 2rpx solid #f3f4f6;
		.detail {
			height: 100rpx;
			line-height: 30rpx;
			font-size: 15rpx;
			// color: $u-type-info;
		}
	}
		
		
		
						
</style>
<template>
	
	<view class="content">
		<view class="search">
		<u-search placeholder="请输入融资项目名称" v-model="keyword" shape="square":show-action="false"></u-search>
		</view>
		<view class="Button">
		<u-button @click="inquiry()" type="primary" :ripple="true" size="medium">查询</u-button>
		</view>
		<view class="result">
			<view class="box" v-for="(item,i) in TAList" @click="getTBlistDesc(item.financingNeedId)">
			<u-row>
				<u-col span="4">
					<u-image width="100px" height="100px" :src="item.projectImage"></u-image>
				</u-col>
				<u-col span="8">
					<view class="textbox1 u-line-1">{{item.title}}
					</view>
					<view class="text">联系人：
						<text class="u-main-color">
							{{item.contactName}}
						</text>
					</view>
					<view class="text">联系人电话：
						<text class="u-main-color">
							{{item.contactPhone}}
						</text>
					</view>
				</u-col>
			</u-row>
		
				</view>
		</view>
	</view>
	
</template>

<script>
	export default {
		data() {
			return {
				keyword: '',
				TAList:[]
			}
		},
 		onLoad() {
			this.allquiry()
		}, 
		methods: {
			async allquiry(){
				const res = await this.$myRequest({
						url: '/financingneed/getFList',
						method: 'GET',
						header: {
							'content-type':'application/json'
						},
						data: {
							// "companyName": this.keyword
						
						}
					});
					console.log(res,'111111')
					if (res.data.data.length == 0){
						// console.log(666666)
						return uni.showToast({
							title: '无融资项目',
							icon: 'none'
						})	
					}
					this.TAList = res.data.data
					this.TAList.forEach(item => {
						if (!item.image) {
							item.image = this.DEFAULT_IMAGE
						}
					})	
				},
				async getTBlistDesc(item) {
					uni.navigateTo({
						url:  '/pages/finance/financingTable?item='+ JSON.stringify(item),
					});
				
				},
				async inquiry(){
				const res = await this.$myRequest({
						url: '/financingneed/getListByTitle/'+this.keyword,
						method: 'POST',
						header: {
							'content-type':'application/json'
						},
						data: {
							// "companyName": this.keyword
						
						}
					});
					console.log(res,'111111')
					if (res.data.data.length == 0){
						// console.log(666666)
						return uni.showToast({
							title: '未查询到该融资',
							icon: 'none'
						})	
					}
					this.TAList = res.data.data
					this.TAList.forEach(item => {
						if (!item.image) {
							item.image = this.DEFAULT_IMAGE
						}
					})
				}
			}
	}
</script>

<style>
.content{
	
	margin-top: 100rpx;		
	
}
.search{
	
		margin-top: 50rpx;
		margin-left: 15rpx;
		margin-right: 15rpx;
	
	
}
.Button{
	margin-left:300rpx;
	margin-top: 30rpx;
}
.box{
	
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
</style>

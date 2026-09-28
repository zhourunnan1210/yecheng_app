<template>
	<view class="content">
		<u-search class="search" bgColor="#fff" height="80" :clearabled="true" :show-action="false" v-model="keywords" @search="search(keywords)"></u-search>
		<scroll-view style="height: 84vh;" scroll-y="true" >
			<view class="main">
				<view class="detail" v-for="(item,index) in estimateList" @click="jumpToEstimateReport()" :key="index">
					<u-row>
						<u-col span="3">
							<view class="imgbox">
								<img :src="item.image" alt="">
							</view>
						</u-col>
						<u-col span="6">
							<view class="name">{{item.technologyAchievementEntity.title}}</view>
							<view class="publishtime">日期：{{item.publishTime[0]}}</view>
						</u-col>
						<u-col span="3">
							<view class="status">
								{{estimateStatus[item.applicationStatus]}}
							</view>
						</u-col>
					</u-row>
				</view>
			</view>
		</scroll-view>
	</view>
</template>

<script>
export default {
	data() {
		return {
			DEFAULT_IMAGE:'static/defaultImage/1.png',
			keywords:'',
			estimateList:[],
			estimateStatus:['正在评估','已评估']
		}
	},
	onLoad(){
		this.getEstimateMessage()
	},
	// 模糊搜索
	watch:{
		keywords(newval,oldval){
			this.estimateList=this.estimateList.filter(item=>{
				return item.technologyAchievementEntity.title.indexOf(newval)!==-1
			})
			if(newval==''){
				this.getEstimateMessage()
			}
		}
	},
	methods:{
		// 获取当前用户评估列表
		async getEstimateMessage(){
			const uid=localStorage.getItem('user')
			const res = await this.$myRequest({
				url: '/techAchEvaluationReport/list2/'+uid,
				method: 'GET',
				header: {
					'content-type': 'application/json'
				}
			});
			this.estimateList=res.data.data
			this.estimateList.forEach(item => {
				if (!item.image||item.image=='string') {
					item.image = this.DEFAULT_IMAGE
				}
				// 去掉发布日期的时分秒
				item.publishTime=/\d{4}-\d{1,2}-\d{1,2}/g.exec(item.publishTime)
			})
			console.log(this.estimateList)
		},
		// 跳转至评估报告
		jumpToEstimateReport(){
			uni.navigateTo({
				url:'/pages/detail/transform/estimate/report'
			})
		}
	}
}
</script>

<style lang="scss" scoped>
.content {
	// padding: 10rpx 30rpx;
	// background-color: #f3f4f6;
	.search {
		padding: 20rpx 30rpx;
		background-color: #f3f4f6!important;
	}
	.main {
		background-color: #fff;
		border-radius: 10rpx;
		.detail {
			// margin-top: 20rpx;
			height: 150rpx;
			border-bottom: 2rpx solid #f3f4f6;
			.imgbox {
				margin-left: 30rpx;
				width: 150rpx;
				height: 140rpx;
		
				img {
					width: 100%;
					height: 100%;
				}
			}
			.name {
				height: 80rpx;
				line-height: 80rpx;
				font-size: 39rpx;
				color: #333333;
				padding-left: 40rpx;
				overflow: hidden;
				text-overflow: ellipsis;
				white-space: nowrap;
			}
			.publishtime{
				padding-left: 40rpx;
			}
			.status{
				font-size: 35rpx;
				color: green;
			}
		}
	}
}
</style>
<template>
	<view class="content">
		<!-- <u-sticky offsetTop="0">
			<u-search class="search" bgColor="#fff" height="80" :clearabled="true" :show-action="false" v-model="keywords" @search="search(keywords)"></u-search>
		</u-sticky> -->
		<view class="u-tabs-box">
			<u-tabs-swiper activeColor="#1296db" ref="tabs" :list="sort" :current="current" @change="tebchange"
				:is-scroll="false" swiperWidth="750" inactive-color="#000000"></u-tabs-swiper>
		</view>
		<swiper class="swiper-box" :current="swiperCurrent" @transition="transition" @animationfinish="animationfinish" style="height: 100vh;">
			<swiper-item class="swiper-item" style="height: 100%;width: 100%;">
				<scroll-view style="height: 80vh;" scroll-y="true" >
					<view class="main">
						<view class="detail" v-for="(item,index) in techList" :key="index">
							<u-row>
								<u-col span="3">
									<view class="imgbox">
										<img :src="item.image" alt="">
									</view>
								</u-col>
								<u-col span="6">
									<view class="name">{{item.title}}</view>
									<view class="publishtime">日期：{{item.publishTime[0]}}</view>
								</u-col>
								<u-col span="3">
									<view class="btn">
										<u-button @click="estimate(item.technologyAchievementId)">立即评估</u-button>
									</view>
								</u-col>
							</u-row>
						</view>
					</view>
				</scroll-view>
			</swiper-item>
			<swiper-item class="swiper-item" style="height: 100%;width: 100%;">
				<scroll-view style="height: 80vh;" scroll-y="true" >
					<view class="main">
						<view class="detail" v-for="item in needList">
							<u-row>
								<u-col span="3">
									<view class="imgbox">
										<img :src="item.image" alt="">
									</view>
								</u-col>
								<u-col span="6">
									<view class="name">{{item.title}}</view>
									<view class="publishtime">日期：{{item.publishTime[0]}}</view>
								</u-col>
								
							</u-row>
						</view>					
					</view>
				</scroll-view>
			</swiper-item>
		</swiper>
	</view>
</template>

<script>
export default {
	data() {
		return {
			DEFAULT_IMAGE:'static/defaultImage/1.png',
			keywords:'',
			current: 0,
			swiperCurrent:0,
			sort:[{
				name:'成果'
			},{
				name:'需求'
			}],
			techList:[],
			needList:[]
		}
	},
	onLoad(){
		this.getTechList()
		this.getNeedList()
	},
	methods:{
		// tab栏切换
		tebchange(index) {
			this.swiperCurrent = index;
		
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
		},
		// 根据发布者id和类型查询全部的技术成果
		async getTechList() {
			const uid=localStorage.getItem('user')
			console.log(uid)
			const res = await this.$myRequest({
				url: '/technologyAchievement/listByPublisherIdType',
				method: 'POST',
				header: {
					'content-type': 'application/json'
				},
				data: {
					  "publisherId": uid,
					  "publisherType": 1
				}
			});
			this.techList = res.data.result
			this.techList.forEach(item => {
				if (!item.image||item.image=='string') {
					item.image = this.DEFAULT_IMAGE
				}
				// 去掉发布日期的时分秒
				item.publishTime=/\d{4}-\d{1,2}-\d{1,2}/g.exec(item.publishTime)
			})
			console.log(this.techList)
		},
		// 根据企业ID查询所有的技术需求
		async getNeedList() {
			const uid=localStorage.getItem('user')
			console.log(uid)
			const res = await this.$myRequest({
				url: '/technologyneed/listByBusinessID/'+uid,
				method: 'GET',
				header: {
					'content-type': 'application/json'
				}
			});
			this.needList = res.data.data
			this.needList.forEach(item => {
				if (!item.image||item.image=='string') {
					item.image = this.DEFAULT_IMAGE
				}
				// 去掉发布日期的时分秒
				item.publishTime=/\d{4}-\d{1,2}-\d{1,2}/g.exec(item.publishTime)
			})
			console.log(this.needList)
		},
		async estimate(val) {
			const uid=localStorage.getItem('user')
			console.log(val)
			const nowdate=new Date()
			const year = nowdate.getFullYear(),	
	        month = nowdate.getMonth() + 1,	
	        date = nowdate.getDate(),	
	        h = nowdate.getHours(),
	        m = nowdate.getMinutes(),
	        s = nowdate.getSeconds()
			const publishTime=`${year}-${month}-${date} ${h}:${m}:${s}`
			const res = await this.$myRequest({
				url: '/techAchEvaluationReport/publish',
				method: 'POST',
				header: {
					'content-type': 'application/json'
				},
				data: {
					"material": "string",
					"maturity": 1,
					"publishTime": publishTime,
					"technologyAchievementId": val,
					"userId": 28
				}
			});
			uni.navigateTo({
				url:'/pages/detail/transform/estimate/estimate'
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
			.btn {
				color: #333333;
			}
		}
	}
}
</style>

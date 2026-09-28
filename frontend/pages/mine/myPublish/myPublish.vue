<template>
	<view>
		<view class="wrap">
			<view class="u-tabs-box">
				<u-tabs-swiper activeColor="#1296db" ref="tabs" :list="list" :current="current" @change="tebchange" :is-scroll="false"
				 swiperWidth="750" inactive-color="#000000"></u-tabs-swiper>
			</view>
		
			<swiper class="swiper-box" :current="swiperCurrent" @transition="transition" @animationfinish="animationfinish"
			 style="height: 100vh;">
				<swiper-item class="swiper-item" style="height: 100%;width: 100%;">
					<scroll-view scroll-y style="height: 100%;width: 100%;">
						<view class="box" v-for="(item,i) in TPList" @click="getTPDesc(item.technologyAchievementId)">
							<u-row>
								<u-col span="4">
									<view class="iconbox">
										<img :src="item.image"></img>
									</view>
								</u-col>
								<u-col span="8">
									<view class="textbox">{{item.title}}
									</view>
									<view class="notebox u-line-1">分类：{{item.category}}</view>
									<view class="notebox u-line-1">行业领域：{{item.field}}</view>
									<view class="notebox u-line-1">发布时间：{{item.publishTime}}</view>
								</u-col>
							</u-row>
						</view>
					</scroll-view>
				</swiper-item>
				<swiper-item class="swiper-item">
					<scroll-view scroll-y style="height: 100%;width: 100%;">
						<view class="box" v-for="(item,i) in TNList" @click="getTNDesc(item.technologyNeedId)">
							<u-row>
								<u-col span="4">
									<view class="iconbox">
										<img :src="item.image"></img>
									</view>
								</u-col>
								<u-col span="8">
									<view class="textbox">{{item.title}}
									</view>
									<view class="notebox u-line-1">分类：{{item.category}}</view>
									<view class="notebox u-line-1">行业领域：{{item.field}}</view>
									<view class="notebox u-line-1">发布时间：{{item.publishTime}}</view>
								</u-col>
							</u-row>
						</view>
					</scroll-view>
				</swiper-item>
				<swiper-item class="swiper-item">
					<scroll-view scroll-y style="height: 100%;width: 100%;">
						<view class="box" v-for="(item,i) in PNList" @click="getPNDesc(item.talentNeedId)">
							<u-row>
								<u-col span="4">
									<view class="iconbox">
										<img :src="item.image"></img>
									</view>
								</u-col>
								<u-col span="8">
									<view class="textbox">{{item.position}}
									</view>
									<view class="notebox u-line-1">学历：{{item.education}}</view>
									<view class="notebox u-line-1">地区：{{item.location}}</view>
									<view class="notebox u-line-1">发布时间：{{item.publishTime}}</view>
								</u-col>
							</u-row>
						</view>
					</scroll-view>
				</swiper-item>
				<swiper-item class="swiper-item">
					<scroll-view scroll-y style="height: 100%;width: 100%;">
						<view class="box" v-for="(item,i) in FNList" @click="getFNDesc(item.financingNeedId)">
							<u-row>
								<u-col span="4">
									<view class="iconbox">
										<img :src="item.projectImage"></img>
									</view>
								</u-col>
								<u-col span="8">
									<view class="textbox">{{item.title}}
									</view>
									<view class="notebox u-line-1">融资金额：{{item.financingMoney}}</view>
									<view class="notebox u-line-1">行业领域：{{item.field}}</view>
									<view class="notebox u-line-1">融资方式：{{item.financingMethod}}</view>
								</u-col>
							</u-row>
						</view>
					</scroll-view>
				</swiper-item>
				
				</swiper-item>
			</swiper>
		</view>
		
	</view>
</template>

<script>
	export default {
		data() {
			return {
				list: [{
						name: '科技成果'
					},
					{
						name: '科技需求'
					},
					{
						name: '人才需求'
					},
					{
						name: '融资需求'
					},
				],
				gid: 1,
				type: '',
				top:'',
				current: 0,
				swiperCurrent: 0,
				tabsHeight: 0,
				dx: 0,
				TPList:[],
				TNList:[],
				PNList:[],
				FNList:[],
			}
		},
		methods: {
			//获取融资需求列表
			async getFNList() {
				const res = await this.$myRequest({
					url: '/financingneed/getlist/' + this.gid,
					method: 'GET'
				});
				// console.log(res)
				this.FNList = res.data.data
				// console.log(JSON.stringify(this.FNList))
				for(let i=0;i<this.FNList.length;i++) {
					let image = this.FNList[i].projectImage.split(';')[0]
					this.FNList[i].projectImage = image
				}
			},
			
			//人才需求
			async getPNList() {
				const res = await this.$myRequest({
					url: '/talentneed/getlist/' + this.gid,
					method: 'GET',
				});
				// console.log(res)
				this.PNList = res.data.data
			},
			
			//科技需求
			async getTNList() {
				const res = await this.$myRequest({
					url: '/technologyneed/listByBusinessID/' + this.gid,
					method: 'GET',
				});
				// console.log(res)
				this.TNList = res.data.data
				for(let i=0;i<this.TNList.length;i++) {
					let image = this.TNList[i].image.split(';')[0]
					this.TNList[i].image = image
				}
			},
			
			//科技成果
			async getTPList() {
				const res = await this.$myRequest({
					url: '/technologyAchievement/listByPublisherIdType',
					method: 'POST',
					header: {
						'content-type': 'application/json'
					},
					data: {
						"publisherId": this.gid,
						"publisherType": this.type
					}
				});
				this.TPList = res.data.data
				for(let i=0;i<this.TPList.length;i++) {
					let image = this.TPList[i].image.split(';')[0]
					this.TPList[i].image = image
				}
			},
			getTPDesc(item) {
				uni.navigateTo({
					url: '/pages/detail/technology/technologyAch/technologyAch?item=' + item 
				});
			},
			
			getTNDesc(item) {
				uni.navigateTo({
					url: '/pages/detail/technology/technologyNeed/technologyNeed?item=' + item 
				});
			},
			getPNDesc(item) {
				uni.navigateTo({
					url: '/pages/detail/people/peopleNeed/peopleNeed?item=' + item 
				});
			},
			getFNDesc(item) {
				uni.navigateTo({
					url: '/pages/detail/financing/financingNeed/financingNeed?item=' + item 
				});
			},
			
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
			}
		},
		onLoad(options) {
			// this.gid = this.$store.state.userInfo.gid
			this.type = this.$store.state.userInfo.type
			this.getTPList()
			this.getTNList()
			this.getPNList()
			this.getFNList()
		},
		
	}
</script>

<style lang="scss" scoped>
	.box {
		border-bottom: 1px solid;
		border-color: #e6e6e6;
		height: 200rpx;
		background: #FFFFFF;
	
	
		.iconbox img {
			margin-left: 40rpx;
			margin-top: 28rpx;
			width: 80px;
			height: 80px;
	
		}
	
	
		.textbox {
			margin: 0 10rpx 5rpx 10rpx;
			padding: 10rpx 10rpx 5rpx 10rpx;
			font-weight: 500;
			color: #000000;
			line-height: 1.2;
			font-size: 28rpx;
		}
		
		.notebox {
			
			padding: 0 20rpx;
			font-size: 12px;
			color: #949494;
			line-height: 1.5;
		}
	}
</style>

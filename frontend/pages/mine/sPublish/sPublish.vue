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
						<view class="box" v-for="(item,i) in PAList" @click="getPADesc(item.talentSupplyId)">
							<u-row>
								<u-col span="4">
									<view class="iconbox">
										<img :src="item.image"></img>
									</view>
								</u-col>
								<u-col span="8">
									<view class="textbox">{{item.job}}
									</view>
									<view class="notebox u-line-1">专业：{{item.profession}}</view>
									<view class="notebox u-line-1">毕业时间：{{item.graduateDate}}</view>
									<view class="notebox u-line-1">发布时间：{{item.publishTime}}</view>
								</u-col>
							</u-row>
						</view>
					</scroll-view>
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
						name: '人才供应'
					}
				],
				gid: 1,
				type: '',
				top:'',
				current: 0,
				swiperCurrent: 0,
				tabsHeight: 0,
				dx: 0,
				TPList:[],
				PAList:[],
			}
		},
		methods: {
			
			//人才供应
			async getPAList() {
				const res = await this.$myRequest({
					url: '/talentsupply/getlist/' + this.gid,
					method: 'GET',
				});
				// console.log(res)
				this.PAList = res.data.data
				for(let i=0;i<this.PAList.length;i++) {
					let date = this.PAList[i].graduateDate.split(" ")[0]
					this.PAList[i].graduateDate = date
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
			
			getPADesc(item) {
				uni.navigateTo({
					url: '/pages/detail/people/peopleApply/peopleApply?item=' + item
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
			this.getPAList()
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

<template>
	<view class="content">
		<view class="wrap">
			<view class="u-tabs-box">
				<u-tabs-swiper activeColor="#1296db" ref="tabs" :list="list" :current="current" @change="tebchange" :is-scroll="false"
				 swiperWidth="750" inactive-color="#000000"></u-tabs-swiper>
			</view>	
		</view>
		
		<view class="leader">
			<uni-icons class="location-filled" type="location" size="30"></uni-icons>
			<picker-address  @change="change">{{address}}</picker-address>
			<uni-search-bar :radius="100" @confirm="search" @input="input" clearButton="auto" cancelButton="none" style="width: 400rpx;"></uni-search-bar>	
			<button class="search" plain = "true" size="mini">搜索</button>
		</view>
				
				
		<u-dropdown>
			<u-dropdown-item v-model="publishTime" title="发布时间" :options="optionsPublishTime" @change="change1"></u-dropdown-item>
			<u-dropdown-item v-model="field"       title="行业领域" :options="optionsField" @change="change2"></u-dropdown-item>
		</u-dropdown>
		
		

		
			<swiper class="swiper-box" :current="swiperCurrent" @transition="transition" @animationfinish="animationfinish" style="height: 100vh;">			
				
				<swiper-item class="swiper-item">
					<scroll-view scroll-y style="height: 100%;width: 100%;">
						<view v-for="(item,i) in PAList">
							<!-- 垂直排列，无略缩图，主标题+副标题显示 -->
							<uni-list-item direction="column" v-slot:body >
								<template>
									<view class="uni-title title"  @click="getPADesc(item.talentSupplyId)">{{item.job}}</view>
								</template>
							</uni-list-item>
						</view>
						
					</scroll-view>
				</swiper-item>
				
				
				<swiper-item class="swiper-item" style="height: 100%;width: 100%;">
					<scroll-view scroll-y style="height: 100%;width: 100%;" @scrolltolower="reachBottom">
						<view class="box" v-for="(item,i) in PNList" @click="getPNDesc(item.talentNeedId)">
							<u-row>
								<u-col span="4">
									<view class="iconbox">
										<image :src="item.image" lazy-load></image>
										
									</view>
								</u-col>
								<u-col span="8">
									<view class="textbox">{{item.position}}</view>
									<view class="notebox u-line-1">学历：{{item.education}}</view>
									<view class="notebox u-line-1">地区：{{item.location}}</view>
									<view class="notebox u-line-1">发布时间：{{$u.timeFormat(item.publishTime, 'yyyy-mm-dd')}}</view>
								</u-col>
							</u-row>
						</view>
					</scroll-view>
				</swiper-item>
			</swiper>
		</view>
</template>

<script>
	import pickerAddress from '../../../components/pickerAddress.vue/pickerAddress.vue'
	import uniIcons from 	'@/components/uni-icons/uni-icons.vue'
	import uniNavBar from "@/components/uni-nav-bar/uni-nav-bar.vue"
	export default {
		components:{
			pickerAddress,
			uniNavBar
		},
		data() {
			return {
				list: [{
						name: '人才求职'
					},
					{
						name: '企业招聘'
					}
				],
				current: 0,
				swiperCurrent: 0,
				tabsHeight: 0,
				dx: 0,
				loadStatus: ['loadmore', 'loadmore', 'loadmore', 'loadmore'],
				PAList: [],
				PNList: [],
				address:'美兰区',
				publishTime: '',
				publishTime1: '',
				publishTime2: '全部',
				publishTime3: '全部',
				TNpublishTime: '全部',
				field: '',
				field1: '',
				TNfield: '全部',
				field2: '全部',
				field3: '全部',
				optionsPublishTime: [],
				optionsField: [],
			};
		},
		onLoad() {
			this.getPAList()
			this.getPNList()
			this.getTAList()
			this.getQueListByCategory()
			this.getIndex()
			this.getschoolList()
		},
		methods: {
			
			change(data) {
			    this.address = data.data.join(' ')
			    console.log(data.data.join(' '))
			},
			
			//获取人才供应列表
			async getPAList() {
				const res = await this.$myRequest({
					url: '/talentsupply/getlist',
					method: 'GET',
					header: {
						'content-type': 'application/json'
					}
				});
				// console.log(res)
				this.PAList = res.data.data
			},
			
			
			//获取人才需求列表
			async getPNList() {
				const res = await this.$myRequest({
					url: '/talentneed/getlist',
					method: 'GET',
					header: {
						'content-type': 'application/json'
					}
				});
				// console.log(res)
				this.PNList = res.data.data
			},
			
			async getIndex() {
			
				const res = await this.$myRequest({
					url: '/list',
					method: 'POST',
					data: {
						indexName: '科技索引'
					},
					header: {
						'content-type': 'application/x-www-form-urlencoded'
					}
				});
			
				const timeList = res.data.data[1].keys
				const fieldList = res.data.data[0].keys
				timeList.forEach((item, index) => {
					const option = {
						label: item,
						value: index + 2
					};
					this.optionsPublishTime.push(option)
				})
			
				this.optionsPublishTime.unshift({
					label: '全部',
					value: 1
				})
				
				fieldList.forEach((item, index) => {
					const option = {
						label: item,
						value: index + 2
					};
					this.optionsField.push(option)
				})
			
				this.optionsField.unshift({
					label: '全部',
					value: 1
				})
			
			
				console.log(this.optionsField)
			
			
			},
			async getTAList() {
			
				const res = await this.$myRequest({
					url: '/technologyAchievement/listByCondition',
					method: 'POST',
					header: {
						'content-type': 'application/json'
					},
					data: {
						"duration": this.publishTime2,
						"field": this.field2
					}
				});
				this.TAList = res.data.data
				this.TAList.forEach(item => {
					if (!item.image) {
						item.image = this.DEFAULT_IMAGE
					}
				})
			
					
			},
			async getQueListByCategory() {
			
				const res = await this.$myRequest({
					url: '/technologyneed/listByCondition',
					method: 'POST',
					data: {
						"duration": this.TNpublishTime,
						"field": this.TNfield
					},
					header: {
						'content-type': 'application/json'
					}
				});
			
				this.TNList = res.data.data;
				this.TAList.forEach(item => {
					if (!item.image) {
						item.image = this.DEFAULT_IMAGE
					}
				})
				
			
			},
			change1(index) {
				if (index == 1) {
					this.publishTime2 = '全部'
				} else {
					this.publishTime2 = this.optionsPublishTime[index - 1].label
				}
				this.getTAList()
			},
			change2(index) {
				if (index == 1) {
					this.field2 = '全部'
				} else {
					this.field2 = this.optionsField[index - 1].label
				}
				this.getTAList()
			},
			changeTN1(index) {
				if (index == 1) {
					this.TNpublishTime = '全部'
				} else {
					this.TNpublishTime = this.optionsPublishTime[index - 1].label
				}
				this.getQueListByCategory()
			},
			changeTN2(index) {
				console.log(index)
				if (index == 1) {
					this.TNfield = '全部'
				} else {
					this.TNfield = this.optionsField[index - 1].label
				}
				this.getQueListByCategory()
			},
			
			
			
			reachBottom() {
				// 此tab为空数据
				if (this.current != 2) {
					this.loadStatus.splice(this.current, 1, "loading")
					setTimeout(() => {}, 1200);
				}
			},

			
	
			async getPNDesc(item) {
				uni.navigateTo({
					url: './finacingNeed/finacingNeed?item=' + JSON.stringify(item),
				});
		
			},
			async getPADesc(item) {
				uni.navigateTo({
					url: './peopleApply/peopleApply?item=' + JSON.stringify(item),
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
			},
		}
	}
</script>



<style lang="scss" scoped>
	$nav-height: 30px;
	.leader{
		display: flex;
		justify-content:center; //水平方向居中
		align-items:center; //垂直放下居中
		
		.search{
			font-size: 13rpx;
			
		}
	}
	.box {
		border-bottom: 1px solid;
		border-color: #e6e6e6;
		height: 200rpx;
		background: #FFFFFF;
		
		.content{
			size: a4;
		}
		
		.iconbox image {
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
	
	.swiper-box {
		flex: 1;
	}

	.swiper-item {
		height: 100%;
	}

	.uni-note {
		font-size: 13px;
		color: #adafb3;
		position: relative;
		left: 80%;
	}

	.title {
		font-weight: 400;
		font-size: 30rpx;
		position: relative;
		line-height: 1.3;
		padding-left: 25rpx;
		margin-top: 10rpx;
		margin-bottom: 30rpx;
		color: $uni-color-title;

		&:before {
			width: 4px;
			height: 12px;
			border-radius: 100rpx;
			background-color: $uni-color-primary;
			content: '';
			position: absolute;
			left: 6rpx;
			top: 3px;
		}
		}
		.city {
			/* #ifndef APP-PLUS-NVUE */
			display: flex;
			/* #endif */
			flex-direction: row;
			align-items: center;
			justify-content: flex-start;
			// width: 160rpx;
			margin-left: 1px;
		}
		.input-uni-icon {
			line-height: $nav-height;
		}
		.input-view {
		/* #ifndef APP-PLUS-NVUE */
			display: flex;
			/* #endif */
			flex-direction: row; //单行
			width: 100rpx;
			flex: 1;
			background-color: #f8f8f8;
			height: $nav-height;
			border-radius: 15px;
			padding: 0 59px;
			flex-wrap: nowrap; //换行
			margin: 7px 0;
			line-height: $nav-height;
			}		
						
			
		.nav-bar-input {
			height: $nav-height;
			line-height: $nav-height;
			/* #ifdef APP-PLUS-NVUE */
			width: 300rpx;
			/* #endif */
			padding: 5 5px;
			font-size: 15px;
			background-color: #f8f8f8;
			}
		.picker-view{
			line-height: 50rpx;
			width: 133rpx;
			display: flex;
			flex-direction: row;
		}
</style>


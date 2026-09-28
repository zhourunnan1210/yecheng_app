<template>
	<view class="content">
		<view class="wrap">
			<view class="u-tabs-box">
				<u-tabs-swiper activeColor="#1296db" ref="tabs" :list="list" :current="current" @change="tebchange"
					:is-scroll="false" swiperWidth="750" inactive-color="#000000"></u-tabs-swiper>
			</view>

			<!-- 科技成果 -->
			<swiper class="swiper-box" :current="swiperCurrent" @transition="transition" @animationfinish="animationfinish" style="height: 100vh;">
				<!-- 成果发布 -->
				<swiper-item class="swiper-item" style="height: 100%;width: 100%;">
					<scroll-view scroll-y style="height: 100%;width: 100%;" @scrolltolower="reachBottom">
						<u-dropdown>
							<u-dropdown-item v-model="publishTime" title="发布时间" :options="optionsPublishTime"@change="change1"></u-dropdown-item>
							<u-dropdown-item v-model="field" title="行业领域" :options="optionsField" @change="change2"></u-dropdown-item>
						</u-dropdown>
						
						<view class="box" v-for="(item,i) in TAList" @click="getTPDesc(item.technologyAchievementId)">
							<u-row>
								<u-col span="4">
									<view class="iconbox">
										<img :src="item.image"></img>
									</view>
								</u-col>
								<u-col span="8">
									<view class="textbox1 u-line-1">{{item.title}}
									</view>
									<view class="notebox1 u-line-1">分类：
										<u-tag :text="item.field" mode="plain" size="mini"
											style="{position: absolute; left: 30;}" />
									</view>
									<view class="notebox1 u-line-1">
										发布时间：{{$u.timeFormat(item.publishTime, 'yyyy-mm-dd')}}</view>
								</u-col>
							</u-row>
						</view>
						
					</scroll-view>
				</swiper-item>
				
				
				<!-- 科技需求 -->
				
				<swiper-item class="swiper-item">
					<scroll-view scroll-y style="height: 100%;width: 100%;">
						
						<u-dropdown>
							<u-dropdown-item v-model="publishTime" title="发布时间" :options="optionsPublishTime" @change="changeTN1"> </u-dropdown-item>
							<u-dropdown-item v-model="field" title="行业领域" :options="optionsField" @change="changeTN2"> </u-dropdown-item>
						</u-dropdown>
						
						<view class="box" v-for="(item,i) in TNList" @click="getTNDesc(item.technologyNeedId)">
							<u-row>
								
								<u-col span="4">
									<view class="iconbox">
										<img :src="item.image"></img>
									</view>
								</u-col>
								
								<u-col span="8">
									<view class="textbox1 u-line-1">{{item.title}}
									</view>
									<view class="notebox1 u-line-1">分类：{{item.category+" " }}
										<u-tag :text="item.field" mode="plain" size="mini"
											style="{position: absolute; left: 30;}" />
									</view>
									<view class="notebox1 u-line-1">
										发布时间：{{$u.timeFormat(item.publishTime, 'yyyy-mm-dd')}}</view>
								</u-col>
								
							</u-row>
						</view>
					</scroll-view>
				</swiper-item>
				
				<swiper-item class="swiper-item">
					<scroll-view scroll-y style="height: 100%;width: 100%;" @scrolltolower="reachBottom">
						<view class="box" v-for="(item,i) in schoolList" @click="getschoolDesc(item.schoolId)">
							<u-row>
								<u-col span="4">
									<view class="iconbox">
										<image :src="item.imageUrl"></image>
									</view>
								</u-col>
								<u-col span="8">
									<view class="textbox">{{item.name}}
									</view>
									<view class="notebox u-line-1">网站：{{item.website}}</view>
									<view class="notebox u-line-1">位置：{{item.location}}</view>
									<view class="notebox u-line-1">统一社会信用代码：{{item.code}}</view>
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
	import { needDefaultImage, isStaleOssUrl } from '../../../utils/imageUrl.js'
	export default {
		data() {
			return {
				DEFAULT_IMAGE:'/static/defaultImage/1.png',
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
				list: [{
						name: '成果发布'
					},
					{
						name: '科技需求'
					},
					{
						name: '高校院所'
					}
				],
				current: 0,
				swiperCurrent: 0,
				tabsHeight: 0,
				dx: 0,
				loadStatus: ['loadmore', 'loadmore', 'loadmore', 'loadmore'],
				tabbar: [],
				TAList: [],
				TNList: [],
				schoolList: [],
				questionList: []

			};
		},
		onLoad() {
			this.getTAList()
			this.getQueListByCategory()
			this.getIndex()
			this.getschoolList()

		},
		methods: {
			// 检查图片是否有效（为空或是失效OSS链接则返回默认图）
			checkImage(url) {
				if (needDefaultImage(url)) {
					return this.DEFAULT_IMAGE
				}
				return url
			},

			//获取科技成果列表
			async getTAList() {

				const res = await this.$myRequest({
					url: '/technologyAchievement/listByConditions',
					method: 'POST',
					header: {
						'content-type': 'application/json'
					},
					data: {
						"duration": this.publishTime2,
						"field": this.field2
					}
				});
				console.log(res)
				this.TAList = res.data.data
				this.TAList.forEach(item => {
					item.image = this.checkImage(item.image)
				})

		
			},

			//获取科技需求列表
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
				this.TNList.forEach(item => {
					item.image = this.checkImage(item.image)
				})
				

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
				console.log(res.data)
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


				// console.log(this.optionsPublishTime)


			},

			changeKeyName(objArr) {
				const keyMap = {
					name: "label",
					id: "value",
				};
				for (let i = 0; i < objArr.length; i++) {
					let obj = objArr[i];
					for (let key in obj) {
						let newKey = keyMap[key];
						if (newKey == "value") {
							obj[key] = i + 2
						}
						if (newKey) {
							obj[newKey] = obj[key];
							delete obj[key];
						}
					}
				}
				objArr.unshift({
					label: "全部",
					value: 1
				})
				return objArr
			},
			//获取高校院所列表
			async getschoolList() {
				const res = await this.$myRequest({
					url: '/schoolinfo/getlist',
					method: 'GET',
					header: {
						'content-type': 'application/json'
					}
				});
				// console.log(res)
				this.schoolList = res.data.data
				this.schoolList.forEach(item => {
					item.imageUrl = this.checkImage(item.imageUrl)
				})
			},

			async getschoolDesc(item) {
				uni.navigateTo({
					url: './schoolDetail/schoolDetail?item=' + item,
				});

			},
			reachBottom() {
				// 此tab为空数据
				if (this.current != 2) {
					this.loadStatus.splice(this.current, 1, "loading")
					setTimeout(() => {}, 1200);
				}
			},

			// tab栏切换
			tebchange(index) {
				this.swiperCurrent = index;

			},
			// 科技成果详情页跳转
			getTPDesc(item) {
				uni.navigateTo({
					url: './technologyAch/technologyAch?item=' + item
				});
			},
			// 科技需求详情页跳转
			getTNDesc(item) {
				uni.navigateTo({
					url: './technologyNeed/technologyNeed?item=' + item
				});
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
		}
	}
</script>



<style lang="scss" scoped>
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

	.content {
		font-size: 13px;
		color: #adafb3;
	}

	.title {
		font-size: 29rpx;
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

		.iconbox image {
			margin-left: 40rpx;
			margin-top: 28rpx;
			width: 80px;
			height: 80px;

		}


		.textbox1 {
			margin: 0 30rpx 5rpx 10rpx;
			padding: 10rpx 30rpx 5rpx 10rpx;
			font-weight: 500;
			color: #000000;
			line-height: 2.5;
			font-size: 28rpx;
		}

		.notebox1 {

			padding: 0 20rpx;
			font-size: 12px;
			color: #949494;
			line-height: 2;
		}

		.textbox {
			margin: 0 30rpx 5rpx 10rpx;
			padding: 10rpx 30rpx 5rpx 10rpx;
			font-weight: 500;
			color: #000000;
			line-height: 1.5;
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
</script>
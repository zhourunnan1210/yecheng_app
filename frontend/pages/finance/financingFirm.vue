
<template >
	
	<view class="content">
		<view class="wrap">
			
				<swiper-item class="swiper-item" style="height: 100%;width: 100%;">
					<scroll-view scroll-y style="height: 100%;width: 100%;" @scrolltolower="reachBottom">
						<u-dropdown>
							<u-dropdown-item v-model="auditFlag" title="审核进度" :options="options1" @change="change1">
							</u-dropdown-item>
							<u-dropdown-item v-model="industryField" title="行业领域" :options="options2" @change="change2" >
							</u-dropdown-item>
							<u-dropdown-item v-model="releaseTime" title="发布时间" :options="options3" @change="change3">
							</u-dropdown-item>
						</u-dropdown>
						<view class="box" v-for="(item,i) in TAList" @click="getTADesc(item.financingNeedId)">
							<u-row>
								<u-col span="3">
									<view class="iconbox">
										<img :src="item.projectImage"></img>
									</view>
								</u-col>
								<u-col span="5">
									<view class="textbox1 u-line-1">{{item.title}}
									</view>
									<view class="notebox1 u-line-1">行业领域：{{item.field}}
									<!-- {{item.}} -->
									</view>
									<!-- <view class="notebox1 u-line-1">	
										<u-tag :text="item.investingMoney" mode="plain" size="mini"></u-tag>
										<u-tag :text="item.investWay" mode="plain" size="mini" style="margin:10rpx;"></u-tag>
										<u-tag :text="item.investType" mode="plain" size="mini" style="margin:3rpx;" ></u-tag>
									</view> -->
									<view class="notebox1 u-line-1">
										发布时间：{{$u.timeFormat(item.publishTime, 'yyyy-mm-dd')}}</view>
								</u-col>
								<u-col span="3">
									<view class="status">
									<span v-if="item.auditFlag == 0">正在审核</span>
									<span v-else-if ="item.auditFlag == 1">审核通过</span>
									<span v-else ="item.auditFlag == 2">审核失败</span>
									</view>
								</u-col>
							</u-row>
						</view>
						<view class="box" v-for="(item,i) in TBList" @click="getTBDesc(item.investNeedId)">
							<u-row>
								<u-col span="3">
									<view class="iconbox">
										<img :src="item.investImag"></img>
									</view>
								</u-col>
								<u-col span="5">
									<view class="textbox1 u-line-1">{{item.companyName}}
									</view>
									<view class="notebox1 u-line-1">行业领域：{{item.industryField}}
									<!-- {{item.}} -->
									</view>
							
									<view class="notebox1 u-line-1">
										发布时间：{{$u.timeFormat(item.publishTime, 'yyyy-mm-dd')}}</view>
								</u-col>
								<u-col span="3">
									<view class="status">
										<span v-if="item.auditFlag == 0">正在审核</span>
										<span v-else-if ="item.auditFlag == 1">审核通过</span>
										<span v-else ="item.auditFlag == 2">审核失败</span>
									<!-- {{item.auditFlag}} -->
									</view>
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
				
				DEFAULT_IMAGE:'/static/defaultImage/1.png',
				auditFlag: '',
				// investType1: '',
				// investType2: '全部',
				// investType3: '全部',
				industryField: '',
				// industryField1: '',
				// industryField2: '全部',
				// industryField3: '全部',
				releaseTime: '',
				// investingMoney1: '',
				// investingMoney2: '全部',
				// investingMoney3: '全部',
				options1: [],
				options2: [],
				options3: [],
				current: 0,
				swiperCurrent: 0,
				tabsHeight: 0,
				dx: 0,
				loadStatus: ['loadmore', 'loadmore', 'loadmore', 'loadmore'],
				tabbar: [],
				TAList: [],
				TBList: [],
				// TNList: [],
				questionList: [],
				options1: [
						{
							label: '正在审核',
						    value: '0',
						},
						{
							label: '审核通过',
						    value: '1',
						},
						{
							label: '审核失败',
						    value: '2',
						},
						
						
										
					],
					options2: [{
								label: '全部',
								value:'全部',
							},
							
							{
								value: '电子信息技术领域',
								label: '电子信息技术领域'
							},
							{
								label: '生物与新医药技术领域',
								value: '生物与新医药技术领域',
							},
							{
								label: '航空航天技术领域',
								value: '航空航天技术领域'
							},
							{
								label: '新材料技术领域',
								value: '新材料技术领域'
							},
							{
								label: '高技术服务业领域',
								value: '高技术服务业领域'
							},
							{
								label: '新能源及节能技术领域',
								value: '新能源及节能技术领域'
							},
							{
								label: '资源与环境技术领域',
								value: '资源与环境技术领域'
							},
							{
								label: '先进制造与自动化领域',
								value: '先进制造与自动化领域'
							},
							{
								label: '其他',
								value: '其他'
							},
							
											
						],
						options3: [{
									label: '全部',
									value:'全部',
								},
								
								{
									label: '一个月内',
								    value: '一个月内',
								},
								{
									label: '三个月内',
								    value: '三个月内',
								},
								{
									label: '六个月内',
								    value: '六个月内',
								},
								{
									label: '一年内',
								    value: '一年内',
								},
								{
									label: '其他',
								    value: '其他',
								},
								
												
							],

			};
		},
		onLoad() {
			this.getTAList()
			this.getTBList()

		},
		
		methods: {
			// 获取投资需求列表
			async getTAList() {
				// console.log(111)
				const res = await this.$myRequest({
					url: '/investFinancialProj/getAuditList',
					method: 'POST',
					header: {
						'content-type': 'application/json'
					},
					data: {
						  "auditFlag": this.auditFlag,
						  "industryField": this.industryField,
						  "releaseTime": this.releaseTime,
						  
					},
				});
				console.log(res.data)
				this.TAList = res.data.financeList
				this.TAList.forEach(item => {
					if (!item.image) {
						item.image = this.DEFAULT_IMAGE
					}
				})

		
			},
			
			async getTBList() {
				// console.log(222)
				const res = await this.$myRequest({
					url: '/investFinancialProj/getAuditList',
					method: 'POST',
					header: {
						'content-type': 'application/json'
					},
					data: {
						  "auditFlag": this.auditFlag,
						  "industryField": this.industryField,
						  "releaseTime": this.releaseTime
					}
				});
				console.log(res.data)
				this.TBList = res.data.investList
				this.TBList.forEach(item => {
						if (!item.image) {
							item.image = this.DEFAULT_IMAGE
						}
					})
				
						
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
			// 需求详情页跳转
			
			async getTADesc(item) {
				uni.navigateTo({
					//investingneed/get/2
					url:  '/pages/detail/financing/financingNeed/financingNeed?item=' + JSON.stringify(item),
				});
			
			},
			async getTBDesc(item) {
				uni.navigateTo({
					//investingneed/get/2
					url:  '/pages/detail/financing/financingInst/financingInst?item=' + JSON.stringify(item),
				});
			
			},

			change1(index) {
				this.getTBList()
				this.getTAList()
			},
			change2(index) {
				this.getTBList()
				this.getTAList()
			},
			change3(index) {
				this.getTBList()
				this.getTAList()
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
			line-height: 2;
			font-size: 28rpx;
		}

		.notebox1 {

			padding: 0 20rpx;
			font-size: 15px;
			color: #949494;
			line-height: 1.5;
			
			//margin:10 ;
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
		.status {
			font-size: 35rpx;
			color: green;
		}

	}
</style>

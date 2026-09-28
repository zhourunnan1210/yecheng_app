<template>
	<view class="content">
		<view class="u-tabs-box">
			<u-tabs-swiper activeColor="#1296db" ref="tabs" :list="list" :current="current" @change="tebchange"
				:is-scroll="false" swiperWidth="750" inactive-color="#000000"></u-tabs-swiper>
		</view>
			<swiper class="swiper-box" :current="swiperCurrent" @transition="transition"
				@animationfinish="animationfinish" style="height: 100vh;">
				<swiper-item class="swiper-item" style="height: 100%;width: 100%;">
					<scroll-view scroll-y style="height: 100%;width: 100%;" @scrolltolower="reachBottom">
						<u-dropdown>
							<u-dropdown-item v-model="publishTime" title="发布时间" :options="options1" @change="change1">
							</u-dropdown-item>
							<u-dropdown-item v-model="field" title="行业领域" :options="options2"@change="change2">
							</u-dropdown-item>
							<u-dropdown-item v-model="financingMoney" title="融资金额" :options="options3"@change="change3">
							</u-dropdown-item>
						</u-dropdown>
						<view class="box" v-for="(item,i) in TAlist" @click="getTAlistDesc(item.financingNeedId)">
							<u-row>
								<u-col span="4">
									<view class="iconbox">
										<img :src="checkImage(item.projectImage)"></img>
									</view>
								</u-col>
								<u-col span="8">
									<view class="textbox1 u-line-1">{{item.title}}
									</view>
									<view class="notebox1 u-line-1">行业领域：{{item.field}}
									</view>
									<view class="notebox1 u-line-1">	
										<u-tag :text="item.financingMoney" mode="plain" size="mini"></u-tag>
										<u-tag :text="item.financingMethod" mode="plain" size="mini" style="margin:10rpx;"></u-tag>
										<u-tag :text="item.financingPhase" mode="plain" size="mini" style="margin:3rpx;"></u-tag>
										
									</view>
									<view class="notebox1 u-line-1">
										发布时间：{{$u.timeFormat(item.publishTime, 'yyyy-mm-dd')}}</view>
								</u-col>
							</u-row>
						</view>
					</scroll-view>
				</swiper-item>
				<swiper-item class="swiper-item" style="height: 100%;width: 100%;">
					<scroll-view scroll-y style="height: 100%;width: 100%;" @scrolltolower="reachBottom">
						<u-dropdown>
							<u-dropdown-item v-model="investType" title="投资类型" :options="optionsN1" @change="changeN1">
							</u-dropdown-item>
							<u-dropdown-item v-model="industryField" title="投资领域" :options="optionsN2"@change="changeN2">
							</u-dropdown-item>
							<u-dropdown-item v-model="investingMoney" title="投资金额" :options="optionsN3"@change="changeN3">
							</u-dropdown-item>
						</u-dropdown>
						<view class="box" v-for="(item,i) in TBlist" @click="getTBlistDesc(item.investNeedId)">
							<u-row>
								<u-col span="4">
									<view class="iconbox">
										<img :src="checkImage(item.investImag)"></img>
									</view>
								</u-col>
								<u-col span="8">
									<view class="textbox1 u-line-1">{{item.companyName}}
									</view>
									<view class="notebox1 u-line-1">行业领域：{{item.industryField}}
									</view>
									<view class="notebox1 u-line-1">	
										<u-tag :text="item.investingMoney" mode="plain" size="mini"></u-tag>
										<u-tag :text="item.investWay" mode="plain" size="mini" style="margin:10rpx;"></u-tag>
										<u-tag :text="item.investType" mode="plain" size="mini" style="margin:3rpx;"></u-tag>
										
									</view>
									<view class="notebox1 u-line-1">
										发布时间：{{$u.timeFormat(item.releaseTime, 'yyyy-mm-dd')}}</view>
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
	import { needDefaultImage, isStaleOssUrl } from '../../utils/imageUrl.js'
	export default {
		data() {
			return {
				DEFAULT_IMAGE:'/static/defaultImage/1.png',
				publishTime: '',
				field: '',
				financingMoney:'',
				projectImage:'',
				investType:'',
				industryField:'',
				investingMoney:'',
				optionsPublishTime: [],
				optionsField: [],
				current: 0,
				swiperCurrent: 0,
				tabsHeight: 0,
				dx: 0,
				loadStatus: ['loadmore', 'loadmore', 'loadmore', 'loadmore'],
				tabbar: [],
				TAlist: [],
				TBlist: [],
				list: [{
						name: '融资需求'
					},
					{
						name: '投资需求'
					},
					
				],
				questionList: [],
				options1: [{
							label: '全部',
							value: '全部',
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
					options2: [{
								label: '全部',
								value: '全部',
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
							    value: '其他',
							},
											
						],
						options3: [{
									label: '全部',
									value: '全部',
								},
								{
									label: '100万及以下',
								    value: '100万及以下',
								},
								{
									label: '101万-200万',
								    value: '101万-200万',
								},
								{
									label: '201万-300万',
								    value: '201万-300万',
								},
								{
									label: '301万-500万',
								    value: '301万-500万',
								},
								{
									label: '501万-1000万',
								    value: '501万-1000万',
								},
								
								{
									label: '1001万及以上',
								    value: '1001万及以上',
								},
								{
									label: '其他金额',
								    value: '其他金额',
								},
								
												
							],
				optionsN1: [{
							label: '全部',
							value: '全部',
						},
						{
							label: '保险投资',
						    value: '保险投资',
						},
						{
							label: '债权投资',
						    value: '债权投资',
						},
						{
							label: '股权投资',
						    value: '股权投资',
						},
						{
							label: '其他',
						    value: '其他',
						},
						
										
					],
					optionsN2: [{
								label: '全部',
								value: '全部',
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
							    value: '其他',
							},
											
						],
						optionsN3: [{
									label: '全部',
									value: '全部',
								},
								{
									label: '100万及以下',
								    value: '100万及以下',
								},
								{
									label: '101万-200万',
								    value: '101万-200万',
								},
								{
									label: '201万-300万',
								    value: '201万-300万',
								},
								{
									label: '301万-500万',
								    value: '301万-500万',
								},
								{
									label: '501万-1000万',
								    value: '501万-1000万',
								},
								
								{
									label: '1001万以上',
								    value: '1001万以上',
								},
								
								{
									label: '其他金额',
								    value: '其他金额',
								},
								
												
							],

			};
		},
		onLoad() {
			this.getTAlist()
			this.getTBlist()
			// this.getQueListByCategory()
			this.getIndex()
			

		},
		methods: {
			//获取融资需求列表
			async getTAlist() {

				const res = await this.$myRequest({
					url: '/financingneed/getList',
					method: 'POST',
					header: {
						'content-type': 'application/json'
					},
					data: {
						"duration": this.publishTime,
						"field": this.field,
						"financingMoney": this.financingMoney
						
					}
				});
				console.log(res.data,'111111')
				this.TAlist = res.data.data
				
		
			},
			async getTBlist() {
			
				const res = await this.$myRequest({
					url: '/investingneed/getList',
					method: 'POST',
					header: {
						'content-type': 'application/json'
					},
					data: {
						"industryField": this.industryField,
						"investType": this.investType,
						"investingMoney": this.investingMoney
						
					}
				});
				console.log(res.data,'111111')
				this.TBlist = res.data.data
				
					
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
			
			async getTAlistDesc(item) {
				uni.navigateTo({
					url:  '/pages/detail/financing/financingNeed/financingNeed?item=' + JSON.stringify(item),
				});
			
			},
			async getTBlistDesc(item) {
				uni.navigateTo({
					url:  '/pages/detail/financing/financingInst/financingInst?item=' + JSON.stringify(item),
				});
			
			},

			checkImage(url) {
				if (needDefaultImage(url)
					|| url.trim() === '') {
					return this.DEFAULT_IMAGE
				}
				return url
			},
			change1(index) {
				
				this.getTAlist()
			},
			change2(index) {
				
				this.getTAlist()
			},
			change3(index) {
				
				this.getTAlist()
			},
			changeN1(index) {
				
				this.getTBlist()
			},
			changeN2(index) {
				
				this.getTBlist()
			},
			changeN3(index) {
				
				this.getTBlist()
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
			font-size: 12px;
			color: #949494;
			line-height: 1;
			
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

	}
</style>
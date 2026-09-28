<template>
	<view class="content">
		<view class="wrap">
			
				<swiper-item class="swiper-item" style="height: 100%;width: 100%;">
					<scroll-view scroll-y style="height: 100%;width: 100%;" @scrolltolower="reachBottom">
						
						<u-dropdown>
							<u-dropdown-item v-model="loanDeadline" title="贷款期限" :options="options1" @change="change1">
							</u-dropdown-item>
							<u-dropdown-item v-model="loanType" title="贷款类型" :options="options2" @change="change2">
							</u-dropdown-item>
							<u-dropdown-item v-model="ensureMethod" title="担保方式" :options="options3" @change="change3">
							</u-dropdown-item>
							<u-dropdown-item v-model="loanMoney" title="贷款额度" :options="options4" @change="change4">
							</u-dropdown-item>
						</u-dropdown>
						<view class="box" v-for="(item,i) in all_index" @click="getIndexDesc(item.financialProductId)">
							<u-row>
								<u-col span="4">
									<view class="iconbox">
										<img :src="checkImage(item.image)"></img>
									</view>
								</u-col>
								<u-col span="8">
									<view class="textbox1 u-line-1">{{item.title}}
									</view>
									<view class="notebox1 u-line-1">参考利率范围：{{item.rate}}
									</view>
									<view class="notebox1 u-line-1">贷款额度：{{item.loanMoney}}
									</view>
									<view class="notebox1 u-line-1">贷款期限：{{item.loanDeadline}}
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
	import { needDefaultImage, isStaleOssUrl } from '../../utils/imageUrl.js'
	export default {
		data() {
			return {
				DEFAULT_IMAGE:'/static/defaultImage/1.png',
				ensureMethod: '',
				loanDeadline: '',
				loanMoney: '',
				loanType: '',
				current: 0,
				swiperCurrent: 0,
				tabsHeight: 0,
				dx: 0,
				loadStatus: ['loadmore', 'loadmore', 'loadmore', 'loadmore'],
				tabbar: [],
				all_index: [],
				questionList: [],
				options1: [{
							label: '全部',
							label: '全部',
						},
						{
							label: '3个月及以下',
						    value: '3个月及以下',
						},
						{
							label: '6个月及以下',
						    value: '6个月及以下',
						},
						{
							label: '12个月及以下',
						    value:'12个月及以下',
						},
						{
							label: '36个月及以下',
						    value: '36个月及以下',
						},
						{
							label: '36个月以上',
						    value: '36个月以上',
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
								label: '政府担保贴息类',
							    value: '政府担保贴息类',
							},
							{
								label: '银行自主产品',
							    value: '银行自主产品',
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
									label: '抵押',
								    value: '抵押',
								},
								{
									label: '质押',
								    value: '质押',
								},
								{
									label: '信保基金',
								    value: '信保基金',
								},
								{
									label: '一般保证',
								    value: '一般保证',
								},
								{
									label: '信用',
								    value: '信用',
								},
								{
									label: '其他',
								    value: '其他',
								},
												
							],
							options4: [{
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
						
				
				}
								
		},
		onLoad() {
			this.getAll_index()
			this.getIndex()
			

		},
		methods: {
			//获取金融产品列表
			async getAll_index() {

				const res = await this.$myRequest({
					url: '/financialproduct/getlist',
					method: 'POST',
					header: {
						'content-type': 'application/json'
					},
					data: {
						  "ensureMethod": this.ensureMethod,
						  "loanDeadline": this.loanDeadline,
						  "loanMoney": this.loanMoney,
						  "loanType": this.loanType
					}
				});
				this.all_index = res.data.data

		
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
			// 产品详情页跳转
			async getIndexDesc(item) {
				uni.navigateTo({
					url:  '/pages/detail/financing/financingPro/financingPro?item=' + JSON.stringify(item),
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
				
				this.getAll_index()
			},
			change2(index) {
				
				this.getAll_index()
			},
			change3(index) {
				
				this.getAll_index()
			},
			change4(index) {
				
				this.getAll_index()
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

	}
</style>
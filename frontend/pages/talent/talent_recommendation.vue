<template>
	<view class="content">
		<!-- 添加水平滑动容器 -->
		<swiper class="swiper-container" :indicator-dots="true" indicator-color="#ccc" indicator-active-color="#007aff">
			<!-- 推荐列表 -->
			<swiper-item>
				<scroll-view scroll-y class="scroll-view" @scrolltolower="reachBottom">
						<view class="dropdown-wrapper">
							<u-dropdown>
							<u-dropdown-item v-model="degree2" title="  学历  " :options="optionsDegree" @change="change1">
							</u-dropdown-item>
							<u-dropdown-item v-model="publishTime2" title="发布时间" :options="optionsPublishTime" @change="change2">
							</u-dropdown-item>
							<u-dropdown-item v-model="position2" title="意向岗位" :options="optionsPosition" @change="change3">
							</u-dropdown-item>
							</u-dropdown>
						</view>
						<view class="search-box">
							<view class="custom-search-bar">
								<uni-icons color="#999999" size="18" type="search" class="search-icon" />
								<input
									class="search-input"
									type="text"
									confirm-type="search"
									v-model="searchValue"
									@input="handleSearch"
									@confirm="search"
									placeholder="搜索姓名或职位"
								/>
								<view v-if="searchValue" class="clear-icon" @click="clearSearch">
									<uni-icons color="#999999" size="18" type="clear" />
								</view>
								<view v-else class="search-icon-placeholder"></view>
							</view>
						</view>
					<view v-for="(item,index) in TalentList" :key="index" class="box1" @click="getTalent(item.talentSupplyId)">
						<u-row align="center">
							<u-col span="4">
								<view class="iconbox1">
									<image :src="checkImage(item.image)" mode="aspectFit" style="width: 180rpx; height: 180rpx;" />
								</view>
							</u-col>

							<u-col span="8">
								<view class="textbox">{{item.name}}</view>
								<view class="notebox u-line-1">学历：{{degreelist[item.degree]}}</view>
								<view class="notebox u-line-1">应聘职位：{{item.profession}}</view>
								<view class="notebox u-line-1">期望薪资：{{item.salaryMin}}k-{{item.salaryMax}}k</view>
								<view class="notebox u-line-1">发布时间：{{item.publishTime}}  </view>
							</u-col>
						</u-row>
					</view>
				</scroll-view>
			</swiper-item>
			
			<!-- 喜欢列表 -->
			<swiper-item>
				<scroll-view scroll-y class="scroll-view">
					<view class="section-title">我的喜欢</view>
					<view v-if="likedItems.length === 0" class="empty-state">
						<text class="empty-text">暂无喜欢的简历</text>
					</view>
					<view v-for="(item,index) in likedItems" :key="index" class="box1" @click="getTalent(item.id)">
						<u-row align="center">
							<u-col span="4">
								<view class="iconbox1">
									<image :src="checkImage(item.image)" mode="aspectFit" style="width: 180rpx; height: 180rpx;" />
								</view>
							</u-col>

							<u-col span="8">
								<view class="textbox">{{item.title}}</view>
								<view class="notebox u-line-1">学历：{{degreelist[item.degree]}}</view>
								<view class="notebox u-line-1">应聘职位：{{item.job}}</view>
								<view class="notebox u-line-1">期望薪资：{{item.salary}}</view>
								<view class="notebox u-line-1">发布时间：{{item.publish_time}}  </view>
							</u-col>
						</u-row>
					</view>
				</scroll-view>
			</swiper-item>
			
			<!-- 不喜欢列表 -->
			<swiper-item>
				<scroll-view scroll-y class="scroll-view">
					<view class="section-title">我的不喜欢</view>
					<view v-if="dislikedItems.length === 0" class="empty-state">
						<text class="empty-text">暂无不喜欢的简历</text>
					</view>
					<view v-for="(item,index) in dislikedItems" :key="index" class="box1" @click="getTalent(item.id)">
						<u-row align="center">
							<u-col span="4">
								<view class="iconbox1">
									<image :src="checkImage(item.image)" mode="aspectFit" style="width: 180rpx; height: 180rpx;" />
								</view>
							</u-col>

							<u-col span="8">
								<view class="textbox">{{item.title}}</view>
								<view class="notebox u-line-1">学历：{{degreelist[item.degree]}}</view>
								<view class="notebox u-line-1">应聘职位：{{item.job}}</view>
								<view class="notebox u-line-1">期望薪资：{{item.salary}}</view>
								<view class="notebox u-line-1">发布时间：{{item.publish_time}}  </view>
							</u-col>
						</u-row>
					</view>
				</scroll-view>
			</swiper-item>
		</swiper>
	</view>
</template>

<script>
	import { needDefaultImage, isStaleOssUrl } from '../../utils/imageUrl.js'
	import global from 'store/global.js'
	import { getSmartTalentRecommendations } from '@/utils/recommendation.js'
	
	export default {
		data() {
			return {
				model:
					{
					  userid:'',
					  businessAddress: '',
					  businessId:'' ,
					  businessPosition:' ',
					  companyId:'',
					  contactAddress: '',
					  contactPosition:'',
					  degree: '',
					  demand: '',
					  education: '',
					  email:'',
					  image:'',
					  job: '',
					  location:'',
					  name: '',
					  netAddress: '',
					  phone: '',
					  title1: '',
					  title2: '',
					  title3:'',
					},
				list: [{
						name: '简历推荐'
					},
					{
						name: '职位发布'
					},
					{
						name: '简历管理'
					},
				],
				degreelist: { 1: '博士', 2: '硕士', 3: '本科', 4: '专科', 5: '中专', 6: '高中' },
				current: 0,
				swiperCurrent: 0,
				dx: 0,
				searchValue: '',
				degree: '',
				StateIndex: 0,
				index: 0,
				TalentList: [],
				rawTalentList: [],
				degree: '',
				condition:'',
				degree2: '全部',
				publishTime2: '全部',
        position2: '全部',
				optionsDegree: [{
						label: "全部",
						value: "全部",
					},
					{
						label: "博士",
						value: "1",
					},
					{
						label: "硕士",
						value: "2",
					},
					{
						label: "本科",
						value: "3",
					},
					{
						label: "专科",
						value: "4",
					}
				],
				optionsPublishTime: [{
						label: "全部",
						value: "全部",
					},
					{
						label: "一个月内",
						value: "一个月内",
					},
					{
						label: "三个月内",
						value: "三个月内",
					},
					{
						label: "六个月内",
						value: "六个月内",
					},
					{
						label: "一年内",
						value: "一年内",
					},
				],
        optionsPosition: [{
        		label: "全部",
        		value: "全部",
        	},
        	{
        		label: "Java后端开发",
        		value: "Java后端开发",
        	},
        	{
        		label: "前端开发",
        		value: "前端开发",
        	},
        	{
        		label: "嵌入式开发",
        		value: "嵌入式开发",
        	},
        	{
        		label: "Android开发工程师",
        		value: "Android开发工程师",
        	},
        ],
				// 新增数据
				likedItems: [],      // 喜欢列表
				dislikedItems: [],   // 不喜欢列表
				DEFAULT_IMAGE: '/static/defaultImage/1.png'
			}
		},
		onLoad() {
			this.tabbar = global.tabbar;
			this.GetTalentList();
			this.getLikedItems();
			this.getDislikedItems();
			
			// 监听推荐更新事件
			uni.$on('recommendation-updated', this.handleRecommendationUpdate);
		},
		
		onShow() {
			// 页面显示时重新加载数据，解决刷新白屏问题
			if (this.$store.state.userInfo.uid) {
				this.GetTalentList();
				this.getLikedItems();
				this.getDislikedItems();
			}
		},
		
		onUnload() {
			// 页面卸载时移除事件监听
			uni.$off('recommendation-updated', this.handleRecommendationUpdate);
		},

		methods: {
			checkImage(url) {
				if (needDefaultImage(url)
					|| url.trim() === '') {
					return this.DEFAULT_IMAGE
				}
				return url
			},
			change1(index) {
				if (index == '全部') {
					this.degree2 = '全部'
				} else {
					this.degree2 = index
				}
				this.applyFilters()
			},
			change2(index) {
				if (index == '全部') {
					this.publishTime2 = '全部'
				} else {
					this.publishTime2 = index
				}
				this.applyFilters()
			},
			change3(index) {
				if (index == '全部') {
					this.position2 = '全部'
				} else {
					this.position2 = index
				}
				this.applyFilters()
			},

			//人才列表申请
			async GetTalentList() {
				// 检查用户是否已登录
				if (!this.$store.state.userInfo.uid) {
					console.log('用户未登录，无法获取推荐列表');
					this.TalentList = [];
					return;
				}
				
				this.model.userid = this.$store.state.userInfo.uid
				console.log('用户ID:', this.model.userid)
				
				try {
					// 使用智能推荐函数
					this.rawTalentList = await getSmartTalentRecommendations(this.model.userid);
					// 图片兜底
					if (this.rawTalentList && this.rawTalentList.length > 0) {
						this.rawTalentList.forEach(item => {
							if (needDefaultImage(item.image)) {
								item.image = this.DEFAULT_IMAGE
							}
						})
					}
					this.applyFilters();
				} catch (error) {
					console.error('获取推荐列表失败:', error);
					this.rawTalentList = [];
					this.TalentList = [];
				}
			},
			
			// 获取喜欢列表
			async getLikedItems() {
				// 检查用户是否已登录
				if (!this.$store.state.userInfo.uid) {
					console.log('用户未登录，无法获取喜欢列表');
					this.likedItems = [];
					return;
				}
				
				try {
					console.log('开始获取喜欢列表，用户ID:', this.$store.state.userInfo.uid);
					const [error, res] = await uni.request({
						url: `http://localhost:10086/api/behavior/liked/${this.$store.state.userInfo.uid}?targetType=2`,
						method: 'GET',
						header: {
							'content-type': 'application/json'
						}
					});
					
					if (error) {
						throw error;
					}
					
					console.log('喜欢列表API响应:', res);
					
					if (res.data.code === 0) {
						this.likedItems = res.data.data || [];
						this.likedItems.forEach(item => {
							if (needDefaultImage(item.image)) {
								item.image = this.DEFAULT_IMAGE
							}
						})
						console.log('喜欢列表获取成功，共', this.likedItems.length, '条记录');
					} else {
						console.error('喜欢列表获取失败:', res.data.msg);
						this.likedItems = [];
					}
				} catch (error) {
					console.error('获取喜欢列表失败:', error);
					this.likedItems = [];
				}
			},
			
			// 获取不喜欢列表
			async getDislikedItems() {
				// 检查用户是否已登录
				if (!this.$store.state.userInfo.uid) {
					console.log('用户未登录，无法获取不喜欢列表');
					this.dislikedItems = [];
					return;
				}
				
				try {
					console.log('开始获取不喜欢列表，用户ID:', this.$store.state.userInfo.uid);
					const [error, res] = await uni.request({
						url: `http://localhost:10086/api/behavior/disliked/${this.$store.state.userInfo.uid}?targetType=2`,
						method: 'GET',
						header: {
							'content-type': 'application/json'
						}
					});
					
					if (error) {
						throw error;
					}
					
					console.log('不喜欢列表API响应:', res);
					
					if (res.data.code === 0) {
						this.dislikedItems = res.data.data || [];
						this.dislikedItems.forEach(item => {
							if (needDefaultImage(item.image)) {
								item.image = this.DEFAULT_IMAGE
							}
						})
						console.log('不喜欢列表获取成功，共', this.dislikedItems.length, '条记录');
					} else {
						console.error('不喜欢列表获取失败:', res.data.msg);
						this.dislikedItems = [];
					}
				} catch (error) {
					console.error('获取不喜欢列表失败:', error);
					this.dislikedItems = [];
				}
			},
			
			// 应用本地筛选条件
			applyFilters() {
				let filtered = [...this.rawTalentList];

				// 学历筛选
				if (this.degree2 !== '全部') {
					const degreeValue = parseInt(this.degree2);
					filtered = filtered.filter(item => item.degree === degreeValue);
				}

				// 意向岗位筛选
				if (this.position2 !== '全部') {
					filtered = filtered.filter(item => item.profession === this.position2);
				}

				// 发布时间筛选
				if (this.publishTime2 !== '全部') {
					let months = 0;
					switch (this.publishTime2) {
						case '一个月内': months = 1; break;
						case '三个月内': months = 3; break;
						case '六个月内': months = 6; break;
						case '一年内': months = 12; break;
					}
					if (months > 0) {
						const cutoff = new Date();
						cutoff.setMonth(cutoff.getMonth() - months);
						filtered = filtered.filter(item => {
							if (!item.publishTime) return false;
							return new Date(item.publishTime) >= cutoff;
						});
					}
				}

					// 搜索框关键词过滤（姓名或职位）
					if (this.searchValue && this.searchValue.trim() !== '') {
						const keyword = this.searchValue.trim().toLowerCase();
						filtered = filtered.filter(item => {
							const nameMatch = item.name && item.name.toLowerCase().includes(keyword);
							const professionMatch = item.profession && item.profession.toLowerCase().includes(keyword);
							return nameMatch || professionMatch;
						});
					}

				this.TalentList = filtered;
				console.log('筛选后简历数量:', filtered.length, '学历:', this.degree2, '岗位:', this.position2, '时间:', this.publishTime2);
			},

			// 处理推荐更新事件
			handleRecommendationUpdate(data) {
				console.log('收到推荐更新事件:', data);
				// 重新获取所有数据
				this.GetTalentList();
				this.getLikedItems();
				this.getDislikedItems();
			},
			
			/* 点击进入人才详情页 */
			getTalent(talentSupplyId) {
				console.log('人才推荐页面ID',talentSupplyId)
				uni.navigateTo({
					url: "/pages/talent/talentinsidet?talentSupplyId=" + talentSupplyId
				});
			},
			//头像选择
			chooseAvater() {
				this.chooseAvaters = true
			},
			editAvater(index) {
				if (index === 0) {
					this.chooseImage()
				} else {
					this.previewImage()
				}
			},

			chooseImage() {
				uni.chooseImage({
					count: 1, //限制图片上传数量，封顶9张
					success: (res) => { //拿到图片的返回数据
						this.imgArr = res.tempFilePaths
					}
				})
			},
			previewImage() {
				uni.previewImage({
					urls: [this.imgArr], //拿头像地址
				})
			},
				// 搜索框：实时搜索姓名或职位
				handleSearch(e) {
					this.searchValue = e.target.value;
					this.applyFilters();
				},
				// 清空搜索
				clearSearch() {
					this.searchValue = '';
					this.applyFilters();
				},
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
		},
	}
</script>

<style lang="scss">
	.content {
		height: 100vh;
	}
	
	.swiper-container {
		height: 100%;
	}
	
	.scroll-view {
		height: 100%;
		padding: 20rpx 0;
	}
	
	.section-title {
		font-size: 36rpx;
		font-weight: bold;
		color: #333;
		margin-bottom: 30rpx;
		text-align: center;
	}
	
		.dropdown-wrapper {
			padding: 0 20rpx;
		}

		.search-box {
			width: 100%;
			padding: 10rpx 20rpx;
			box-sizing: border-box;
		}
		.custom-search-bar {
			display: flex;
			flex-direction: row;
			align-items: center;
			height: 72rpx;
			background-color: #f8f8f8;
			border-radius: 36rpx;
			border: 1rpx solid #e5e5e5;
			padding: 0 20rpx;
			width: 100%;
			box-sizing: border-box;
		}
		.search-icon {
			width: 40rpx;
			display: flex;
			justify-content: flex-start;
			align-items: center;
			flex-shrink: 0;
		}
		.search-input {
			flex: 1;
			font-size: 28rpx;
			color: #333;
			height: 100%;
			background: transparent;
			border: none;
			padding: 0;
			margin: 0;
			text-align: center;
		}
		.clear-icon {
			width: 40rpx;
			display: flex;
			justify-content: center;
			align-items: center;
			flex-shrink: 0;
		}
		.search-icon-placeholder {
			width: 40rpx;
			flex-shrink: 0;
		}


	.empty-state {
		display: flex;
		justify-content: center;
		align-items: center;
		height: 400rpx;
	}
	
	.empty-text {
		color: #999;
		font-size: 28rpx;
	}

	.resumephoto {
		width: 100%;
		height: 15%;
		display: flex;
		justify-content: center;

		.photo image {
			width: 80px;
			height: 80px;
			border-radius: 100%;
			padding: 10px;
			align-items: center;
			background-color: #ffe9ea;
		}
	}

	.resumename {
		display: flex;
		justify-content: center;
		font-size: 40rpx;
		font-weight: 400rpx;
	}

	.self {
		display: flex;
		height: auto;
		width: auto;
		justify-content: center;

		.self_list {
			padding: 5rpx 10rpx;
			background-color: #e5e572;
			font-size: 30rpx;
			margin: 20rpx;
		}
	}

	.resumelist {
		font-size: 35rpx;
		font-weight: bold;
		padding: 9rpx 0rpx;

		.title {
			color: #007AFF;
			padding: 15rpx 10rpx;
			background-color: #ffffff;
			margin-top: 10rpx;
		}

		.titie_list {
			background-color: #ffffff;
			font-size: 30rpx;
			padding: 5rpx 30rpx;
			color: #000000;
			display: flex;
		}

		.InputMessage {
			width: 400rpx;
			padding-left: 50rpx;
		}

		.ChooseMessage {
			width: 100%;
			height: 50rpx;
			padding-bottom: 50rpx;
			padding-left: 10rpx;
		}
	}

	.box1 {
		border-bottom: 1px solid;
		border-color: #e6e6e6;
		min-height: 200rpx;
		background: #FFFFFF;
		padding: 15rpx 20rpx;
		display: flex;
		align-items: center;

		.iconbox1 image {
			margin-left: 40rpx;
			width: 80px;
			height: 80px;
		}

		.textbox {
			margin: 0 10rpx 12rpx 10rpx;
			padding: 10rpx 10rpx 5rpx 10rpx;
			font-weight: 750;
			color: #000000;
			line-height: 1.4;
			font-size: 28rpx;
		}

		.notebox {
			padding: 4rpx 20rpx;
			font-size: 12px;
			color: #949494;
			line-height: 1.6;
		}
	}
</style>

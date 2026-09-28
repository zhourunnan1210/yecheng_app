<template>
	<view class="content">
		<!-- 添加水平滑动容器 -->
		<swiper class="swiper-container" :indicator-dots="true" indicator-color="#ccc" indicator-active-color="#007aff">
			<!-- 推荐列表 -->
			<swiper-item>
				<scroll-view scroll-y class="scroll-view" @scrolltolower="reachBottom">
					<view class="section-title">推荐岗位</view>
					

					<u-dropdown>
						<u-dropdown-item v-model="degree" title="  最低学历  " :options="optionsDegree" @change="change1">
						</u-dropdown-item>
						<u-dropdown-item v-model="talentType" title="发布时间" :options="optionsPublishTime" @change="change2">
						</u-dropdown-item>
						<u-dropdown-item v-model="position" title="岗位" :options="optionsPosition" @change="change3">
						</u-dropdown-item>
					</u-dropdown>
					<uni-search-bar @confirm="search" :focus="true" v-model="searchValue" @blur="blur" @input="input"
						@cancel="cancel" @change="change" @clear="clear">
					</uni-search-bar>
					<view v-for="(item,index) in TalentList" :key="index" class="box1" @click="getTalent(item.talentNeedId)">
						<u-row align="center">
							<u-col span="4">
								<view class="iconbox1">
									<image :src="checkImage(item.image)" mode="aspectFit" style="width: 180rpx; height: 180rpx;" />
								</view>
							</u-col>

							<u-col span="8">
								<view class="textbox">{{item.position}}</view>
								<view class="notebox u-line-1">最低范围：{{degreelist[item.degree]}}</view>
								<view class="notebox u-line-1">招聘岗位：{{item.position}}</view>
								<view class="notebox u-line-1">起步薪资：{{item.salaryMin}}k-{{item.salaryMax}}k</view>
								<view class="notebox u-line-1">发布时间：{{item.publishTime}}</view>
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
						<text class="empty-text">暂无喜欢的岗位</text>
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
								<view class="notebox u-line-1">最低范围：{{degreelist[item.degree]}}</view>
								<view class="notebox u-line-1">招聘岗位：{{item.job}}</view>
								<view class="notebox u-line-1">起步薪资：{{item.salary}}</view>
								<view class="notebox u-line-1">发布时间：{{item.publish_time}}</view>
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
						<text class="empty-text">暂无不喜欢的岗位</text>
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
								<view class="notebox u-line-1">最低范围：{{degreelist[item.degree]}}</view>
								<view class="notebox u-line-1">招聘岗位：{{item.job}}</view>
								<view class="notebox u-line-1">起步薪资：{{item.salary}}</view>
								<view class="notebox u-line-1">发布时间：{{item.publish_time}}</view>
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
	import { getSmartJobRecommendations, testBackendService } from '@/utils/recommendation.js'
	
	export default {
		data() {
			return {
				model: {
					userid:'',
					searchValue: '',
					condition: '',
					businessAddress: '',
					businessId: '',
					businessPosition: ' ',
					companyId: '',
					contactAddress: '',
					contactPosition: '',
					degree: '',
					demand: '',
					education: '',
					email: '',
					image: '',
					job: '',
					location: '',
					name: '',
					netAddress: '',
					phone: '',
					title1: '',
					title2: '',
					title3: '',
				},
				degreelist: ['', '专科', '本科', '硕士', '博士'],
				chooseAvaters: false, // 操作菜单的显示隐藏
				lists: [ // 操作菜单的列表内容
					{
						text: '更换头像',
						color: '',
						fontSize: 28,
					},
					{
						text: '查看大图',
						color: '',
						fontSize: 28,
					}
				],
				optionsArea: [

				],
				message: {
					phone: '',
					hopejob: '',
				},
				imgArr: '../../../../static/font/fuwujigou.png',
				array: [{
					name: '全职'
				}, {
					name: '兼职'
				}, {
					name: '实习'
				}, {
					name: '咨询'
				}],
				StateArray: [{
					name: '已离职'
				}, {
					name: '应届生'
				}, {
					name: '正在办理离职'
				}],
				StateIndex: 0,
				index: 0,
				jobtime: "全职",
				current: 0,
				swiperCurrent: 0,
				dx: 0,
				searchValue: '123123',
				inputcontent: '', //输入内容
				TalentList: '',
				degree2: '全部',
				publishTime2: '全部',
        position2: '全部',
				optionsDegree: [{
						label: "全部",
						value: "全部",
					},
					{
						label: "本科",
						value: "1",
					},
					{
						label: "硕士",
						value: "2",
					},
					{
						label: "博士",
						value: "3",
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
			this.testBackendAndLoadData();
			this.getLikedItems();
			this.getDislikedItems();
			
			// 监听推荐更新事件
			uni.$on('recommendation-updated', this.handleRecommendationUpdate);
		},
		
		onShow() {
			// 页面显示时重新加载数据，解决刷新白屏问题
			if (this.$store.state.userInfo.uid) {
				this.testBackendAndLoadData();
				this.getLikedItems();
				this.getDislikedItems();
			}
		},
		
		onUnload() {
			// 页面卸载时移除事件监听
			uni.$off('recommendation-updated', this.handleRecommendationUpdate);
		},
		methods: {
			// 测试后端服务并加载数据
			async testBackendAndLoadData() {
				try {
					console.log('开始测试后端服务连接...');
					// 先测试后端服务是否可用
					const isBackendAvailable = await testBackendService();
					if (!isBackendAvailable) {
						console.error('后端服务不可用');
						uni.showToast({
							title: '后端服务不可用，请检查服务状态',
							icon: 'error',
							duration: 5000
						});
						return;
					}
					
					console.log('后端服务连接成功，开始加载推荐数据...');
					// 后端服务可用，加载推荐数据
					await this.getTalentList();
				} catch (error) {
					console.error('测试后端服务失败:', error);
					console.error('错误详情:', error.message);
					console.error('错误堆栈:', error.stack);
					
					// 根据错误类型显示不同的提示
					let errorMessage = '连接服务器失败';
					if (error.errMsg && error.errMsg.includes('timeout')) {
						errorMessage = '连接超时，请检查网络';
					} else if (error.errMsg && error.errMsg.includes('fail')) {
						errorMessage = '无法连接到服务器，请检查后端服务是否启动';
					}
					
					uni.showToast({
						title: errorMessage,
						icon: 'error',
						duration: 3000
					});
				}
			},
			
			async search(fresh) {
				this.condition = fresh.value
				const [error, res] = await uni.request({
					url: 'http://localhost:10086/talentneed/listByCondition',
					method: 'POST',
					header: {
						'content-type': 'application/json'
					},
					data: {
						"condition": this.condition,
					}
				});
				
				if (error) {
					throw error;
				}
				
				console.log(res,'111111')
				this.TalentList = res.data.data
			},
			change1(index) {
				if (index == '全部') {
					this.degree2 = '全部'
				} else {

					this.degree2 = index
				}
				this.getTalentList()
			},
			change2(index) {
				if (index == '全部') {
					this.publishTime2 = '全部'
				} else {

					this.publishTime2 = index
				}
				this.getTalentList()
			},
      change3(index) {
      	if (index == '全部') {
      		this.position2 = '全部'
      	} else {

      		this.position2 = index
      	}
      	this.getTalentList()
      },
			/* 点击进入企业详情页 */
			getTalent(talentNeedId) {
				console.log(talentNeedId)
				uni.navigateTo({
					url: "/pages/talent/interview_application?talentNeedId=" + talentNeedId
				});
			},
			/*企业列表*/
			checkImage(url) {
				if (needDefaultImage(url)
					|| url.trim() === '') {
					return this.DEFAULT_IMAGE
				}
				return url
			},

			async getTalentList() {
				// 检查用户是否已登录
				if (!this.$store.state.userInfo.uid) {
					console.log('用户未登录，无法获取推荐列表');
					this.TalentList = [];
					return;
				}
				
				this.model.userid = this.$store.state.userInfo.uid
				
				try {
					// 使用智能推荐函数
					this.TalentList = await getSmartJobRecommendations(this.model.userid);

						// 图片兜底
						if (this.TalentList && this.TalentList.length > 0) {
							this.TalentList.forEach(item => {
								if (needDefaultImage(item.image)) {
									item.image = this.DEFAULT_IMAGE
								}
							})
						}
					
					if (this.TalentList && this.TalentList.length > 0) {
						console.log(`推荐成功: 获取到 ${this.TalentList.length} 个岗位`);
						
						// 显示用户友好的提示
						uni.showToast({
							title: `为您推荐了 ${this.TalentList.length} 个岗位`,
							icon: 'success',
							duration: 2000
						});
					} else {
						console.log('没有找到匹配的岗位，可能原因：');
						console.log('1. 用户没有喜欢过任何岗位');
						console.log('2. 数据库中岗位数据不足');
						console.log('3. 后端服务未启动');
						console.log('4. 网络连接问题');
						console.log('5. 用户ID无效或未登录');
						
						// 显示用户友好的提示
						uni.showToast({
							title: '暂无推荐岗位，请稍后再试',
							icon: 'none',
							duration: 3000
						});
					}
				} catch (error) {
					console.error('获取推荐列表失败:', error);
					
					// 显示用户友好的错误信息
					uni.showToast({
						title: '获取推荐失败，请稍后重试',
						icon: 'none',
						duration: 3000
					});
					
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
						url: `http://localhost:10086/api/behavior/liked/${this.$store.state.userInfo.uid}?targetType=1`,
						method: 'GET',
						header: {
							'content-type': 'application/json'
						}
					});
					
					if (error) {
						throw error;
					}
					
					console.log('喜欢列表API响应:', res.data);
					this.likedItems = res.data.data || [];
						this.likedItems.forEach(item => {
							if (needDefaultImage(item.image)) {
								item.image = this.DEFAULT_IMAGE
							}
						})
					console.log('喜欢列表数据:', this.likedItems);
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
						url: `http://localhost:10086/api/behavior/disliked/${this.$store.state.userInfo.uid}?targetType=1`,
						method: 'GET',
						header: {
							'content-type': 'application/json'
						}
					});
					
					if (error) {
						throw error;
					}
					
					console.log('不喜欢列表API响应:', res.data);
					this.dislikedItems = res.data.data || [];
						this.dislikedItems.forEach(item => {
							if (needDefaultImage(item.image)) {
								item.image = this.DEFAULT_IMAGE
							}
						})
					console.log('不喜欢列表数据:', this.dislikedItems);
				} catch (error) {
					console.error('获取不喜欢列表失败:', error);
					this.dislikedItems = [];
				}
			},
			
			// 处理推荐更新事件
			handleRecommendationUpdate(data) {
				console.log('收到推荐更新事件:', data);
				// 重新获取所有数据
				this.getTalentList();
				this.getLikedItems();
				this.getDislikedItems();
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



			//选择器
			bindPickerChange1: function(e) {
				this.StateIndex = e.detail.value;
			},
			bindPickerChange2: function(e) {
				this.index = e.detail.value;
			},
			//点击头像操作
			ImageClick() {
				uni.chooseImage({
					count: 1,
					sizeType: ['original', 'compressed'], // 可以指定是原图还是压缩图，默认二者都有
					sourceType: ['album', 'camera'], // 可以指定来源是相册还是相机，默认二者都有
				})
			},
			click1() {
				uni.navigateTo({
					url: "/pages/talent/businessinsidet",
				})
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
		padding: 20rpx;
	}
	
	.section-title {
		font-size: 36rpx;
		font-weight: bold;
		color: #333;
		margin-bottom: 30rpx;
		text-align: center;
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
		padding: 15rpx 0;
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

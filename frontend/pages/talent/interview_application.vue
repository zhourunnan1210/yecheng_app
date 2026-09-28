<template>
	<view class="mainclass">
		<!-- 添加加载状态 -->
		<view v-if="loading" class="loading-container">
			<text class="loading-text">加载中...</text>
		</view>
		
		<!-- 添加错误状态 -->
		<view v-else-if="error" class="error-container">
			<text class="error-text">{{ error }}</text>
			<button @click="retryLoad" class="retry-btn">重试</button>
		</view>
		
		<!-- 主要内容 -->
		<view v-else-if="DataInside" class="content">
			<u-grid :col="1">
				<u-grid-item>
					<u-image width="550px" height="150px" :src="checkImage(DataInside.image)"></u-image>
				</u-grid-item>
			</u-grid>

			<u-row>
				<text class="company-name">{{(DataInside.businessInfoEntity && DataInside.businessInfoEntity.name) || '公司名称'}}</text>
			</u-row>
			<u-row>
				<u-col span="12">
					<view class="title">
						能力需求
					</view>
					<text decode class="u-content-color u-m-r-20 u-m-l-20 u-m-t-80 u-font-28 textbox">{{DataInside.demand || '暂无需求描述'}}
					</text>
				</u-col>
			</u-row>
			<u-row>
				<u-col span="12">
					<view class="title">
						工作职责
					</view>
					<text decode class="u-content-color u-m-r-20 u-m-l-20 u-m-t-80 u-font-28 textbox u-m-b-30">{{DataInside.job || '暂无工作职责描述'}}
					</text>
				</u-col>
			</u-row>
			<u-row>
				<view class="title">
					公司信息
				</view>
				<u-col span="12">
					<view class="text">网址：
						<text class="u-main-color">
							{{(DataInside.businessInfoEntity && DataInside.businessInfoEntity.website) || '暂无'}}
						</text>
					</view>
				</u-col>
				<u-col span="12">
					<view class="text">联系电话：
						<text class="u-main-color">
							{{(DataInside.businessInfoEntity && DataInside.businessInfoEntity.telephone) || '暂无'}}
						</text>
					</view>
				</u-col>
				<u-col span="12">
					<view class="text">邮箱：
						<text class="u-main-color">
							{{(DataInside.businessInfoEntity && DataInside.businessInfoEntity.email) || '暂无'}}
						</text>
					</view>
				</u-col>
			</u-row>
			<!-- 申请面试和操作按钮 -->
			<view class="action-footer">
				<view class="apply-section">
					<!-- 根据申请状态显示不同的按钮 -->
					<u-button 
						v-if="applicationStatus === null || applicationStatus === undefined"
						@click="applyForInterview" 
						type="primary" 
						:ripple="true"
						:disabled="applying"
					>
						{{ applying ? '申请中...' : '申请面试' }}
					</u-button>
					
					<u-button 
						v-else-if="applicationStatus === 0"
						type="warning" 
						:ripple="false"
						disabled
					>
						已申请，等待处理
					</u-button>
					
					<u-button 
						v-else-if="applicationStatus === 1"
						type="success" 
						:ripple="false"
						disabled
					>
						已同意面试
					</u-button>
					
					<u-button 
						v-else-if="applicationStatus === 2"
						type="error" 
						:ripple="false"
						disabled
					>
						申请已被拒绝
					</u-button>
				</view>
				
				<view class="action-buttons">
					<button @click="likeJob" :class="['action-btn', 'like-btn', currentStatus === 1 ? 'active' : 'inactive']">
						👍 喜欢
					</button>
					<button @click="dislikeJob" :class="['action-btn', 'dislike-btn', currentStatus === 2 ? 'active' : 'inactive']">
						👎 不喜欢
					</button>
				</view>
			</view>
		</view>
		
		<!-- 无数据状态 -->
		<view v-else class="no-data-container">
			<text class="no-data-text">暂无岗位详情</text>
		</view>
	</view>
</template>

<script>
	import { needDefaultImage, isStaleOssUrl } from '../../utils/imageUrl.js'
	export default {
		data() {
			return {
				name:"海天考研",
				education:"本科",
				jobtime:"全职",
				SelfList:["百强企业","凝聚力强","五险一金"],
				DataInside: null, // 改为null，避免模板渲染错误
				// 添加状态管理
				currentStatus: 0, // 0:无状态, 1:喜欢, 2:不喜欢
				loading: true, // 添加加载状态
				error: null, // 添加错误状态
				talentNeedId: null, // 存储岗位ID
				// 面试申请相关状态
				applicationStatus: null, // null:未申请, 0:已申请, 1:已同意, 2:已拒绝
				applying: false, // 申请中状态
				DEFAULT_IMAGE: '/static/defaultImage/1.png'
			}
		},

		onLoad: async function(options) { //option为object类型，会序列化上个页面传递的参数
			console.log('=== 页面加载开始 ===');
			console.log('接收到的参数:', options);
			
			this.loading = true;
			this.error = null;
			
			try {
				var arr = [];
				for (let i in options){
					arr.push(options[i])
				}

				const id = arr[0];
				console.log('岗位表序号',id)
				
				if (!id) {
					throw new Error('未接收到岗位ID参数');
				}
				
				this.talentNeedId = id;
				await this.loadJobDetail(id);
				
			} catch (error) {
				console.error('页面加载失败:', error);
				this.error = error.message || '加载失败，请重试';
			} finally {
				this.loading = false;
			}
		},
		
		methods: {
			checkImage(url) {
				if (needDefaultImage(url)
					|| url.trim() === '') {
					return this.DEFAULT_IMAGE
				}
				return url
			},
			// 加载岗位详情
			async loadJobDetail(id) {
				try {
					console.log('开始请求岗位详情，ID:', id);
					
					const [error, res] = await uni.request({
						url: 'http://localhost:10086/talentNeed/get/'+ id,
						method: 'GET',
						header: {
							'content-type': 'application/json'
						}
					});
					
					if (error) {
						console.error('网络请求错误:', error);
						throw error;
					}
					
					console.log('API响应:', res);
					console.log('响应状态码:', res.statusCode);
					console.log('响应数据:', res.data);
					
					// 检查HTTP状态码
					if (res.statusCode !== 200) {
						throw new Error(`HTTP错误: ${res.statusCode}`);
					}
					
					// 检查业务状态码
					if (res.data.code !== 0) {
						console.error('业务错误:', res.data);
						throw new Error(res.data.message || `业务错误: ${res.data.code}`);
					}
					
					// 检查数据是否存在
					if (!res.data.data) {
						console.error('响应数据为空:', res.data);
						throw new Error('岗位详情数据为空');
					}
					
					this.DataInside = res.data.data;
					// 图片兜底
					if (this.DataInside && this.DataInside.image) {
						if (isStaleOssUrl(this.DataInside.image)) {
							this.DataInside.image = this.DEFAULT_IMAGE
						}
					}
					console.log('设置后的DataInside:', this.DataInside);
					console.log('talentNeedId:', this.DataInside && this.DataInside.talentNeedId);
					
					// 获取用户当前状态（喜欢/不喜欢）
					await this.getCurrentStatus();
					
					// 检查面试申请状态
					await this.checkInterviewApplicationStatus();
				} catch (error) {
					console.error('获取岗位详情失败:', error);
					console.error('错误详情:', error.message);
					console.error('错误堆栈:', error.stack);
					throw new Error('获取岗位详情失败: ' + (error.message || '未知错误'));
				}
			},
			
			// 重试加载
			async retryLoad() {
				if (this.talentNeedId) {
					this.loading = true;
					this.error = null;
					try {
						await this.loadJobDetail(this.talentNeedId);
					} catch (error) {
						this.error = error.message;
					} finally {
						this.loading = false;
					}
				}
			},
			
			// 获取用户当前状态
			async getCurrentStatus() {
				if (!this.$store.state.userInfo.uid || !this.DataInside || !this.DataInside.talentNeedId) {
					return;
				}
				
				try {
					const [error, res] = await uni.request({
						url: `http://localhost:10086/api/behavior/status/${this.$store.state.userInfo.uid}?targetType=1&targetId=${this.DataInside.talentNeedId}`,
						method: 'GET',
						header: {
							'content-type': 'application/json'
						}
					});
					
					if (error) {
						throw error;
					}
					
					if (res.data.code === 0) {
						this.currentStatus = res.data.status || 0;
						console.log('当前状态:', this.currentStatus);
					} else {
						console.error('获取状态失败:', res.data.msg);
						this.currentStatus = 0;
					}
				} catch (error) {
					console.error('获取状态失败:', error);
					this.currentStatus = 0;
				}
			},
			
			// 喜欢岗位
			async likeJob() {
				// 检查用户是否已登录
				console.log('当前用户信息:', this.$store.state.userInfo);
				console.log('用户ID:', this.$store.state.userInfo.uid);
				console.log('登录状态:', this.$store.state.isLogin);
				console.log('DataInside:', this.DataInside);
				console.log('talentNeedId:', this.DataInside && this.DataInside.talentNeedId);
				
				if (!this.$store.state.userInfo.uid) {
					uni.showToast({
						title: '请先登录',
						icon: 'error'
					});
					return;
				}
				
				if (!this.DataInside || !this.DataInside.talentNeedId) {
					console.error('岗位数据未加载完成');
					uni.showToast({
						title: '数据未加载完成，请稍后再试',
						icon: 'error'
					});
					return;
				}
				
				try {
					// 如果当前已经是喜欢状态，则撤销喜欢
					if (this.currentStatus === 1) {
						await this.recordUserBehavior(1, this.DataInside.talentNeedId, 0);
						this.currentStatus = 0; // 撤销喜欢状态
						console.log('撤销喜欢后，currentStatus:', this.currentStatus);
						uni.showToast({
							title: '已取消喜欢',
							icon: 'success'
						});
					} else {
						// 否则设置为喜欢状态
					await this.recordUserBehavior(1, this.DataInside.talentNeedId, 1);
					this.currentStatus = 1; // 更新本地状态
						console.log('设置喜欢后，currentStatus:', this.currentStatus);
					uni.showToast({
						title: '已添加到喜欢',
						icon: 'success'
					});
					}
					
					// 通知推荐列表页面更新数据
					this.notifyRecommendationUpdate();
				} catch (error) {
					console.error('记录用户行为失败:', error);
					uni.showToast({
						title: '操作失败',
						icon: 'error'
					});
				}
			},
			
			// 不喜欢岗位
			async dislikeJob() {
				// 检查用户是否已登录
				if (!this.$store.state.userInfo.uid) {
					uni.showToast({
						title: '请先登录',
						icon: 'error'
					});
					return;
				}
				
				if (!this.DataInside || !this.DataInside.talentNeedId) {
					console.error('岗位数据未加载完成');
					uni.showToast({
						title: '数据未加载完成，请稍后再试',
						icon: 'error'
					});
					return;
				}
				
				try {
					// 如果当前已经是不喜欢状态，则撤销不喜欢
					if (this.currentStatus === 2) {
						await this.recordUserBehavior(1, this.DataInside.talentNeedId, 0);
						this.currentStatus = 0; // 撤销不喜欢状态
						console.log('撤销不喜欢后，currentStatus:', this.currentStatus);
						uni.showToast({
							title: '已取消不喜欢',
							icon: 'success'
						});
					} else {
						// 否则设置为不喜欢状态
					await this.recordUserBehavior(1, this.DataInside.talentNeedId, 2);
					this.currentStatus = 2; // 更新本地状态
						console.log('设置不喜欢后，currentStatus:', this.currentStatus);
					uni.showToast({
						title: '已添加到不喜欢',
						icon: 'success'
					});
					}
					
					// 通知推荐列表页面更新数据
					this.notifyRecommendationUpdate();
				} catch (error) {
					uni.showToast({
						title: '操作失败',
						icon: 'error'
					});
				}
			},
			
			// 记录用户行为
			async recordUserBehavior(targetType, targetId, actionType) {
				console.log('=== 开始记录用户行为 ===');
				
				// 获取用户ID
				const userId = this.$store.state.userInfo.uid;
				console.log('用户ID:', userId);
				console.log('目标类型:', targetType);
				console.log('目标ID:', targetId);
				console.log('操作类型:', actionType);
				
				// 简单验证
				if (!userId) {
					throw new Error('用户ID无效，请重新登录');
				}
				
				if (!targetId) {
					throw new Error('目标ID无效');
				}
				
				// 构建URL
				const url = `http://localhost:10086/api/behavior/like?userId=${userId}&targetType=${targetType}&targetId=${targetId}&actionType=${actionType}`;
				console.log('请求URL:', url);
				console.log('开始发送请求...');
				
				// 关键调试点
				console.log('准备调用 uni.request...');
				
				try {
					const [error, res] = await uni.request({
						url: url,
						method: 'POST',
						header: {
							'content-type': 'application/json'
						}
					});
					
					if (error) {
						throw error;
					}
					
					console.log('API响应:', res);
					console.log('请求成功完成');
					return res;
				} catch (error) {
					console.error('API请求失败:', error);
					console.error('错误详情:', error.message);
					throw error;
				}
			},
			
			// 通知推荐列表页面更新数据
			notifyRecommendationUpdate() {
				// 使用uni-app的事件总线通知其他页面
				uni.$emit('recommendation-updated', {
					userId: this.$store.state.userInfo.uid,
					targetType: 1, // 岗位类型
					timestamp: Date.now()
				});
			},
			
			// 检查面试申请状态
			async checkInterviewApplicationStatus() {
				if (!this.$store.state.userInfo.uid || !this.DataInside?.talentNeedId) {
					return;
				}
				
				try {
					const [error, res] = await uni.request({
						url: 'http://localhost:10086/api/interview/status',
						method: 'GET',
						data: {
							userId: this.$store.state.userInfo.uid,
							talentNeedId: this.DataInside.talentNeedId
						},
						header: {
							'content-type': 'application/json'
						}
					});
					
					if (error) {
						throw error;
					}
					
					if (res.data.code === 0) {
						this.applicationStatus = res.data.status;
						console.log('当前申请状态:', this.applicationStatus);
					} else {
						console.error('获取申请状态失败:', res.data.msg);
						this.applicationStatus = null;
					}
				} catch (error) {
					console.error('检查申请状态失败:', error);
					this.applicationStatus = null;
				}
			},
			
			// 申请面试
			async applyForInterview() {
				// 检查用户是否已登录
				if (!this.$store.state.userInfo.uid) {
					uni.showToast({
						title: '请先登录',
						icon: 'error'
					});
					return;
				}
				
				if (!this.DataInside || !this.DataInside.talentNeedId) {
					uni.showToast({
						title: '岗位信息未加载完成，请稍后再试',
						icon: 'error'
					});
					return;
				}
				
				// 防止重复点击
				if (this.applying) {
					return;
				}
				
				this.applying = true;
				
				try {
					const [error, res] = await uni.request({
						url: 'http://localhost:10086/api/interview/apply',
						method: 'POST',
						data: {
							userId: this.$store.state.userInfo.uid,
							talentNeedId: this.DataInside.talentNeedId
						},
						header: {
							'content-type': 'application/x-www-form-urlencoded'
						}
					});
					
					if (error) {
						throw error;
					}
					
					if (res.data.code === 0) {
						uni.showToast({
							title: '申请提交成功',
							icon: 'success'
						});
						
						// 更新申请状态
						this.applicationStatus = 0; // 已申请，等待处理
						
					} else {
						throw new Error(res.data.msg || '申请失败');
					}
				} catch (error) {
					console.error('申请面试失败:', error);
					uni.showToast({
						title: error.message || '申请失败，请重试',
						icon: 'error'
					});
				} finally {
					this.applying = false;
				}
			}
		}
	}
</script>

<style scoped lang="scss">
	.mainclass {
		background-color: #F2F2F2;
		height: 100%;
		padding-bottom: 120px; // 增加底部间距，为按钮留出空间
	}

	// 加载状态样式
	.loading-container {
		display: flex;
		justify-content: center;
		align-items: center;
		height: 100vh;
	}
	
	.loading-text {
		font-size: 32rpx;
		color: #666;
	}

	// 错误状态样式
	.error-container {
		display: flex;
		flex-direction: column;
		justify-content: center;
		align-items: center;
		height: 100vh;
		padding: 40rpx;
	}
	
	.error-text {
		font-size: 28rpx;
		color: #f44336;
		margin-bottom: 40rpx;
		text-align: center;
	}
	
	.retry-btn {
		padding: 20rpx 40rpx;
		background-color: #007aff;
		color: white;
		border: none;
		border-radius: 8rpx;
		font-size: 28rpx;
	}

	// 无数据状态样式
	.no-data-container {
		display: flex;
		justify-content: center;
		align-items: center;
		height: 100vh;
	}
	
	.no-data-text {
		font-size: 32rpx;
		color: #999;
	}

	.u-row {
		margin-top: 20rpx;
		background: #FFFFFF;
		font-size: 18px;
		padding: 20px;
		color: #000000;
		letter-spacing: 2px;
	}

	.company-name {
		font-size: 24rpx;
		font-weight: bold;
		color: #333;
	}

	.text {
		font-size: 14px;
		color: #949494;
		line-height: 2;
	}

	.title {
		font-size: 28rpx;
		position: relative;
		line-height: 1;
		padding-left: 20rpx;
		font-weight: 900;
		margin-bottom: 20px;
		color: $uni-color-title;

		&:before {
			width: 4px;
			height: 16px;
			border-radius: 100rpx;
			background-color: $uni-color-primary;
			content: '';
			position: absolute;
			left: 1rpx;
			top: -1px;
		}
	}
	
	// 添加操作按钮样式
	.action-footer {
		position: fixed;
		bottom: 0;
		left: 0;
		right: 0;
		background: #fff;
		border-top: 1px solid #e6e6e6;
		padding: 20rpx;
		z-index: 999;
	}

	.apply-section {
		margin-bottom: 20rpx;
		text-align: center;
	}

	.action-buttons {
		display: flex;
		justify-content: space-around;
	}

	.action-btn {
		flex: 1;
		margin: 0 20rpx;
		padding: 30rpx 0;
		border-radius: 12rpx;
		font-size: 32rpx;
		border: none;
	}

	.like-btn {
		background-color: #cccccc;
		color: #666666;
	}
	
	.like-btn.active {
		background-color: #4CAF50;
		color: white;
		box-shadow: 0 0 10px rgba(76, 175, 80, 0.5);
	}
	
	.like-btn.inactive {
		background-color: #cccccc;
		color: #666666;
	}

	.dislike-btn {
		background-color: #cccccc;
		color: #666666;
	}
	
	.dislike-btn.active {
		background-color: #f44336;
		color: white;
		box-shadow: 0 0 10px rgba(244, 67, 54, 0.5);
	}
	
	.dislike-btn.inactive {
		background-color: #cccccc;
		color: #666666;
	}
</style>

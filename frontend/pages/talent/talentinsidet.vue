<template>
	<view class="mainclass">

    <u-grid :col="1">
			<u-grid-item>
				<u-image width="150px" height="150px" :src="checkImage(DataInside.image)"></u-image>
			</u-grid-item>
		</u-grid>

		<u-row>
			{{DataInside.name}}
		</u-row>
		<u-row>
			<u-col span="12">
				<view class="title">
					求职意向
				</view>
				<u-col span="12">
					<view class="text">学历：
						<text class="u-main-color">
							{{degreelist[DataInside.degree]}}
						</text>
					</view>
				</u-col>
				<u-col span="12">
					<view class="text">期望职业：
						<text class="u-main-color">
							{{DataInside.profession}}
						</text>
					</view>
				</u-col>
				<u-col span="12">
					<view class="text">期望薪资：
						<text class="u-main-color">
							{{DataInside.salaryMin && DataInside.salaryMax ? DataInside.salaryMin + 'k-' + DataInside.salaryMax + 'k' : '面议'}}
						</text>
					</view>
				</u-col>
        <u-col span="12">
        	<view class="text">毕业院校：
        		<text class="u-main-color">
        			{{DataInside.school}}
        		</text>
        	</view>
        </u-col>
			</u-col>
		</u-row>
		<u-row>
			<u-col span="12">
				<view class="title">
					联系方式
				</view>
				<u-col span="12">
					<view class="text">联系电话：
						<text class="u-main-color">
							{{DataInside.contactEntity ? DataInside.contactEntity.phone : '暂无'}}
						</text>
					</view>
				</u-col>
				<u-col span="12">
					<view class="text">邮箱：
						<text class="u-main-color">
							{{DataInside.contactEntity ? DataInside.contactEntity.email : '暂无'}}
						</text>
					</view>
				</u-col>
			</u-col>
		</u-row>
    <u-row>
      <view class="title">
      	个人经历
      </view>
    	<u-col span="12">
    		<view class="text">专业技能：
    			<text class="u-main-color">
    				{{DataInside.skill}}
    			</text>
    		</view>
    	</u-col>
      <u-col span="12">
      	<view class="text">性格品质：
      		<text class="u-main-color">
      			{{DataInside.quality}}
      		</text>
      	</view>
      </u-col>
    </u-row>
		<que-button @clicked="clicked()"></que-button>
		
		<!-- 添加喜欢/不喜欢按钮 -->
		<view class="action-footer">
			<view class="action-buttons">
				<button @click="likeResume" :class="['action-btn', 'like-btn', currentStatus === 1 ? 'liked' : '']">
					👍 {{ currentStatus === 1 ? '已喜欢' : '喜欢' }}
				</button>
				<button @click="dislikeResume" :class="['action-btn', 'dislike-btn', currentStatus === 2 ? 'disliked' : '']">
					👎 {{ currentStatus === 2 ? '已不喜欢' : '不喜欢' }}
				</button>
			</view>
		</view>
	</view>
</template>

<script>
	import { needDefaultImage, isStaleOssUrl } from '../../utils/imageUrl.js'
	export default {
		data() {
			return {
				name:"李四",
				age:"20",
				education:"本科",
				jobtime:"全职",
				DataInside:'',
				State:['已离职','未离职','正在办理离职'],
				JobState:['全职','兼职','实习'],
				degreelist: ['','专科','本科','硕士','博士'],
				// 添加状态管理
				currentStatus: 0, // 0:无状态, 1:喜欢, 2:不喜欢
				DEFAULT_IMAGE: '/static/defaultImage/1.png'
			}
		},

		onLoad: async function(options) { //option为object类型，会序列化上个页面传递的参数
			console.log('页面参数:', options);
			
			// 正确获取talentSupplyId参数
			const talentSupplyId = options.talentSupplyId;
			console.log('获取简历详情，ID:', talentSupplyId);
			
			if (!talentSupplyId) {
				console.error('缺少talentSupplyId参数');
				uni.showToast({
					title: '参数错误',
					icon: 'error'
				});
				return;
			}
			
			try {
				const [error, res] = await uni.request({
					url: 'http://localhost:10086/talentSupply/getById/'+ talentSupplyId,
					method: 'GET',
					header: {
						'content-type': 'application/x-www-form-urlencoded'
					}
				});
				
				if (error) {
					console.error('获取简历详情失败:', error);
					uni.showToast({
						title: '获取数据失败',
						icon: 'error'
					});
					return;
				}
				
				console.log('简历详情响应:', res.data);
				
				if (res.data && res.data.data) {
					// 使用Vue.set确保响应式数据正确设置
					const resumeData = res.data.data;
					console.log('原始简历数据:', resumeData);
					
					// 确保talentSupplyId字段存在
					if (!resumeData.talentSupplyId) {
						resumeData.talentSupplyId = talentSupplyId;
					}
					
					// 使用Vue.set确保响应式
					this.$set(this, 'DataInside', resumeData);
					// 图片兜底
					if (resumeData.image && isStaleOssUrl(resumeData.image)) {
						resumeData.image = this.DEFAULT_IMAGE
					}
					
					console.log('设置简历数据:', this.DataInside);
					console.log('简历ID:', this.DataInside.talentSupplyId);
					
					// 确保数据设置完成后再获取用户状态
					await this.$nextTick();
					
					// 延迟获取用户状态，确保数据完全加载
					setTimeout(() => {
						this.getCurrentStatus();
					}, 200);
				} else {
					console.error('响应数据格式错误:', res.data);
					uni.showToast({
						title: '数据格式错误',
						icon: 'error'
					});
				}
			} catch (error) {
				console.error('请求异常:', error);
				uni.showToast({
					title: '网络请求失败',
					icon: 'error'
				});
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
			// 获取用户当前状态
			async getCurrentStatus() {
				console.log('开始获取用户当前状态');
				console.log('用户信息:', this.$store.state.userInfo);
				console.log('用户ID:', this.$store.state.userInfo.uid);
				console.log('简历数据:', this.DataInside);
				
				// 检查用户是否已登录
				if (!this.$store.state.userInfo.uid) {
					console.log('用户未登录，跳过状态获取');
					return;
				}
				
				// 检查简历数据是否存在
				if (!this.DataInside) {
					console.log('简历数据未加载，跳过状态获取');
					return;
				}
				
				// 获取简历ID，只使用talentSupplyId
				const resumeId = this.DataInside.talentSupplyId;
				console.log('简历ID:', resumeId);
				
				if (!resumeId) {
					console.log('简历ID无效，跳过状态获取');
					return;
				}
				
				try {
					const [error, res] = await uni.request({
						url: `http://localhost:10086/api/behavior/status/${this.$store.state.userInfo.uid}?targetType=2&targetId=${resumeId}`,
						method: 'GET',
						header: {
							'content-type': 'application/json'
						}
					});
					
					if (error) {
						throw error;
					}
					
					console.log('获取状态响应:', res.data);
					
					// 修复响应数据格式解析
					this.currentStatus = res.data.status || 0;
					console.log('当前状态:', this.currentStatus);
				} catch (error) {
					console.error('获取状态失败:', error);
					this.currentStatus = 0;
				}
			},
			
			// 喜欢简历
			async likeResume() {
				console.log('开始喜欢简历操作');
				console.log('当前状态:', this.currentStatus);
				
				// 检查用户是否已登录
				if (!this.$store.state.userInfo.uid) {
					uni.showToast({
						title: '请先登录',
						icon: 'error'
					});
					return;
				}
				
				// 获取简历ID
				const resumeId = this.DataInside.talentSupplyId;
				console.log('喜欢操作 - 简历ID:', resumeId);
				
				if (!resumeId) {
					uni.showToast({
						title: '简历数据无效',
						icon: 'error'
					});
					return;
				}
				
				try {
					// 如果当前已经是喜欢状态，则撤销喜欢
					if (this.currentStatus === 1) {
						console.log('当前是喜欢状态，执行撤销操作');
						await this.recordUserBehavior(2, resumeId, 0);
						this.currentStatus = 0; // 撤销喜欢状态
						uni.showToast({
							title: '已取消喜欢',
							icon: 'success'
						});
					} else {
						console.log('当前不是喜欢状态，执行添加喜欢操作');
						// 如果当前是不喜欢状态，先取消不喜欢
						if (this.currentStatus === 2) {
							console.log('当前是不喜欢状态，先取消不喜欢');
							await this.recordUserBehavior(2, resumeId, 0);
						}
						// 然后设置为喜欢状态
						console.log('设置为喜欢状态');
						await this.recordUserBehavior(2, resumeId, 1);
						this.currentStatus = 1; // 更新本地状态
						uni.showToast({
							title: '已添加到喜欢',
							icon: 'success'
						});
					}
					
					// 重新获取用户状态，确保UI同步
					await this.getCurrentStatus();
					
					// 通知推荐列表页面更新数据
					this.notifyRecommendationUpdate();
				} catch (error) {
					console.error('喜欢简历操作失败:', error);
					console.error('错误详情:', error.message);
					uni.showToast({
						title: '操作失败: ' + (error.message || '未知错误'),
						icon: 'error',
						duration: 3000
					});
				}
			},
			
			// 不喜欢简历
			async dislikeResume() {
				console.log('开始不喜欢简历操作');
				console.log('当前状态:', this.currentStatus);
				
				// 检查用户是否已登录
				if (!this.$store.state.userInfo.uid) {
					uni.showToast({
						title: '请先登录',
						icon: 'error'
					});
					return;
				}
				
				// 获取简历ID
				const resumeId = this.DataInside.talentSupplyId;
				console.log('不喜欢操作 - 简历ID:', resumeId);
				
				if (!resumeId) {
					uni.showToast({
						title: '简历数据无效',
						icon: 'error'
					});
					return;
				}
				
				try {
					// 如果当前已经是不喜欢状态，则撤销不喜欢
					if (this.currentStatus === 2) {
						console.log('当前是不喜欢状态，执行撤销操作');
						await this.recordUserBehavior(2, resumeId, 0);
						this.currentStatus = 0; // 撤销不喜欢状态
						uni.showToast({
							title: '已取消不喜欢',
							icon: 'success'
						});
					} else {
						console.log('当前不是不喜欢状态，执行添加不喜欢操作');
						// 如果当前是喜欢状态，先取消喜欢
						if (this.currentStatus === 1) {
							console.log('当前是喜欢状态，先取消喜欢');
							await this.recordUserBehavior(2, resumeId, 0);
						}
						// 然后设置为不喜欢状态
						console.log('设置为不喜欢状态');
						await this.recordUserBehavior(2, resumeId, 2);
						this.currentStatus = 2; // 更新本地状态
						uni.showToast({
							title: '已添加到不喜欢',
							icon: 'success'
						});
					}
					
					// 重新获取用户状态，确保UI同步
					await this.getCurrentStatus();
					
					// 通知推荐列表页面更新数据
					this.notifyRecommendationUpdate();
				} catch (error) {
					console.error('不喜欢简历操作失败:', error);
					console.error('错误详情:', error.message);
					uni.showToast({
						title: '操作失败: ' + (error.message || '未知错误'),
						icon: 'error',
						duration: 3000
					});
				}
			},
			
			// 记录用户行为
			async recordUserBehavior(targetType, targetId, actionType) {
				console.log('开始记录用户行为');
				console.log('参数 - targetType:', targetType, '类型:', typeof targetType);
				console.log('参数 - targetId:', targetId, '类型:', typeof targetId);
				console.log('参数 - actionType:', actionType, '类型:', typeof actionType);
				
				// 严格检查所有参数
				const userId = this.$store.state.userInfo.uid;
				if (!userId || userId === 'undefined' || userId === undefined) {
					throw new Error('用户ID无效，请重新登录');
				}
				
				// 获取简历ID，优先使用传入的targetId，如果没有则从DataInside获取
				let resumeId = targetId;
				if (!resumeId) {
					console.log('targetId为空，从DataInside获取简历ID');
					resumeId = this.DataInside.talentSupplyId;
				}
				
				console.log('最终使用的简历ID:', resumeId);
				
				if (!resumeId || resumeId === 'undefined' || resumeId === undefined) {
					throw new Error('简历ID无效');
				}
				
				// 确保参数类型正确
				const finalTargetType = parseInt(targetType);
				const finalTargetId = parseInt(resumeId);
				const finalActionType = parseInt(actionType);
				
				if (isNaN(finalTargetType) || finalTargetType === undefined || finalTargetType === null) {
					throw new Error('目标类型无效');
				}
				
				if (isNaN(finalTargetId) || finalTargetId === undefined || finalTargetId === null) {
					throw new Error('目标ID无效');
				}
				
				// 修复：actionType可以为0（撤销操作），所以不能用!actionType判断
				if (isNaN(finalActionType) || finalActionType === undefined || finalActionType === null) {
					throw new Error('操作类型无效');
				}
				
				// 构建URL
				const url = `http://localhost:10086/api/behavior/like?userId=${userId}&targetType=${finalTargetType}&targetId=${finalTargetId}&actionType=${finalActionType}`;
				console.log('请求URL:', url);
				
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
					
					// 检查响应状态码
					if (res.data.code !== 0) {
						throw new Error(res.data.msg || '操作失败');
					}
					
					console.log('用户行为记录成功:', res.data);
					return res;
				} catch (error) {
					console.error('API请求失败:', error);
					throw error;
				}
			},
			
			// 通知推荐列表页面更新数据
			notifyRecommendationUpdate() {
				// 使用uni-app的事件总线通知其他页面
				uni.$emit('recommendation-updated', {
					userId: this.$store.state.userInfo.uid,
					targetType: 2, // 简历类型
					timestamp: Date.now()
				});
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

	.u-row {
		margin-top: 20rpx;
		background: #FFFFFF;
		font-size: 18px;
		padding: 20px;
		color: #000000;
		letter-spacing: 2px;
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
		transition: all 0.3s ease;
	}
	
	.like-btn.liked {
		background-color: #4CAF50;
		color: white;
		box-shadow: 0 0 10px rgba(76, 175, 80, 0.5);
	}

	.dislike-btn {
		background-color: #cccccc;
		color: #666666;
		transition: all 0.3s ease;
	}
	
	.dislike-btn.disliked {
		background-color: #f44336;
		color: white;
		box-shadow: 0 0 10px rgba(244, 67, 54, 0.5);
	}
</style>

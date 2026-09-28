<template>
  <view class="content">
    
    <!-- 滑动指示器 -->
    <view class="tab-indicator">
      <view class="indicator-line"></view>
      <view 
        class="indicator-active" 
        :style="{ left: swiperCurrent * (100/3) + '%' }"
      ></view>
    </view>
    
    <!-- 标签栏 -->
    <view class="tabs">
      <view 
        v-for="(tab, index) in tabs" 
        :key="index"
        class="tab-item"
        :class="{ active: swiperCurrent === index }"
        @click="switchTab(index)"
      >
        {{ tab.name }}
        <view class="badge" v-if="tab.count > 0">{{ tab.count }}</view>
      </view>
    </view>
    
    <!-- 滑动内容区域 -->
    <swiper 
      class="swiper-container" 
      :current="swiperCurrent"
      @change="onSwiperChange"
      @transition="onSwiperTransition"
      @animationfinish="onSwiperAnimationFinish"
    >
      <!-- 未办理列表 -->
      <swiper-item class="swiper-item">
        <scroll-view 
          scroll-y 
          class="scroll-view"

          :refresher-enabled="true"
          :refresher-triggered="refreshing"
          @refresherrefresh="onRefresh"
        >
          <view class="section-title">未办理 ({{ pendingList.length }})</view>
          
          <!-- 空状态 -->
          <view v-if="pendingList.length === 0 && !loading" class="empty-state">
            <image src="/static/font/empty.png" class="empty-icon"></image>
            <text class="empty-text">暂无待处理的申请</text>
          </view>
          
          <!-- 申请列表 -->
          <view 
            v-for="item in pendingList" 
            :key="item.applicationId" 
            class="application-item"
            @click="viewResumeDetail(item)"
          >
            <view class="item-header">
              <text class="applicant-name">{{ item.realName || '申请人' }}</text>
              <text class="status-badge status-pending">待处理</text>
            </view>
            
            <view class="item-content">
              <text class="position-name">申请职位：{{ item.positionName || '岗位名称' }}</text>
              <text class="phone">联系电话：{{ item.phone || '未提供' }}</text>
              <text class="experience">工作经验：{{ item.workExperience || '未填写' }}</text>
            </view>
            
            <view class="item-footer">
              <text class="apply-time">申请时间：{{ formatTime(item.applyTime) }}</text>
              
              <!-- 快速操作按钮 -->
              <view class="quick-actions">
                <button 
                  @click.stop="quickProcess(item.applicationId, 1)"
                  class="quick-btn accept-btn"
                >
                  同意
                </button>
                <button 
                  @click.stop="quickProcess(item.applicationId, 2)"
                  class="quick-btn reject-btn"
                >
                  拒绝
                </button>
              </view>
            </view>
          </view>
          

        </scroll-view>
      </swiper-item>
      
      <!-- 已同意列表 -->
      <swiper-item class="swiper-item">
        <scroll-view 
          scroll-y 
          class="scroll-view"

          :refresher-enabled="true"
          :refresher-triggered="refreshing"
          @refresherrefresh="onRefresh"
        >
          <view class="section-title">已同意 ({{ acceptedList.length }})</view>
          
          <!-- 空状态 -->
          <view v-if="acceptedList.length === 0 && !loading" class="empty-state">
            <image src="/static/font/empty.png" class="empty-icon"></image>
            <text class="empty-text">暂无已同意的申请</text>
          </view>
          
          <!-- 申请列表 -->
          <view 
            v-for="item in acceptedList" 
            :key="item.applicationId" 
            class="application-item"
            @click="viewResumeDetail(item)"
          >
            <view class="item-header">
              <text class="applicant-name">{{ item.realName || '申请人' }}</text>
              <text class="status-badge status-accepted">已同意</text>
            </view>
            
            <view class="item-content">
              <text class="position-name">申请职位：{{ item.positionName || '岗位名称' }}</text>
              <text class="phone">联系电话：{{ item.phone || '未提供' }}</text>
              <text class="experience">工作经验：{{ item.workExperience || '未填写' }}</text>
            </view>
            
            <view class="item-footer">
              <text class="apply-time">申请时间：{{ formatTime(item.applyTime) }}</text>
              <text class="process-time">同意时间：{{ formatTime(item.processTime) }}</text>
            </view>
          </view>
          

        </scroll-view>
      </swiper-item>
      
      <!-- 已拒绝列表 -->
      <swiper-item class="swiper-item">
        <scroll-view 
          scroll-y 
          class="scroll-view"

          :refresher-enabled="true"
          :refresher-triggered="refreshing"
          @refresherrefresh="onRefresh"
        >
          <view class="section-title">已拒绝 ({{ rejectedList.length }})</view>
          
          <!-- 空状态 -->
          <view v-if="rejectedList.length === 0 && !loading" class="empty-state">
            <image src="/static/font/empty.png" class="empty-icon"></image>
            <text class="empty-text">暂无已拒绝的申请</text>
          </view>
          
          <!-- 申请列表 -->
          <view 
            v-for="item in rejectedList" 
            :key="item.applicationId" 
            class="application-item"
            @click="viewResumeDetail(item)"
          >
            <view class="item-header">
              <text class="applicant-name">{{ item.realName || '申请人' }}</text>
              <text class="status-badge status-rejected">已拒绝</text>
            </view>
            
            <view class="item-content">
              <text class="position-name">申请职位：{{ item.positionName || '岗位名称' }}</text>
              <text class="phone">联系电话：{{ item.phone || '未提供' }}</text>
              <text class="experience">工作经验：{{ item.workExperience || '未填写' }}</text>
            </view>
            
            <view class="item-footer">
              <text class="apply-time">申请时间：{{ formatTime(item.applyTime) }}</text>
              <text class="process-time">拒绝时间：{{ formatTime(item.processTime) }}</text>
            </view>
          </view>
          

        </scroll-view>
      </swiper-item>
    </swiper>
    
    <!-- 加载状态 -->
    <view v-if="loading" class="loading-overlay">
      <text class="loading-text">加载中...</text>
    </view>
    
    <!-- 底部导航栏 -->
    <u-tabbar :list="tabbar" active-color="#1296db" height="110"></u-tabbar>
  </view>
</template>

<script>
import global from '../../store/global.js'

export default {
  data() {
    return {
      swiperCurrent: 0,
      refreshing: false,
      loading: false,
      
      tabs: [
        { name: '未办理', count: 0 },
        { name: '已同意', count: 0 },
        { name: '已拒绝', count: 0 }
      ],
      
      // 数据列表
      pendingList: [],
      acceptedList: [],
      rejectedList: [],
      
      // 分页状态

      
      tabbar: [],
      
      // 企业ID（从用户信息获取）
      companyId: null
    }
  },
  
  onLoad() {
    this.tabbar = global.tabbar;
    this.initCompanyInfo();
  },
  
  onShow() {
    // 页面显示时刷新数据，但避免重复加载
    if (this.companyId && !this.loading) {
      this.loadAllApplications();
    }
  },
  
  methods: {
    // 初始化企业信息
    initCompanyInfo() {
      // 假设企业用户的businessId存储在store中，或者通过API获取
      // 这里需要根据实际的用户数据结构调整
      if (this.$store.state.userInfo && this.$store.state.userInfo.businessId) {
        this.companyId = this.$store.state.userInfo.businessId;
        this.loadAllApplications();
      } else {
        // 如果没有企业ID，可能需要先获取用户的企业信息
        this.getUserBusinessInfo();
      }
    },
    
    // 获取用户的企业信息
    async getUserBusinessInfo() {
      if (!this.$store.state.userInfo.uid) {
        uni.showToast({
          title: '请先登录',
          icon: 'error'
        });
        return;
      }
      
      try {
        // 先检查企业审核状态
        const [error, res] = await uni.request({
          url: `http://localhost:10086/businessInfo/checkStatus/${this.$store.state.userInfo.uid}`,
          method: 'GET',
          header: {
            'content-type': 'application/json'
          }
        });
        
        if (error) {
          throw error;
        }
        
        console.log('检查企业状态响应:', res.data);
        console.log('当前用户ID:', this.$store.state.userInfo.uid);
        console.log('用户类型:', this.$store.state.userInfo.type);
        
        if (res.data.code === 0 && res.data.data) {
          const businessInfo = res.data.data;
          console.log('企业信息:', businessInfo);
          console.log('企业状态:', businessInfo.status, '(' + businessInfo.statusMsg + ')');
          
          // 根据企业状态处理
          switch (businessInfo.status) {
            case 0: // 等待审核
              uni.showModal({
                title: '提示',
                content: '您的企业信息正在等待审核，审核通过后即可使用面试管理功能',
                showCancel: false,
                confirmText: '我知道了',
                success: () => {
                  uni.navigateBack();
                }
              });
              return;
              
            case 1: // 正在审核
              uni.showModal({
                title: '提示',
                content: '您的企业信息正在审核中，审核通过后即可使用面试管理功能',
                showCancel: false,
                confirmText: '我知道了',
                success: () => {
                  uni.navigateBack();
                }
              });
              return;
              
            case 2: // 审核通过
              this.companyId = businessInfo.businessId;
              console.log('获取到企业ID:', this.companyId);
              this.loadAllApplications();
              break;
              
            case 3: // 审核失败
              uni.showModal({
                title: '提示', 
                content: '您的企业认证审核未通过，请重新提交企业资料',
                showCancel: true,
                confirmText: '重新认证',
                cancelText: '返回',
                success: (modalRes) => {
                  if (modalRes.confirm) {
                    uni.navigateTo({
                      url: '/pages/auth/business/business'
                    });
                  } else {
                    uni.navigateBack();
                  }
                }
              });
              return;
              
            default:
              uni.showToast({
                title: '企业状态异常，请联系客服',
                icon: 'error'
              });
              setTimeout(() => {
                uni.navigateBack();
              }, 1500);
              return;
          }
        } else {
          console.log('检查企业状态失败 - 响应码:', res.data.code);
          console.log('错误信息:', res.data.msg);
          // 检查用户类型，如果是企业用户但没有企业信息，则提示完善资料
          if (this.$store.state.userInfo.type === 1) {
            uni.showModal({
              title: '提示',
              content: '您还没有完善企业资料，请先完善企业信息后再使用面试管理功能',
              showCancel: true,
              confirmText: '去完善',
              cancelText: '返回',
              success: (modalRes) => {
                if (modalRes.confirm) {
                  // 跳转到企业认证页面
                  uni.navigateTo({
                    url: '/pages/auth/business/business'
                  });
                } else {
                  uni.navigateBack();
                }
              }
            });
          } else {
            uni.showToast({
              title: '此功能仅企业用户可用',
              icon: 'error'
            });
            setTimeout(() => {
              uni.navigateBack();
            }, 1500);
          }
        }
        
      } catch (error) {
        console.error('获取企业信息失败:', error);
        uni.showToast({
          title: '网络连接失败，请重试',
          icon: 'error'
        });
      }
    },
    
    // 切换标签
    switchTab(index) {
      this.swiperCurrent = index;
    },
    
    // 滑动变化事件
    onSwiperChange(e) {
      this.swiperCurrent = e.detail.current;
    },
    
    onSwiperTransition(e) {
      // 滑动过程中的事件
    },
    
    onSwiperAnimationFinish(e) {
      this.swiperCurrent = e.detail.current;
    },
    
    // 下拉刷新
    async onRefresh() {
      this.refreshing = true;
      await this.loadAllApplications();
      this.refreshing = false;
    },
    
    // 加载所有申请数据
    async loadAllApplications() {
      if (!this.companyId) {
        return;
      }
      
      this.loading = true;
      
      try {
        // 并行加载三种状态的数据
        await Promise.all([
          this.loadApplicationsByStatus(0), // 未办理
          this.loadApplicationsByStatus(1), // 已同意
          this.loadApplicationsByStatus(2)  // 已拒绝
        ]);
        
        // 更新标签计数
        this.updateTabCounts();
        
      } catch (error) {
        console.error('加载申请列表失败:', error);
        uni.showToast({
          title: '加载失败，请重试',
          icon: 'error'
        });
      } finally {
        this.loading = false;
      }
    },
    
    // 根据状态加载申请列表
    async loadApplicationsByStatus(status) {
      try {
        const [error, res] = await uni.request({
          url: `http://localhost:10086/api/interview/company/${this.companyId}`,
          method: 'GET',
          data: { status },
          header: {
            'content-type': 'application/json'
          }
        });
        
        if (error) {
          throw error;
        }
        
        if (res.data.code === 0) {
          const data = res.data.data || [];
          console.log(`企业ID:${this.companyId}, 状态${status}的原始数据:`, data);
          
          // 去重处理：根据applicationId去重
          const uniqueData = data.filter((item, index, self) => 
            index === self.findIndex(t => t.applicationId === item.applicationId)
          );
          
          if (data.length !== uniqueData.length) {
            console.warn(`状态${status}的数据存在重复，原始${data.length}条，去重后${uniqueData.length}条`);
          }
          
          switch (status) {
            case 0:
              this.pendingList = uniqueData;
              break;
            case 1:
              this.acceptedList = uniqueData;
              break;
            case 2:
              this.rejectedList = uniqueData;
              break;
          }
        } else {
          throw new Error(res.data.message || '获取数据失败');
        }
        
      } catch (error) {
        console.error(`加载状态${status}的申请失败:`, error);
        throw error;
      }
    },
    

    // 更新标签计数
    updateTabCounts() {
      this.tabs[0].count = this.pendingList.length;
      this.tabs[1].count = this.acceptedList.length;
      this.tabs[2].count = this.rejectedList.length;
    },
    
    // 查看简历详情
    viewResumeDetail(item) {
      console.log('点击查看简历详情:', item);
      console.log('申请ID:', item.applicationId);
      console.log('用户ID:', item.userId);
      
      if (!item.applicationId || !item.userId) {
        uni.showToast({
          title: '申请信息不完整',
          icon: 'error'
        });
        return;
      }
      
      // 兼容不同字段名，尽可能提取出 talentSupplyId 与 talentNeedId
      const talentSupplyId = item.talentSupplyId || item.resumeId || item.talentsupplyId || item.talent_supply_id || item.talentId || null;
      const talentNeedId = item.talentNeedId || item.positionId || item.talent_need_id || null;

      const queryParts = [
        `applicationId=${item.applicationId}`,
        `userId=${item.userId}`,
        talentSupplyId ? `talentSupplyId=${talentSupplyId}` : '',
        talentNeedId ? `talentNeedId=${talentNeedId}` : ''
      ].filter(Boolean);

      uni.navigateTo({
        url: `/pages/talent/resume_detail_for_company?${queryParts.join('&')}`,
        success: (res) => {
          // 通过 eventChannel 预先把当前卡片数据传递给详情页，避免详情页首次渲染无数据
          try {
            res.eventChannel.emit('resume-card-data', {
              // 将申请卡片上的关键信息原样透传
              applicationData: {
                applicationId: item.applicationId,
                userId: item.userId,
                talentNeedId: talentNeedId || item.talentNeedId,
                positionName: item.positionName,
                applyTime: item.applyTime,
                processTime: item.processTime,
                status: typeof item.status === 'number' ? item.status : 0
              },
              // 用作页面兜底展示的简历基本信息（字段名与详情页期望保持一致）
              resumeData: {
                realName: item.realName,
                phone: item.phone,
                email: item.email,
                location: item.location,
                workExperience: item.workExperience,
                professionalSkills: item.professionalSkills,
                educationalBackground: item.educationalBackground,
                avatar: item.avatar
              },
              // 直接透传简历与岗位ID，详情页优先使用
              talentSupplyId,
              talentNeedId
            });
          } catch (err) {
            console.warn('透传卡片数据到详情页失败:', err);
          }
        }
      });
    },
    
    // 快速处理申请
    async quickProcess(applicationId, status) {
      const actionText = status === 1 ? '同意' : '拒绝';
      
      // 二次确认
      const confirmed = await this.showConfirmDialog(`确定要${actionText}此申请吗？`);
      if (!confirmed) return;
      
      try {
        const [error, res] = await uni.request({
          url: 'http://localhost:10086/api/interview/process',
          method: 'POST',
          data: {
            applicationId: applicationId,
            status: status,
            processUserId: this.$store.state.userInfo.uid,
            remarks: ''
          },
          // 后端 @RequestParam 需要表单或查询参数，不能用 JSON
          header: {
            'content-type': 'application/x-www-form-urlencoded'
          }
        });
        
        if (error) {
          throw error;
        }
        
        if (res.data.code === 0) {
          uni.showToast({
            title: `${actionText}成功`,
            icon: 'success'
          });
          
          // 刷新数据
          await this.loadAllApplications();
        } else {
          throw new Error(res.data.message || `${actionText}失败`);
        }
      } catch (error) {
        console.error('处理申请失败:', error);
        uni.showToast({
          title: `${actionText}失败，请重试`,
          icon: 'error'
        });
      }
    },
    
    // 显示确认对话框
    showConfirmDialog(message) {
      return new Promise((resolve) => {
        uni.showModal({
          title: '确认操作',
          content: message,
          showCancel: true,
          confirmText: '确定',
          cancelText: '取消',
          success: (res) => {
            resolve(res.confirm);
          },
          fail: () => {
            resolve(false);
          }
        });
      });
    },
    
    // 格式化时间
    formatTime(timeStr) {
      if (!timeStr) return '--';
      
      try {
        const date = new Date(timeStr);
        const year = date.getFullYear();
        const month = String(date.getMonth() + 1).padStart(2, '0');
        const day = String(date.getDate()).padStart(2, '0');
        const hours = String(date.getHours()).padStart(2, '0');
        const minutes = String(date.getMinutes()).padStart(2, '0');
        
        return `${year}-${month}-${day} ${hours}:${minutes}`;
      } catch (error) {
        return timeStr;
      }
    }
  }
}
</script>



<style lang="scss" scoped>
.content {
  height: 100vh;
  background-color: #f5f5f5;
  display: flex;
  flex-direction: column;
}



.tab-indicator {
  position: relative;
  height: 6rpx;
  background: #f0f0f0;
  
  .indicator-line {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    height: 100%;
    background: #f0f0f0;
  }
  
  .indicator-active {
    position: absolute;
    top: 0;
    height: 100%;
    width: 33.33%;
    background: #1296db;
    transition: left 0.3s ease;
  }
}

.tabs {
  display: flex;
  background: #fff;
  border-bottom: 1px solid #e6e6e6;
  
  .tab-item {
    flex: 1;
    padding: 30rpx 20rpx;
    text-align: center;
    position: relative;
    font-size: 28rpx;
    color: #666;
    
    &.active {
      color: #1296db;
      font-weight: bold;
    }
    
    .badge {
      position: absolute;
      top: 20rpx;
      right: 20rpx;
      background: #ff4757;
      color: white;
      font-size: 20rpx;
      padding: 4rpx 8rpx;
      border-radius: 20rpx;
      min-width: 32rpx;
      text-align: center;
      line-height: 1;
    }
  }
}

.swiper-container {
  flex: 1;
  height: 100%;
}

.swiper-item {
  height: 100%;
}

.scroll-view {
  height: 100%;
  padding: 0;
  // 仅保留底部安全间距，避免被下方 Tabbar 遮挡
  padding-bottom: calc(env(safe-area-inset-bottom) + 40rpx);
}

.section-title {
  padding: 30rpx 20rpx 20rpx;
  font-size: 28rpx;
  color: #666;
  background: transparent;
}

.empty-state {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 100rpx 40rpx;
  
  .empty-icon {
    width: 120rpx;
    height: 120rpx;
    margin-bottom: 30rpx;
    opacity: 0.5;
  }
  
  .empty-text {
    font-size: 28rpx;
    color: #999;
  }
}

.application-item {
  background: #fff;
  border-radius: 16rpx;
  padding: 30rpx 30rpx; // 左右统一内边距，视觉为贴边风格
  box-sizing: border-box;
  margin-bottom: 20rpx;
  box-shadow: 0 2rpx 12rpx rgba(0, 0, 0, 0.1);
}

.item-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20rpx;
  padding-right: 0; // 左右都贴边
  
  .applicant-name {
    font-size: 32rpx;
    font-weight: bold;
    color: #333;
    flex: 1;
  }
  
  .status-badge {
    flex-shrink: 0;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    height: 44rpx;
    padding: 0 20rpx;
    line-height: 44rpx;
    border-radius: 9999rpx;
    font-size: 24rpx;
    color: white;
    white-space: nowrap;
    margin-left: 16rpx;
    margin-right: 0; // 左右都贴边
    
    &.status-pending {
      background: #ffa726;
    }
    
    &.status-accepted {
      background: #4caf50;
    }
    
    &.status-rejected {
      background: #f44336;
    }
  }
}

.item-content {
  margin-bottom: 20rpx;
  
  .position-name,
  .phone,
  .experience {
    display: block;
    font-size: 28rpx;
    color: #666;
    margin-bottom: 8rpx;
  }
  
  .position-name {
    color: #1296db;
    font-weight: bold;
  }
}

.item-footer {
  .apply-time,
  .process-time {
    display: block;
    font-size: 24rpx;
    color: #999;
    margin-bottom: 8rpx;
  }
  
  .quick-actions {
    display: flex;
    gap: 20rpx;
    margin-top: 20rpx;
    
    .quick-btn {
      flex: 1;
      padding: 16rpx 24rpx;
      border: none;
      border-radius: 8rpx;
      font-size: 26rpx;
      color: white;
      
      &.accept-btn {
        background: #4caf50;
      }
      
      &.reject-btn {
        background: #f44336;
      }
    }
  }
}


.loading-overlay {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(255, 255, 255, 0.8);
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 999;
  
  .loading-text {
    font-size: 28rpx;
    color: #666;
  }
}
</style>

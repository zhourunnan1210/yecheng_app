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
      <!-- 已申请列表 -->
      <swiper-item class="swiper-item">
        <scroll-view 
          scroll-y 
          class="scroll-view"

          :refresher-enabled="true"
          :refresher-triggered="refreshing"
          @refresherrefresh="onRefresh"
        >
          <view class="section-title">已申请 ({{ appliedList.length }})</view>
          
          <!-- 空状态 -->
          <view v-if="appliedList.length === 0 && !loading" class="empty-state">
            <image src="/static/font/empty.png" class="empty-icon"></image>
            <text class="empty-text">暂无申请记录</text>
          </view>
          
          <!-- 申请列表 -->
          <view 
            v-for="item in appliedList" 
            :key="item.applicationId" 
            class="application-item"
            @click="viewJobDetail(item)"
          >
            <view class="item-header">
              <text class="position-name">{{ item.positionName || '岗位名称' }}</text>
              <text class="status-badge status-applied">已申请</text>
            </view>
            
            <view class="item-content">
              <text class="company-name">{{ item.companyName || '公司名称' }}</text>
              <text class="salary-range">{{ formatSalary(item.salaryMin, item.salaryMax) }}</text>
            </view>
            
            <view class="item-footer">
              <text class="apply-time">申请时间：{{ formatTime(item.applyTime) }}</text>
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
            <text class="empty-text">暂无同意的面试</text>
          </view>
          
          <!-- 申请列表 -->
          <view 
            v-for="item in acceptedList" 
            :key="item.applicationId" 
            class="application-item"
            @click="viewJobDetail(item)"
          >
            <view class="item-header">
              <text class="position-name">{{ item.positionName || '岗位名称' }}</text>
              <text class="status-badge status-accepted">已同意</text>
            </view>
            
            <view class="item-content">
              <text class="company-name">{{ item.companyName || '公司名称' }}</text>
              <text class="salary-range">{{ formatSalary(item.salaryMin, item.salaryMax) }}</text>
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
            <text class="empty-text">暂无被拒绝的面试</text>
          </view>
          
          <!-- 申请列表 -->
          <view 
            v-for="item in rejectedList" 
            :key="item.applicationId" 
            class="application-item"
            @click="viewJobDetail(item)"
          >
            <view class="item-header">
              <text class="position-name">{{ item.positionName || '岗位名称' }}</text>
              <text class="status-badge status-rejected">已拒绝</text>
            </view>
            
            <view class="item-content">
              <text class="company-name">{{ item.companyName || '公司名称' }}</text>
              <text class="salary-range">{{ formatSalary(item.salaryMin, item.salaryMax) }}</text>
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
        { name: '已申请', count: 0 },
        { name: '已同意', count: 0 },
        { name: '已拒绝', count: 0 }
      ],
      
      // 数据列表
      appliedList: [],
      acceptedList: [],
      rejectedList: [],
      
      // 分页状态已移除
      
      tabbar: []
    }
  },
  
  onLoad() {
    this.tabbar = global.tabbar;
    this.loadAllApplications();
  },
  
  onShow() {
    // 页面显示时刷新数据
    this.loadAllApplications();
  },
  
  methods: {
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
      if (!this.$store.state.userInfo.uid) {
        uni.showToast({
          title: '请先登录',
          icon: 'error'
        });
        return;
      }
      
      this.loading = true;
      
      try {
        // 并行加载三种状态的数据
        await Promise.all([
          this.loadApplicationsByStatus(0), // 已申请
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
          url: `http://localhost:10086/api/interview/applications/${this.$store.state.userInfo.uid}`,
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
          console.log(`状态${status}的申请数据:`, data);
          
          // 检查数据完整性
          data.forEach((item, index) => {
            console.log(`申请记录${index}:`, item);
            if (!item.talentNeedId) {
              console.warn(`申请记录${index}缺少talentNeedId:`, item);
            }
          });
          
          switch (status) {
            case 0:
              this.appliedList = data;
              break;
            case 1:
              this.acceptedList = data;
              break;
            case 2:
              this.rejectedList = data;
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
      this.tabs[0].count = this.appliedList.length;
      this.tabs[1].count = this.acceptedList.length;
      this.tabs[2].count = this.rejectedList.length;
    },
    
    // 查看岗位详情
    viewJobDetail(item) {
      console.log('点击查看岗位详情:', item);
      console.log('岗位ID:', item.talentNeedId);
      
      if (!item.talentNeedId) {
        uni.showToast({
          title: '岗位信息有误',
          icon: 'error'
        });
        return;
      }
      
      uni.navigateTo({
        url: `/pages/talent/interview_application?talentNeedId=${item.talentNeedId}`
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
    },
    
    // 格式化薪资
    formatSalary(salaryMin, salaryMax) {
      if (!salaryMin && !salaryMax) return '面议';
      if (salaryMin && salaryMax) {
        return `${salaryMin}k-${salaryMax}k`;
      }
      if (salaryMin) return `${salaryMin}k起`;
      if (salaryMax) return `${salaryMax}k封顶`;
      return '面议';
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
  
  .position-name {
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
    
    &.status-applied {
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
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20rpx;
  
  .company-name {
    font-size: 28rpx;
    color: #666;
  }
  
  .salary-range {
    font-size: 28rpx;
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
    margin-bottom: 4rpx;
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

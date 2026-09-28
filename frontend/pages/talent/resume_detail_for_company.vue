<template>
  <view class="mainclass">
    <!-- 加载状态 -->
    <view v-if="loading" class="loading-container">
      <text class="loading-text">加载中...</text>
    </view>
    
    <!-- 错误状态 -->
    <view v-else-if="error" class="error-container">
      <text class="error-text">{{ error }}</text>
      <button @click="retryLoad" class="retry-btn">重试</button>
    </view>
    
    <!-- 主要内容 -->
    <view v-else-if="resumeData" class="content">
      <!-- 简历头部信息 -->
      <view class="resume-header">
        <view class="avatar-section">
          <image 
            :src="getAvatarUrl()" 
            class="avatar"
          ></image>
        </view>
        
        <view class="basic-info">
          <text class="name">{{ getDisplayName() }}</text>
          <text class="education">{{ getEducationText() }}</text>
          <view class="basic-details">
            <text class="detail-item" v-if="getAge()">{{ getAge() }}岁</text>
            <text class="detail-item" v-if="getGenderText()">{{ getGenderText() }}</text>
            <text class="detail-item" v-if="getSchoolInfo()">{{ getSchoolInfo() }}</text>
          </view>
          <view class="tags">
            <text 
              v-for="(skill, index) in getSkillTags()" 
              :key="index"
              class="skill-tag"
            >
              {{ skill }}
            </text>
          </view>
        </view>
      </view>
      
      <!-- 联系信息 -->
      <view class="section">
        <view class="section-title">联系信息</view>
        <view class="contact-info">
          <view class="info-item">
            <text class="label">手机号码：</text>
            <text class="value">{{ resumeData.phone || '未提供' }}</text>
          </view>
          <view class="info-item">
            <text class="label">邮箱地址：</text>
            <text class="value">{{ resumeData.email || '未提供' }}</text>
          </view>
          <view class="info-item">
            <text class="label">所在地区：</text>
            <text class="value">{{ resumeData.location || '未填写' }}</text>
          </view>
        </view>
      </view>
      
      <!-- 申请岗位信息 -->
      <view class="section" v-if="applicationData">
        <view class="section-title">申请信息</view>
        <view class="application-info">
          <view class="info-item">
            <text class="label">申请岗位：</text>
            <text class="value">{{ applicationData.positionName || '未知岗位' }}</text>
          </view>
          <view class="info-item">
            <text class="label">申请时间：</text>
            <text class="value">{{ formatTime(applicationData.applyTime) }}</text>
          </view>
          <view class="info-item">
            <text class="label">当前状态：</text>
            <text class="value status" :class="getStatusClass()">{{ getStatusText() }}</text>
          </view>
        </view>
      </view>
      
      <!-- 求职意向 -->
      <view class="section" v-if="talentSupplyData">
        <view class="section-title">求职意向</view>
        <view class="info-grid">
          <view class="info-item">
            <text class="label">期望岗位：</text>
            <text class="value">{{ talentSupplyData.job || '未填写' }}</text>
          </view>
          <view class="info-item">
            <text class="label">期望薪资：</text>
            <text class="value">{{ getSalaryRange() }}</text>
          </view>
          <view class="info-item">
            <text class="label">工作性质：</text>
            <text class="value">{{ talentSupplyData.jobNature || '未填写' }}</text>
          </view>
          <view class="info-item">
            <text class="label">求职状态：</text>
            <text class="value">{{ talentSupplyData.jobStatus || '未填写' }}</text>
          </view>
        </view>
      </view>
      
      <!-- 工作经验 -->
      <view class="section">
        <view class="section-title">工作经验</view>
        <view class="experience-content">
          <text class="content-text">{{ getExperienceText() }}</text>
        </view>
      </view>
      
      <!-- 教育背景 -->
      <view class="section">
        <view class="section-title">教育背景</view>
        <view class="education-content">
          <view class="education-item" v-if="talentSupplyData">
            <view class="info-item">
              <text class="label">学历：</text>
              <text class="value">{{ getEducationText() }}</text>
            </view>
            <view class="info-item" v-if="talentSupplyData.school">
              <text class="label">毕业院校：</text>
              <text class="value">{{ talentSupplyData.school }}</text>
            </view>
            <view class="info-item" v-if="talentSupplyData.profession">
              <text class="label">专业：</text>
              <text class="value">{{ talentSupplyData.profession }}</text>
            </view>
            <view class="info-item" v-if="getEducationTimeRange()">
              <text class="label">在校时间：</text>
              <text class="value">{{ getEducationTimeRange() }}</text>
            </view>
          </view>
          <text v-else class="content-text">{{ (resumeData && resumeData.educationalBackground) || '暂无教育背景信息' }}</text>
        </view>
      </view>
      
      <!-- 专业技能 -->
      <view class="section">
        <view class="section-title">专业技能</view>
        <view class="skills-content">
          <text class="content-text">{{ getSkillsText() }}</text>
        </view>
      </view>
      
      <!-- 性格品质 -->
      <view class="section" v-if="talentSupplyData && talentSupplyData.quality">
        <view class="section-title">性格品质</view>
        <view class="quality-content">
          <text class="content-text">{{ talentSupplyData.quality }}</text>
        </view>
      </view>
      
      <!-- 个人介绍 -->
      <view class="section" v-if="resumeData.personalIntroduction">
        <view class="section-title">个人介绍</view>
        <view class="intro-content">
          <text class="content-text">{{ resumeData.personalIntroduction }}</text>
        </view>
      </view>
    </view>
    
    <!-- 企业操作按钮区域 -->
    <view class="action-footer" v-if="applicationData && applicationData.status === 0">
      <view class="action-buttons">
        <button @click="processApplication(1)" class="action-btn accept-btn">
          同意面试
        </button>
        <button @click="processApplication(2)" class="action-btn reject-btn">
          拒绝申请
        </button>
      </view>
    </view>
    
    <!-- 已处理状态显示 -->
    <view class="processed-status" v-else-if="applicationData && applicationData.status !== 0">
      <text class="status-text" :class="getStatusClass()">
        {{ getStatusText() }}
      </text>
      <text class="process-time">处理时间：{{ formatTime(applicationData.processTime) }}</text>
    </view>
    
    <!-- 无数据状态 -->
    <view v-else class="no-data-container">
      <text class="no-data-text">暂无简历信息</text>
    </view>
  </view>
</template>

<script>
export default {
  data() {
    return {
      loading: true,
      error: null,
      resumeData: null,
      talentSupplyData: null,
      applicationData: null,
      applicationId: null,
      userId: null
    }
  },
  
  onLoad(options) {
    console.log('简历详情页面参数:', options);
    
    this.applicationId = options.applicationId;
    this.userId = options.userId;
    // 额外携带的ID（若有，则优先用于补全数据）
    this.prefetchTalentSupplyId = options.talentSupplyId || null;
    this.prefetchTalentNeedId = options.talentNeedId || null;
    
    // 接收来源页面通过 eventChannel 透传过来的卡片数据，先行渲染，避免白屏
    try {
      const eventChannel = this.getOpenerEventChannel && this.getOpenerEventChannel();
      if (eventChannel && eventChannel.on) {
        eventChannel.on('resume-card-data', ({ applicationData, resumeData, talentSupplyId, talentNeedId }) => {
          if (applicationData) {
            this.applicationData = { ...applicationData };
          }
          if (resumeData) {
            // 仅作为兜底展示，后续接口会刷新为最新数据
            this.resumeData = { ...resumeData };
          }
          if (talentSupplyId && !this.prefetchTalentSupplyId) this.prefetchTalentSupplyId = talentSupplyId;
          if (talentNeedId && !this.prefetchTalentNeedId) this.prefetchTalentNeedId = talentNeedId;
        });
      }
    } catch (e) {
      console.warn('接收透传数据失败:', e);
    }
    
    if (!this.applicationId || !this.userId) {
      this.error = '缺少必要参数';
      this.loading = false;
      return;
    }
    
    this.loadResumeData();
  },
  
  methods: {
    // 加载简历数据
    async loadResumeData() {
      this.loading = true;
      this.error = null;
      
      try {
        // 并行加载用户基本信息、talent_supply信息和申请信息
        await Promise.all([
          this.loadUserBasicInfo(),
          this.loadTalentSupplyInfo(),
          this.loadApplicationInfo()
        ]);
        
        // 若申请信息中缺少岗位名称，则根据 talentNeedId 进一步补充
        const needId = this.applicationData?.talentNeedId || this.prefetchTalentNeedId;
        if (this.applicationData && !this.applicationData.positionName && needId) {
          await this.loadJobInfoByTalentNeedId(needId);
        }
        
      } catch (error) {
        console.error('加载简历数据失败:', error);
        this.error = error.message || '加载失败，请重试';
      } finally {
        this.loading = false;
      }
    },
    
    // 加载用户基本信息
    async loadUserBasicInfo() {
      try {
        const [error, res] = await uni.request({
          url: `http://localhost:10086/user/info/${this.userId}`,
          method: 'GET',
          header: {
            'content-type': 'application/json'
          }
        });
        
        if (error) {
          throw error;
        }
        
        if (res.data.code === 0) {
          // 兼容后端两种可能的数据包装：{data: {...}} 或 {user: {...}}
          const userPayload = res.data.data || res.data.user;
          if (userPayload) {
            // 合并而非完全覆盖，保留列表页透传的 avatar（如果后端 avatar 为空）
            const merged = { ...this.resumeData, ...userPayload };
            if (!merged.avatar && this.resumeData && this.resumeData.avatar) {
              merged.avatar = this.resumeData.avatar;
            }
            this.resumeData = merged;
          }
          console.log('用户基本信息:', this.resumeData);
        } else {
          throw new Error(res.data.message || '获取用户信息失败');
        }
        
      } catch (error) {
        console.error('获取用户基本信息失败:', error);
        throw new Error('获取用户信息失败: ' + (error.message || '未知错误'));
      }
    },
    
    // 加载talent_supply详细信息
    async loadTalentSupplyInfo() {
      try {
        // 优先使用直接的简历ID
        if (this.prefetchTalentSupplyId) {
          const [e0, r0] = await uni.request({
            url: `http://localhost:10086/talentSupply/getById/${this.prefetchTalentSupplyId}`,
            method: 'GET'
          });
          if (!e0 && r0 && r0.data && r0.data.code === 0) {
            this.talentSupplyData = r0.data.data || r0.data.talentSupply || r0.data.result || null;
            if (this.talentSupplyData) {
              console.log('通过简历ID获取人才供给信息:', this.talentSupplyData);
              return;
            }
          }
        }
        
        const [error, res] = await uni.request({
          url: `http://localhost:10086/talentSupply/getByUserId/${this.userId}`,
          method: 'GET',
          header: {
            'content-type': 'application/json'
          }
        });
        
        if (error) {
          throw error;
        }
        
        if (res.data && res.data.code === 0) {
          // 兼容不同数据结构（后端 yecheng_app 返回 key 为 talentSupplies）
          this.talentSupplyData = res.data.talentSupplies || res.data.data || res.data.talentSupply || res.data.result || null;
          console.log('人才供给信息:', this.talentSupplyData);
        }
        
        // 若仍未获取到，尝试备选接口路径（兼容历史后端接口）
        if (!this.talentSupplyData) {
          const fallbackUrls = [
            `http://localhost:10086/talentSupply/getByUserId?userId=${this.userId}`,
            `http://localhost:10086/talentSupply/getByUid/${this.userId}`
          ];
          for (const url of fallbackUrls) {
            try {
              const [e2, r2] = await uni.request({ url, method: 'GET' });
              if (!e2 && r2 && r2.data && r2.data.code === 0) {
                this.talentSupplyData = r2.data.data || r2.data.talentSupply || r2.data.result || null;
                if (this.talentSupplyData) break;
              }
            } catch (_) {
              // 忽略，继续尝试下一个
            }
          }
          if (!this.talentSupplyData) {
            console.warn('未获取到人才供给详情，可能该用户尚未填写简历');
          }
        }
        
      } catch (error) {
        console.error('获取人才供给信息失败:', error);
        // 不抛出错误，继续加载其他信息
      }
    },
    
    // 加载申请信息
    async loadApplicationInfo() {
      try {
        const [error, res] = await uni.request({
          url: `http://localhost:10086/api/interview/application/${this.applicationId}`,
          method: 'GET',
          header: {
            'content-type': 'application/json'
          }
        });
        
        if (error) {
          throw error;
        }
        
        if (res.data.code === 0) {
          this.applicationData = res.data.data;
          console.log('申请信息:', this.applicationData);
          // 如携带职位名，确保映射
          if (!this.applicationData.positionName && this.applicationData.position) {
            this.applicationData.positionName = this.applicationData.position;
          }
        } else {
          throw new Error(res.data.message || '获取申请信息失败');
        }
        
      } catch (error) {
        console.error('获取申请信息失败:', error);
        throw new Error('获取申请信息失败: ' + (error.message || '未知错误'));
      }
    },

    // 根据 talentNeedId 获取岗位名称等信息
    async loadJobInfoByTalentNeedId(talentNeedId) {
      try {
        const [error, res] = await uni.request({
          url: `http://localhost:10086/talentNeed/get/${talentNeedId}`,
          method: 'GET',
          header: { 'content-type': 'application/json' }
        });
        if (error) throw error;
        if (res.data && res.data.code === 0 && res.data.data) {
          const job = res.data.data;
          if (!this.applicationData) this.applicationData = {};
          // 按你的后端定义，岗位名称来自 talent_need 表的 position 字段
          this.applicationData.positionName = job.position || job.title || job.name || job.positionName || job.job || '岗位';
        }
      } catch (err) {
        console.warn('根据talentNeedId获取岗位信息失败:', err);
      }
    },
    
    // 重试加载
    async retryLoad() {
      await this.loadResumeData();
    },
    
    // 处理面试申请
    async processApplication(status) {
      const actionText = status === 1 ? '同意' : '拒绝';
      
      // 二次确认
      const confirmed = await this.showConfirmDialog(`确定要${actionText}此申请吗？`);
      if (!confirmed) return;
      
      try {
        const [error, res] = await uni.request({
          url: 'http://localhost:10086/api/interview/process',
          method: 'POST',
          data: {
            applicationId: this.applicationId,
            status: status,
            processUserId: this.$store.state.userInfo.uid,
            remarks: ''
          },
          // 后端 @RequestParam 接收，需要表单编码
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
          
          // 更新本地申请状态
          this.applicationData.status = status;
          this.applicationData.processTime = new Date().toISOString();
          
          // 延迟返回上一页并刷新列表
          setTimeout(() => {
            uni.navigateBack();
            // 通知父页面刷新数据
            uni.$emit('refresh-applications');
          }, 1500);
          
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
    
    // 获取头像URL（优先使用talentSupplyData.image，与talentinsidet.vue保持一致）
    getAvatarUrl() {
      if (this.talentSupplyData && this.talentSupplyData.image) {
        return this.talentSupplyData.image;
      }
      if (this.resumeData && this.resumeData.avatar) {
        return this.resumeData.avatar;
      }
      return '/static/avatar.png';
    },
    
    // 获取显示名称
    getDisplayName() {
      if (this.talentSupplyData && this.talentSupplyData.name) {
        return this.talentSupplyData.name;
      }
      return (this.resumeData && this.resumeData.realName) || '求职者';
    },
    
    // 获取年龄
    getAge() {
      return (this.talentSupplyData && this.talentSupplyData.age) || null;
    },
    
    // 获取性别文本
    getGenderText() {
      if (!this.talentSupplyData || !this.talentSupplyData.gender) return null;
      const genderMap = {
        1: '男',
        2: '女'
      };
      return genderMap[this.talentSupplyData.gender];
    },
    
    // 获取学校信息
    getSchoolInfo() {
      return (this.talentSupplyData && this.talentSupplyData.school) || null;
    },
    
    // 获取教育背景文本
    getEducationText() {
      let degree = null;
      if (this.talentSupplyData && this.talentSupplyData.degree) {
        degree = this.talentSupplyData.degree;
      } else if (this.resumeData && this.resumeData.educationalBackground) {
        degree = this.resumeData.educationalBackground;
      }
      
      const educationMap = {
        1: '博士研究生',
        2: '硕士研究生', 
        3: '本科',
        4: '大专',
        5: '中专',
        6: '高中'
      };
      return educationMap[degree] || degree || '未填写';
    },
    
    // 获取技能标签
    getSkillTags() {
      let skills = null;
      if (this.talentSupplyData && this.talentSupplyData.skill) {
        skills = this.talentSupplyData.skill;
      } else if (this.resumeData && this.resumeData.professionalSkills) {
        skills = this.resumeData.professionalSkills;
      }
      
      if (!skills) return [];
      
      // 简单分割技能，实际项目中可能需要更复杂的解析
      return skills.split(/[,，；;、]/).filter(skill => skill.trim()).slice(0, 5);
    },
    
    // 获取薪资范围
    getSalaryRange() {
      if (!this.talentSupplyData) return '面议';
      
      const { salaryMin, salaryMax } = this.talentSupplyData;
      if (!salaryMin && !salaryMax) return '面议';
      if (salaryMin && salaryMax) {
        return `${salaryMin}k - ${salaryMax}k`;
      }
      if (salaryMin) return `${salaryMin}k起`;
      if (salaryMax) return `${salaryMax}k封顶`;
      return '面议';
    },
    
    // 获取工作经验文本
    getExperienceText() {
      if (this.talentSupplyData && this.talentSupplyData.experience) {
        return this.talentSupplyData.experience;
      }
      return (this.resumeData && this.resumeData.workExperience) || '暂无工作经验描述';
    },
    
    // 获取专业技能文本
    getSkillsText() {
      if (this.talentSupplyData && this.talentSupplyData.skill) {
        return this.talentSupplyData.skill;
      }
      return (this.resumeData && this.resumeData.professionalSkills) || '暂无专业技能描述';
    },
    
    // 获取教育时间范围
    getEducationTimeRange() {
      if (!this.talentSupplyData) return null;
      
      const { enterDate, graduateDate } = this.talentSupplyData;
      if (!enterDate && !graduateDate) return null;
      
      const formatDate = (dateStr) => {
        if (!dateStr) return '';
        try {
          const date = new Date(dateStr);
          return `${date.getFullYear()}.${String(date.getMonth() + 1).padStart(2, '0')}`;
        } catch {
          return dateStr;
        }
      };
      
      const start = formatDate(enterDate);
      const end = formatDate(graduateDate);
      
      if (start && end) return `${start} - ${end}`;
      if (start) return `${start} -`;
      if (end) return `- ${end}`;
      return null;
    },
    
    // 获取状态样式类
    getStatusClass() {
      if (!this.applicationData) return '';
      
      switch (this.applicationData.status) {
        case 0:
          return 'status-pending';
        case 1:
          return 'status-accepted';
        case 2:
          return 'status-rejected';
        default:
          return '';
      }
    },
    
    // 获取状态文本
    getStatusText() {
      if (!this.applicationData) return '';
      
      switch (this.applicationData.status) {
        case 0:
          return '待处理';
        case 1:
          return '已同意';
        case 2:
          return '已拒绝';
        default:
          return '未知状态';
      }
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

<style scoped lang="scss">
.mainclass {
  background-color: #f5f5f5;
  min-height: 100vh;
  // 使用安全区域 + 预留内边距，避免底部固定栏遮挡内容
  padding-bottom: calc(env(safe-area-inset-bottom) + 220rpx);
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

// 简历头部
.resume-header {
  background: #fff;
  padding: 40rpx;
  display: flex;
  align-items: center;
  margin-bottom: 20rpx;
  box-shadow: 0 2rpx 12rpx rgba(0, 0, 0, 0.1);
  
  .avatar-section {
    margin-right: 30rpx;
    
    .avatar {
      width: 120rpx;
      height: 120rpx;
      border-radius: 60rpx;
      background-color: #f0f0f0;
    }
  }
  
  .basic-info {
    flex: 1;
    
    .name {
      display: block;
      font-size: 36rpx;
      font-weight: bold;
      color: #333;
      margin-bottom: 10rpx;
    }
    
    .education {
      display: block;
      font-size: 28rpx;
      color: #666;
      margin-bottom: 15rpx;
    }
    
    .basic-details {
      display: flex;
      flex-wrap: wrap;
      gap: 15rpx;
      margin-bottom: 15rpx;
      
      .detail-item {
        font-size: 26rpx;
        color: #888;
        background: #f5f5f5;
        padding: 6rpx 12rpx;
        border-radius: 12rpx;
      }
    }
    
    .tags {
      display: flex;
      flex-wrap: wrap;
      gap: 10rpx;
      
      .skill-tag {
        padding: 8rpx 16rpx;
        background: #e3f2fd;
        color: #1976d2;
        font-size: 24rpx;
        border-radius: 20rpx;
      }
    }
  }
}

// 内容区段
.section {
  background: #fff;
  margin-bottom: 20rpx;
  padding: 30rpx 40rpx;
  box-shadow: 0 2rpx 12rpx rgba(0, 0, 0, 0.1);
}

.section-title {
  font-size: 32rpx;
  font-weight: bold;
  color: #333;
  margin-bottom: 30rpx;
  position: relative;
  padding-left: 20rpx;
  
  &:before {
    content: '';
    position: absolute;
    left: 0;
    top: 50%;
    transform: translateY(-50%);
    width: 6rpx;
    height: 32rpx;
    background: #1296db;
    border-radius: 3rpx;
  }
}

// 联系信息
.contact-info,
.application-info {
  .info-item {
    display: flex;
    margin-bottom: 20rpx;
    align-items: center;
    
    .label {
      font-size: 28rpx;
      color: #666;
      min-width: 160rpx;
    }
    
    .value {
      font-size: 28rpx;
      color: #333;
      flex: 1;
      
      &.status {
        font-weight: bold;
        
        &.status-pending {
          color: #ffa726;
        }
        
        &.status-accepted {
          color: #4caf50;
        }
        
        &.status-rejected {
          color: #f44336;
        }
      }
    }
  }
}

// 信息网格布局
.info-grid {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 20rpx;
  
  .info-item {
    display: flex;
    flex-direction: column;
    gap: 8rpx;
    
    .label {
      font-size: 26rpx;
      color: #666;
      font-weight: 500;
    }
    
    .value {
      font-size: 28rpx;
      color: #333;
    }
  }
}

// 教育信息项
.education-item {
  .info-item {
    display: flex;
    flex-direction: row;
    align-items: center;
    margin-bottom: 15rpx;
    
    .label {
      width: 120rpx;
      font-size: 26rpx;
      color: #666;
    }
    
    .value {
      flex: 1;
      font-size: 28rpx;
      color: #333;
    }
  }
}

// 内容文本
.experience-content,
.education-content,
.skills-content,
.intro-content,
.quality-content {
  .content-text {
    font-size: 28rpx;
    color: #333;
    line-height: 1.6;
    display: block;
  }
}

// 操作按钮区域
.action-footer {
  position: fixed;
  bottom: 0;
  left: 0;
  right: 0;
  background: #fff;
  border-top: 1px solid #e6e6e6;
  padding: 30rpx 40rpx calc(env(safe-area-inset-bottom) + 0rpx) 40rpx;
  z-index: 999;
  
  .action-buttons {
    display: flex;
    gap: 30rpx;
    
    .action-btn {
      flex: 1;
      padding: 30rpx 0;
      border-radius: 12rpx;
      font-size: 32rpx;
      font-weight: bold;
      border: none;
      
      &.accept-btn {
        background: #4caf50;
        color: white;
      }
      
      &.reject-btn {
        background: #f44336;
        color: white;
      }
    }
  }
}

// 已处理状态
.processed-status {
  position: fixed;
  bottom: 0;
  left: 0;
  right: 0;
  background: #fff;
  border-top: 1px solid #e6e6e6;
  padding: 30rpx 40rpx;
  text-align: center;
  z-index: 999;
  
  .status-text {
    display: block;
    font-size: 32rpx;
    font-weight: bold;
    margin-bottom: 10rpx;
    
    &.status-accepted {
      color: #4caf50;
    }
    
    &.status-rejected {
      color: #f44336;
    }
  }
  
  .process-time {
    font-size: 24rpx;
    color: #999;
  }
}
</style>

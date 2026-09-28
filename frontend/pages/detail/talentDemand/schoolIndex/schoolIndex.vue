<template>
	<view class="content">
		<!-- 导航栏 -->
		<view class="wrap">
			<view class="u-tabs-box">
				<u-tabs-swiper activeColor="#1296db" ref="tabs" :list="list" :current="current" @change="tebchange" :is-scroll="false"
				 swiperWidth="750" inactive-color="#000000"></u-tabs-swiper>
			</view>	
		</view>

		
		<swiper class="swiper-box" :current="swiperCurrent" @transition="transition" @animationfinish="animationfinish" style="height: 100vh;">			
			
			<swiper-item class="swiper-item">
				<u-dropdown> 
				
					<u-dropdown-item v-model="checkId2" title="审核状态" :options="optioncheckId2"   @change="change3"></u-dropdown-item>		
				</u-dropdown>
			
				<scroll-view scroll-y style="height: 100%;width: 100%;" >
					
					<view v-for="(item,index) in BusinessList" class="box1" @click="getBusiness(item.talentNeedId)">
						<u-row>
							<u-col span="4">
								<view class="iconbox1">
									<image :src="item.image">
								</view>
							</u-col>
							
							<u-col span="8">
								<view class="textbox">{{item.companyId}}</view>
								<view class="notebox u-line-1">学历范围：{{item.education}}</view>
								<view class="notebox u-line-1">招聘岗位：{{item.position}}</view>
								<view class="notebox u-line-1">起步薪资：{{item.salaryMin}}k-{{item.salaryMax}}k</view>
								<view  style="color: red;" class="notebox u-line-1">审核状态：{{check[item.schoolCheck]}}</view>
							</u-col>
						</u-row>
					</view>		
				</scroll-view>

			</swiper-item>
			
			
			<swiper-item class="swiper-item" style="height: 100%;width: 100%;">
				
				<u-dropdown>
					<u-dropdown-item v-model="checkId"  title="审核状态" :options="optioncheckId"       @change="change6"></u-dropdown-item>		
				</u-dropdown>
				
				<scroll-view scroll-y style="height: 100%;width: 100%;" >
					<view v-for="(item,index) in TalentList" class="box1" @click="getTalent(item.talentSupplyId)">
							<u-row>
								<u-col span="4">
									<view class="iconbox1">
										<image :src="item.image">
									</view>
								</u-col>
								
								<u-col span="8">
									<view class="textbox">{{item.name}}</view>
									<view class="notebox u-line-1">学历：{{degreelist[item.degree]}}</view>
									<view class="notebox u-line-1">应聘职位：{{item.profession}}</view>
									<view class="notebox u-line-1">期望薪资：{{item.salaryMin}}k-{{item.salaryMax}}k</view>
									<view style="color: red;" class="notebox u-line-1">审核状态：{{check[item.schoolCheck]}}</view>
								</u-col>
							</u-row>							
					</view>
				</scroll-view>
				
			</swiper-item>
			
		</swiper>
		
		
	</view>
</template>

<script>
	export default {
		data() {
			return {
				degreelist: ['','专科','本科','硕士','博士'],
				list:[
					{
						name:'企业招聘审核'
					},
					{
						name:'人才简历审核'
					},
				],
				current:0,
				swiperCurrent: 0,
				dx:0,
				TalentList:'',
				BusinessList:'',
				check:['未审核','已审核'],
				checkId:'1',
				checkId2:'1',
				optioncheckId:[
					{
						label:"未审核",
						value:"0",
					},
					{
						label:"已审核",
						value:"1",
					},
				],
				optioncheckId2:[
					{
						label:"未审核",
						value:"0",
					},
					{
						label:"已审核",
						value:"1",
					},
				],
			}
		},
		mounted(){
			this.GetTalentList()
			this.getBusinessList()
		},
		methods: {
			/*企业列表*/
		async getBusinessList() {
			const res = await this.$myRequest({
			url: '/talentneed/listByCheck',
			method: 'POST',
			header: {
					'content-type': 'application/json'
				},
				data: {
					"checkId": this.checkId2, //0，1,2,
				}
			});
			this.BusinessList = res.data.data
		},
			//人才列表申请
			async GetTalentList() {
					const res = await this.$myRequest({
					url: '/talentsupply/listByCheck',
					method: 'POST',
					header: {
							'content-type': 'application/json'
						},
						data: {
							"checkId": this.checkId, //0，1,2,
						}
					});
					this.TalentList = res.data.data
			
			},
			change3(index) {
				if (index == '0') {
					this.checkId2 = '0'
				} 
				else {	
					this.checkId2 = '1'
				}
				this.getBusinessList()
			},
				change6(index) {
					if (index == '0') {
						this.checkId = '0'
					} 
					else {	
						this.checkId = '1'
					}
					this.GetTalentList()
				},
			/* 点击进入企业详情页 */
			getBusiness(talentNeedId) {
				
				uni.navigateTo({
					url: "../businessIndex/businessInside/businessInside?talentNeedId="+talentNeedId
				});
			},
			/* 点击进入人才详情页 */
			getTalent(talentSupplyId) {
				
				uni.navigateTo({
					url: "../talentIndex/talentInside/talentInside?talentSupplyId="+talentSupplyId
				});
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

<style lang = "scss" scoped>
	.box1 {
		border-bottom: 1px solid;
		border-color: #e6e6e6;
		height: 200rpx;
		background: #FFFFFF;
		
		.content{
			size: a4;
		}
		
		.iconbox1 image {
			margin-left: 40rpx;
			margin-top: 28rpx;
			width: 80px;
			height: 80px;
			}
		
		.textbox {
			margin: 0 10rpx 5rpx 10rpx;
			padding: 10rpx 10rpx 5rpx 10rpx;
			font-weight: 750;
			color: #000000;
			line-height: 1.2;
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

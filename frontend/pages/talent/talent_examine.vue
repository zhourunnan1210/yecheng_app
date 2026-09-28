<template>
	<view class="content">
			<swiper-item class="swiper-item">
      <scroll-view scroll-y style="height: 100%;width: 100%;" @scrolltolower="reachBottom">
				<u-dropdown>
					<u-dropdown-item v-model="checkId"  title="审核状态" :options="optioncheckId"       @change="change6"></u-dropdown-item>
				</u-dropdown>
        <view>
	        <uni-search-bar @confirm="search" :focus="true" v-model="searchValue" @blur="blur" @input="input" @cancel="cancel" @change="change" @clear="clear">
			</uni-search-bar>
				</view>
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
					url: "/pages/talent/talentinsidet?talentSupplyId="+talentSupplyId
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

<style lang="scss">
	.box1 {
		border-bottom: 1px solid;
		border-color: #e6e6e6;
		height: 200rpx;
		background: #FFFFFF;

		.content {
			size: a4;
		}

		.iconbox1 image {
			margin-left: 40rpx;
			margin-top: 28rpx;
			width: 80px;
			height: 80px;
			transform: auto;

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

	.swiper-box {
		flex: 1;
	}

	.swiper-item {
		height: 100%;
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
</style>

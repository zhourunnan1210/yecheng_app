<template>
	<view class="content">
		<swiper style="height: 100%;width: 100%;">
			<swiper-item class="swiper-item" style="height: 100%;width: 100%;">
				<scroll-view scroll-y style="height: 100%;width: 100%;" @scrolltolower="reachBottom">
					<uni-search-bar @confirm="search" :focus="true" v-model="searchValue" @blur="blur" @input="input"
						@cancel="cancel" @change="change" @clear="clear">
					</uni-search-bar>
					<view v-for="(item,index) in TalentList" class="box1" @click="getTalent(item.talentNeedId)">
						<u-row>
							<u-col span="4">
								<view class="iconbox1">
									<image :src="item.image"></image>
								</view>
							</u-col>

							<u-col span="8">
								<view class="textbox">{{item.companyId}}</view>
								<view class="notebox u-line-1">最低范围：{{degreelist[item.degree]}}</view>
								<view class="notebox u-line-1">招聘岗位：{{item.position}}</view>
								<view class="notebox u-line-1">起步薪资：{{item.salaryMin}}k-{{item.salaryMax}}k</view>
								<view class="notebox u-line-1">发布时间：{{item.publishTime}}</view>
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
				model: {
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
				list: [{
						name: '企业推荐'
					},
					{
						name: '个人管理'
					},
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
			}
		},
		onLoad() {
			this.getTalentList()
		},
		methods: {
			async search(fresh) {
				this.condition = fresh.value
				const res = await this.$myRequest({
					url: '/talentNeed/listByCondition',
					method: 'POST',
					header: {
						'content-type': 'application/json'
					},
					data: {
						"condition": this.condition,
					}
				});
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
			/* 点击进入企业详情页 */
			getTalent(talentNeedId) {
				console.log(talentNeedId)
				uni.navigateTo({
					url: "/pages/talent/businessinsidet?talentNeedId=" + talentNeedId
				});
			},
			/*企业列表*/
			async getTalentList() {
				const res = await this.$myRequest({
					url: '/talentNeed/listByDurationDegree',
					method: 'POST',
					header: {
						'content-type': 'application/json'
					},
					data: {
						"degree": this.degree2, //0，1,2,
						"duration": this.publishTime2 //
					},
				});
				console.log('面试通知列表',res.data)
				this.TalentList = res.data.data
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
					url: "../businessIndex/businessInside/businessInside",
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
		height: 200rpx;
		background: #FFFFFF;

		.content {
			height: 100%;
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

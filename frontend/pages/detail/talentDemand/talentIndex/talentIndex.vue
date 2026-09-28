<template>
	<view class="content">
		<!-- 导航栏 -->
		<view class="wrap">
			<view class="u-tabs-box">
				<u-tabs-swiper activeColor="#1296db" ref="tabs" :list="list" :current="current" @change="tebchange"
					:is-scroll="false" swiperWidth="750" inactive-color="#000000"></u-tabs-swiper>
			</view>
		</view>

		<swiper class="swiper-box" :current="swiperCurrent" @transition="transition" @animationfinish="animationfinish"
			style="height: 100vh;">
			<swiper-item class="swiper-item">



				<u-dropdown>
					<u-dropdown-item v-model="degree" title="  最低学历  " :options="optionsDegree" @change="change1">
					</u-dropdown-item>
					<u-dropdown-item v-model="talentType" title="发布时间" :options="optionsPublishTime" @change="change2">
					</u-dropdown-item>
				</u-dropdown>

				<uni-search-bar @confirm="search" :focus="true" v-model="searchValue" @blur="blur" @input="input"
					@cancel="cancel" @change="change" @clear="clear">
				</uni-search-bar>

				<scroll-view scroll-y style="height: 100%;width: 100%;">

					<view v-for="(item,index) in TalentList" class="box1" @click="getTalent(item.talentNeedId)">
						<u-row>
							<u-col span="4">
								<view class="iconbox1">
									<image :src="item.image">
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


			<swiper-item class="swiper-item" style="height: 100%;width: 100%;">

				<u-toast ref="uToast" />
				<u-form :model="model" :rules="rules" ref="uForm">
					<view class="title">
						个人简历发布
					</view>
					<u-line />
					<u-form-item label-width="120" label-position="top" label="姓名" prop="title">
						<u-input border placeholder="" v-model="model.name" type="text"></u-input>
					</u-form-item>
					<u-form-item label-width="120" label-position="top" label="年龄" prop="financingMethod">
						<u-input border placeholder="" v-model="model.title1" type="text"></u-input>
					</u-form-item>
					<u-form-item label-position="top" label="毕业院校" prop="financingIntroduction">
						<u-input type="textarea" border placeholder="选择毕业院校" v-model="model.financingIntroduction" />
					</u-form-item>
					<!-- 		<u-form-item  label="上传项目介绍图片" prop="projectImage" label-width="130">
									<u-upload width="160" height="160" :action="action" :file-list="fileList" @on-success="afterUpload" max-count="5"></u-upload>
										</u-form-item> -->
					<u-form-item label-position="top" label="求职意向" prop="teamIntroduction">
						<u-input type="textarea" border placeholder="请填写求职意向" v-model="model.teamIntroduction" />
					</u-form-item>

					<view class="title" style="margin-top: 30rpx;">
						个人信息
					</view>
					<u-line />
					<u-form-item label="联系方式" prop="phone" label-width="150" label-position="top">
						<u-input border placeholder="请输入联系方式" v-model="model.phone" type="number"></u-input>
					</u-form-item>
					<u-form-item label="邮箱" prop="email" label-width="150" label-position="top">
						<u-input border placeholder="请输入联系邮箱" v-model="model.email" type="text"></u-input>
					</u-form-item>
					<u-form-item label-position="top" label="企业地址" prop="address">
						<u-input type="textarea" border placeholder="请填写详细地址" v-model="model.address" />
					</u-form-item>

					<view class="title" style="margin-top: 30rpx;">
						个人经历
					</view>
					<u-line />
					<u-form-item label="个人经历" prop="phone" label-width="150" label-position="top">
						<u-input border placeholder="请输入个人经历" v-model="model.phone" type="number"></u-input>
					</u-form-item>
				</u-form>

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
					url: '/talentneed/listByCondition',
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
					url: "../businessIndex/businessInside/businessInside?talentNeedId=" + talentNeedId
				});
			},
			/*企业列表*/
			async getTalentList() {
				const res = await this.$myRequest({
					url: '/talentneed/listByDurationDegree',
					method: 'POST',
					header: {
						'content-type': 'application/json'
					},
					data: {
						"degree": this.degree2, //0，1,2,
						"duration": this.publishTime2 //
					},
				});
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

<template>
	<view class="content">
		<view class="wrap">
			<view class="u-tabs-box">
				<u-tabs-swiper activeColor="#1296db" ref="tabs" :list="list" :current="current" @change="tebchange"
					:is-scroll="false" swiperWidth="750" inactive-color="#000000"></u-tabs-swiper>
			</view>
			<swiper class="swiper-box" :current="swiperCurrent" @transition="transition"
				@animationfinish="animationfinish" style="height: 100vh;">
				<!-- 未回复 -->
				<swiper-item class="swiper-item">
					<scroll-view scroll-y style="height: 100%;width: 100%;">
						<u-dropdown>
							<u-dropdown-item v-model="categoryP" title="分类" :options="options1" @change="changepolicy">
							</u-dropdown-item>
						</u-dropdown>
						<!-- 展示所有未回复的公开问题 -->
						<view v-for="(item,i) in questionList" v-if="!item.child" v-model="questionList">

							<uni-list-item direction="column" v-slot:body>
								<view @click="replyQueDesc(item.id,item.content,item.email,item.phone)">
									<!-- 标题 -->
									<template>
										<view class="uni-title title u-line-1">{{item.content}}
										</view>
									</template>
								</view>
							</uni-list-item>
						</view>
					</scroll-view>
				</swiper-item>
				<!-- 已回复 -->
				<swiper-item class="swiper-item">
					<scroll-view scroll-y style="height: 100%;width: 100%;">
						<u-dropdown>
							<u-dropdown-item v-model="categoryP" title="分类" :options="options1" @change="changepolicy">
							</u-dropdown-item>
						</u-dropdown>
						<!-- 展示所有已回复的公开问题 -->
						<view v-for="(item,i) in questionList" v-if="item.child" v-model="questionList">

							<uni-list-item direction="column" v-slot:body>
								<view @click="getQueDesc(item)">
									<!-- 标题 -->
									<template>
										<view class="uni-title title u-line-1">{{item.content}}
										</view>
									</template>
									<!-- 回复 -->
									<template>
										<view class="uni-list-box">
											<view class="content">
												<view class="u-line-2 u-m-b-20 u-m-r-20 u-m-l-20">{{item.child.content}}
												</view>
											</view>
										</view>
									</template>
								</view>
							</uni-list-item>
						</view>

					</scroll-view>
				</swiper-item>
			</swiper>
		</view>

	</view>
</template>

<script>
	export default {
		data() {
			return {
				categoryP: "",
				options1: [],
				questionList: [],
				//questionListTwo: [],
				category: '',
				categoryPA: "",
				stable: 1,
				type: 1,
				options2: [],
				list: [{
						name: '未回复'
					},
					{
						name: '已回复'
					}
				],
				current: 0,
				swiperCurrent: 0,
				tabsHeight: 0,
				dx: 0,


			};
		},
		onLoad() {

			this.getIndex();
			this.getListByCategory()
		},
		methods: {
			/* 获取索引列表 */
			async getIndex() {
				const res = await this.$myRequest({
					url: '/list',
					method:'POST',
					data:{
						indexName:"咨询索引"
					},
					header:{
						'content-type':'application/x-www-form-urlencoded'
					}
				});
				
				
				const data = res.data.data[0].keys
				data.forEach((item,index) =>  {
					const option = {label:item,value:index + 2}
					this.options1.push(option)
				})
				
				this.options1.unshift({label:'全部',value:1})
			},

			/* 根据索引获取咨询列表 */
			async getListByCategory() {
				const res = await this.$myRequest({
					url: '/consultation/list/combine',
					data: {
						category: this.category
					},
					header: {
						'content-type': 'x-www-form-urlencoded'
					}
				});

				let data = res.data.data
				this.questionList = data
				
				

			},
			/* 跳转页 */
			jump(urlTo) {
				uni.navigateTo({
					url: urlTo
				});
			},
			/* 点击进入详情页 */
			getQueDesc(item) {
				let obj = {
					"item": item
				}
				uni.navigateTo({
					url: '/pages/question/questionList/questionDetil',
					success: function(res) {
						res.eventChannel.emit('obj', {item: item})
					}
				});
				// this.$router.push({
				// 	path: '../../question/questionList/questionDetil',
				// 	query: obj
				// })
			},
			/* 回复问题 */
			replyQueDesc(id,content,email,phone) {
				this.$router.push({
					path:'../../question/replyQuestion/replyQuestion',
					query:{
						id:id,
						content:content,
						email:email,
						phone:phone
					}
				})  ;
				
			},


			/* 改变索引 */
			async changepolicy(index) {
			
				if (index != 1) {
					this.category = this.options1[index - 1].label
				} else {
					this.category = ''
				}
				
				this.getListByCategory();
			},


			// tab栏切换
			tebchange(index) {
				this.swiperCurrent = index;
				console.log("切换")
				if (index == 1) {
					this.getListByCategory();
				}
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
			}
		}
	}
</script>



<style lang="scss" scoped>
	.swiper-box {
		flex: 1;
	}

	.swiper-item {
		height: 100%;
	}

	.uni-note {

		position: relative;
		left: 80%;
	}

	.content {
		font-size: 13px;
		color: #adafb3;
	}


	.title {
		font-size: 29rpx;
		position: relative;
		line-height: 1.3;
		padding-left: 25rpx;
		margin-top: 10rpx;
		margin-bottom: 30rpx;
		color: $uni-color-title;

		&:before {
			width: 4px;
			height: 12px;
			border-radius: 100rpx;
			background-color: $uni-color-primary;
			content: '';
			position: absolute;
			left: 6rpx;
			top: 3px;
		}
	}
</style>

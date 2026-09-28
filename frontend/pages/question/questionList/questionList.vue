<template>
	<view class="mainclass">
		<!-- 分类下拉框 -->
		<u-dropdown>
			<u-dropdown-item v-model="categoryP" title="分类" :options="consultIndex" @change="changepolicy">
			</u-dropdown-item>
		</u-dropdown>
		<!-- 咨询列表 -->
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
								<view class="u-line-2 u-m-b-20 u-m-r-20 u-m-l-20">{{item.child.content}}</view>
							</view>
						</view>
					</template>
				</view>
			</uni-list-item>
		</view>
		<qunMixButton @clickOne="show = true" @clickTwo="jump('/pages/question/question')"></qunMixButton>
		<!-- 弹出框 -->
		<u-popup v-model="show" mode="bottom" border-radius="14">
			<view class="u-m-t-80 u-m-b-80">
				<u-button size="default" type="primary" class="u-m-b-40 u-m-l-50 u-m-r-50" plain :ripple="true"
					shape="circle" @click="jump('/pages/detail/authHiTech/authHiTech')">高企认定</u-button>
				<u-button size="default" type="primary" class="u-m-b-40 u-m-l-50 u-m-r-50" plain :ripple="true"
					shape="circle" @click="jump('/pages/detail/rewordHitech/rewordHitech')">政策兑现</u-button>
				<u-button size="default" type="primary" class="u-m-b-40 u-m-l-50 u-m-r-50" plain :ripple="true"
					shape="circle" @click="jump('/pages/detail/service/service')">项目申报</u-button>
				<u-button size="default" type="primary" class="u-m-b-40 u-m-l-50 u-m-r-50" plain :ripple="true"
					shape="circle" @click="jump('/pages/detail/technology/technology')">技术支持</u-button>
				<u-button size="default" type="primary" class="u-m-b-40 u-m-l-50 u-m-r-50" plain :ripple="true"
					shape="circle" @click="jump('/pages/detail/financing/financing')">金融扶持</u-button>
			</view>
		</u-popup>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				show: false,
				categoryP: "",
				consultIndex: [],
				questionList: [],
			};
		},
		onLoad() {
			this.getIndex();
			this.getListByCategory();
		},
		methods: {
			/* 获取索引列表 */
			async getIndex() {
				const res = await this.$myRequest({
					url: '/list',
					method:'POST',
					data:{
						indexName:'咨询索引'
					},
					header:{
						'content-type':'application/x-www-form-urlencoded'
					}
				});
				const keysList = res.data.data[0].keys
				
				keysList.forEach((item,index) => {
					const option = {label:item , id:index + 2}
					this.consultIndex.push(option)
				})
				this.consultIndex.unshift({label:'全部',id:1})		
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
						res.eventChannel.emit('obj', {
							item: item
						})
					}
				});
		
			},
			/* 改变索引 */
			async changepolicy(index) {
				console.log("11")
				console.log(this.options1[index - 1].label)
				if (index != 1) {
					this.category = this.options1[index - 1].label
				} else {
					this.category = ''
				}
				this.getListByCategory();
			},


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

	.mainclass {
		height: 100%;
		padding-bottom: 54px;
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

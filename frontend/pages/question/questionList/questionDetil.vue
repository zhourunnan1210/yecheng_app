<template>
	<view class="mainclass">

		<u-row>
			<!-- 问题 -->
			<u-col class="u-font-39 ">
				{{question.content}}
			</u-col>
		</u-row>
		<u-row v-if="question.child">
			<u-col span="12">
				<view class="title">
					答复
				</view>
				<text decode
					class="u-content-color u-m-r-40 u-m-l-20 u-m-t-80 u-font-28 textbox">{{question.child.content}}
				</text>
			</u-col>
		</u-row>

	</view>
</template>

<script>
	export default {
		data() {
			return {
				question: "",
				business: "",
				contact: ''
			}
		},
		methods: {
		},
		onLoad: function(option) {
			// #ifdef APP-NVUE
			const eventChannel = this.$scope.eventChannel; // 兼容APP-NVUE
			// #endif
			// #ifndef APP-NVUE
			const eventChannel = this.getOpenerEventChannel();
			// #endif
			eventChannel.on('obj', (data)=>{
				this.question = data.item;
			})
			
		}

	}
</script>

<style scoped lang="scss">
	.mainclass {
		background-color: #F2F2F2;
		height: 100%;
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
</style>

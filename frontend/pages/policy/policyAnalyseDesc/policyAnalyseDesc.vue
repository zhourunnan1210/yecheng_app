<template>
	<view class="u-content">
		<view class="u-flex-nowrap">
			<h3>
				{{policy.title}}
			</h3>
			<view class="u-font-13 u-m-t-30 u-tips-color" style="{display: inline; float: right; }">发布时间：{{$u.timeFormat(policy.publishTime, 'yyyy-mm-dd')}}
			</view>
		</view>

		<view class="u-content-color u-m-r-20 u-m-l-20 u-m-t-80 u-font-28 textbox">
			<u-line margin="20px 0"></u-line>
			<text decode> {{policy.introduction}}</text>
			<view v-if="imgList" class="imagebox">

				<image v-for="i in imgList" :src="i" mode='widthFix' lazy-load></image>
			</view>
			<u-line margin="20px 0"></u-line>
			<view v-if="policy.link != ''  " class="u-m-t-30">附件: <u-link :href="policy.addition">点击下载</u-link>
			</view>

		</view>

		<que-button @clicked="clicked()"></que-button>
	</view>


</template>

<script>
	import queButton from '../../../components/queButton/queButton.vue'
	export default {
		components: {
			queButton
		},
		data() {
			return {
				policy: '',
				imgList: []
			}
		},
		methods: {
			clicked(item){
				uni.navigateTo({
					url: '../../question/question'
				});
			}

		}
	}
</script>

<style lang="scss" scoped>
	.u-content {
		padding-bottom: 54px;
		margin: 20rpx;
	}

	.textbox {
		line-height: 2;
		letter-spacing: 2px;
	}

	.imagebox {
		//height: 2800px;
	}

	.imagebox image {

		width: 100%;
		height: 100%;


	}

	.u-content h3 {
		text-align: center;
	}
</style>

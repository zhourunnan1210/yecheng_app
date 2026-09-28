<template>
	<view class="u-content">
		<view class="u-flex-nowrap">
			<h3>
				{{policy.title}}
			</h3>
			<view class="u-font-13 u-m-t-30 u-tips-color" style="{display: inline; float: right; }">发布时间：{{$u.timeFormat(policy.publishTime, 'yyyy-mm-dd')}}	</view>
		</view>
		
		<view class="u-content-color u-m-r-20 u-m-l-20 u-m-t-80 u-font-28 textbox" >
			<u-line margin="20px 0"></u-line>
			<rich-text :nodes="policy.content"></rich-text>
				<u-line margin="20px 0"></u-line>
			<view v-if="policy.addition != null  " class="u-m-t-30">附件: <u-link :href="policy.addition">点击下载</u-link></view>
			
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
				imgList:[]
			}
		},
		methods: {
			clicked(item){
				uni.navigateTo({
					url: '../../question/question'
				});
			}

		},
		onLoad: async function(options) { //option为object类型，会序列化上个页面传递的参数
			let item = options.item
			const res = await this.$myRequest({
				url: '/policy/get/' + item,
				header: {
					'content-type': 'application/x-www-form-urlencoded'
				}
			});
		
			this.policy = res.data.data
		
		}
	}
</script>

<style lang="scss" scoped>
	.u-content {
		margin: 20rpx;
		padding-bottom: 54px;
	}
	.textbox {
		line-height: 2;
		letter-spacing:2px;
	}
	.textbox image {
		 width:340px;
		/*height: 500px; */
	}
	.u-content h3 {
		text-align: center;
	}
</style>

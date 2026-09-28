<template>
	<view class="u-content">
		<view class="u-flex-nowrap">
			<h3>
				{{news.title}}
			</h3>
			<view class="u-font-13 u-m-t-30 u-tips-color" style="{display: inline; float: right; }">发布时间：{{$u.timeFormat(news.publishTime, 'yyyy-mm-dd')}}	</view>
		</view>
		
		<view class="u-content-color u-m-r-20 u-m-l-20 u-m-t-80 u-font-28 textbox" >
			<u-line margin="20px 0"></u-line>
			<rich-text :nodes="news.content"></rich-text>
				<u-line margin="20px 0"></u-line>
			<view v-if="news.link != null  " class="u-m-t-30">原文链接: <u-link :href="news.link">{{news.link}}</u-link></view>
			
		</view>
		
	</view>
	
</template>

<script>
	export default {
		data() {
			return {
				news: {}
			}
		},
		methods: {

		},
		onLoad: async function(options) { //option为object类型，会序列化上个页面传递的参数
			let item = options.item
			const res = await this.$myRequest({
				url: '/news/get/' + item,
				/* data: {
					policyId: item
				}, */
				header: {
					'content-type': 'application/x-www-form-urlencoded'
				}
			});
		
			this.news = res.data.data
		
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

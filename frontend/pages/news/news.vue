<template>
	<!-- 新闻列表 -->
	<view>
	<view v-for="(item,i) in newsList">
		<uni-list-item direction="column" v-slot:body>
			<template>
				<view class="uni-title title" @click="getPolicyDesc(item.id)">{{item.title}}
				</view> 
			</template>
			<template>
				<view class="uni-list-box">
					<view class="uni-content">
						<!-- <view class="uni-title-sub uni-ellipsis-2 u-line-1">{{item.content}}</view> -->
						<view class="uni-note">{{$u.timeFormat(item.publishTime, 'yyyy-mm-dd')}}
						</view>
					</view>
				</view>
			</template>
	
		</uni-list-item>
	</view>
	</view>
	
</template>

<script>
	export default {
	data() {
		return {
			newsList:[]
		}
	},
	onLoad() {
		this.getNews()
	},
	methods:{
		async getNews() {
			const res = await this.$myRequest({
				url: "/news/getlist",
			});
			this.newsList = res.data.data;
		},
	}}
</script>

<style>
	
	.uni-note {
		font-size: 13px;
		color: #adafb3;
		position: relative;
		left: 80%;
	}
</style>

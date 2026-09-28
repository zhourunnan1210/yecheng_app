<template>
	<view class="content">
		<u-sticky offsetTop="0">
			<u-search class="search" bgColor="#fff" height="80" :clearabled="true" :show-action="false" v-model="keywords" @search="search(keywords)"></u-search>
			<u-dropdown class="dropdown">
				<u-dropdown-item v-model="field" title="技术领域" :options="optionsField" @change="choose1"></u-dropdown-item>
				<u-dropdown-item v-model="region" title="所在地区" :options="optionsRegion" @change="choose2"></u-dropdown-item>
				<u-dropdown-item v-model="type" title="类型" :options="optionsType" @change="choose3"></u-dropdown-item>
			</u-dropdown>
		</u-sticky>
		<scroll-view style="height: 76vh;" scroll-y="true" >
			<view class="main">
				<view class="item" @click="jump" v-for="(item,index) in list" :key="index">
					<view class="title">{{item.name}}</view>
					<view class="field">领域：{{item.tag1}}</view>
					<view class="type">类型：{{item.tag2}}</view>				
				</view>
			</view>
		</scroll-view>
	</view>
</template>

<script>
export default {
	data() {
		return {
			keywords: '',
			list:[{name:'南海海洋资源利用国家重点实验室',tag1:'农业',tag2:'全国重点实验室'},
			{name:'海南热带作物研究实验室',tag1:'农业',tag2:'省重点实验室'},
			{name:'网络安全重点实验室',tag1:'互联网+',tag2:'省重点实验室'},
			{name:'南海海洋资源利用国家重点实验室',tag1:'农业',tag2:'全国重点实验室'},
			{name:'南海海洋资源利用国家重点实验室',tag1:'农业',tag2:'全国重点实验室'},
			{name:'南海海洋资源利用国家重点实验室',tag1:'农业',tag2:'全国重点实验室'}],
			temp:[{name:'南海海洋资源利用国家重点实验室',tag1:'农业',tag2:'全国重点实验室'},
			{name:'海南热带作物研究实验室',tag1:'农业',tag2:'省重点实验室'},
			{name:'网络安全重点实验室',tag1:'互联网+',tag2:'省重点实验室'},
			{name:'南海海洋资源利用国家重点实验室',tag1:'农业',tag2:'全国重点实验室'},
			{name:'南海海洋资源利用国家重点实验室',tag1:'农业',tag2:'全国重点实验室'},
			{name:'南海海洋资源利用国家重点实验室',tag1:'农业',tag2:'全国重点实验室'}],
			field: '',
			region: '',
			type: '',
			optionsField:[
				{
					value:0,
					label:'全部'
				},
				{
					value:1,
					label:'互联网+'
				},
				{
					value:2,
					label:'生物医药'
				},
				{
					value:3,
					label:'农业'
				},
				{
					value:4,
					label:'高端智能设备'
				},
				{
					value:5,
					label:'新能源'
				},
				{
					value:6,
					label:'新材料'
				},
				{
					value:7,
					label:'高技术服务'
				},
				{
					value:8,
					label:'资源与环境'
				}
			],
			optionsRegion: [],
			optionsType: [
				{value: 0,label: '全部'},
				{value: 1,label: '全国重点实验室'},
				{value: 2,label: '省重点实验室'}
			]
		}
	},
	methods: {
		jump() {
			uni.navigateTo({
				url: './laboratory'
			})
		},
		search(val){
			this.list=this.list.filter(item=>{
				let name=item.name
				return name.indexOf(val)!==-1
			})
			// console.log(this.list)
		},
		choose1(index) {
			if(index==0) {
				this.list=this.temp
			}else {
				this.field=this.optionsField[index].label
				this.list=this.temp.filter(item=>item.tag1==this.field)
			}
		},
		// 地区筛选暂不可用
		// choose2(index) {
		// 	if(index==0) {
		// 		this.list=this.temp
		// 	}else {
		// 		this.maturity=this.optionsMaturity[index].label
		// 		this.list=this.temp.filter(item=>item.tag3==this.maturity)
		// 	}
		// },
		choose3(index) {
			if(index==0) {
				this.list=this.temp
			}else {
				this.type=this.optionsType[index].label
				this.list=this.temp.filter(item=>item.tag2==this.type)
			}
		}
	}
}
</script>

<style lang='scss' scoped>
.content {
	padding: 10rpx 30rpx;
	background-color: #f3f4f6;
	.search {
		padding: 20rpx 0 10rpx 0;
		background-color: #f3f4f6;
	}
	.dropdown {
		padding: 10rpx 0;
		background-color: #f3f4f6;
	}
	.main {
		background-color: #fff;
		border-radius: 10rpx;
		.item {
			height: 160rpx;
			padding-left: 20rpx;
			border-bottom: 2rpx solid #f3f4f6;
			.title {
				height: 80rpx;
				line-height: 80rpx;
				font-size: 40rpx;
				text-overflow: ellipsis;
				white-space: nowrap;
				overflow: hidden;
			}
			.field,.type {
				height: 40rpx;
			}
		}
		.item:last-child {
			border: none;
		}
	}
}
</style>

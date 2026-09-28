<template>
	<view class="content">
			<u-search class="search" bgColor="#fff" height="80" :clearabled="true" :show-action="false" v-model="keywords" @search="search(keywords)"></u-search>
			<u-dropdown class="dropdown">
				<u-dropdown-item v-model="field" title="技术领域" :options="optionsField" @change="choose1"></u-dropdown-item>
				<u-dropdown-item v-model="progress" title="研发进度" :options="optionsProgress" @change="choose2"></u-dropdown-item>
				<u-dropdown-item v-model="startTime" title="开始时间" :options="optionsStartTime" @change="choose3"></u-dropdown-item>
			</u-dropdown>
		<scroll-view style="height: 80vh;" scroll-y="true" >
			<view class="result">
				<u-row class="item" @click="jumpToDetail" v-for="(item,index) in productList" :key="index">
					<u-col span="3">
						<view class="imgbox">
							<img :src="item.image" alt="">
						</view>
					</u-col>
					<u-col span="6">
						<view class="title">{{item.title}}</view>
						<view class="field">领域：{{item.field}}</view>
						<view class="time">开始时间：{{item.startTime[0]}}</view>
					</u-col>
					<u-col span="3">
						<view class="status">{{Progress[item.progress]}}</view>
					</u-col>
				</u-row>
			</view>
		</scroll-view>
	</view>
</template>

<script>
export default {
	data() {
		return {
			DEFAULT_IMAGE:'static/defaultImage/1.png',
			keywords:'',
			productList:[],
			field: '',
			progress: '',
			startTime: '',
			productField:'全部',
			productStrattime:'全部',
			productProgress:'全部',
			Progress:['全部','正在研发','已有样品','通过小试','通过中试','可以量产','无'],
			optionsStartTime: [
				{value: 0,label:'全部'},
				{value: 1,label:'一个月内'},
				{value: 2,label:'三个月内'},
				{value: 3,label:'六个月内'},
				{value: 4,label:'一年内'}
			],
			optionsField:[
				{	value:0,label:'全部' },
				{	value:1,label:'互联网+' },
				{	value:2,label:'生物医药'},
				{	value:3,label:'农业'},
				{	value:4,label:'高端智能设备'},
				{	value:5,label:'新能源'},
				{	value:6,label:'新材料'},
				{	value:7,label:'高技术服务'},
				{	value:8,label:'资源与环境'}
			],
			optionsProgress: [
				{
					value: 0,
					label: '全部'
				},
				{
					value: 1,
					label: '正在研发'
				},
				{
					value: 2,
					label: '已有样品'
				},
				{
					value: 3,
					label: '通过小试'
				},
				{
					value: 4,
					label: '通过中试'
				},
				{
					value: 5,
					label: '可以量产'
				}
			],
		}
	},
	onLoad(){
		this.getProductList()
	},
	watch:{
		keywords(newval,oldval){
			this.productList=this.productList.filter(item=>{
				return item.title.indexOf(newval)!==-1
			})
			if(newval==''){
				this.getProductList()
			}
		}
	},
	methods:{
		// 根据领域、研发进度、开始时间获取产品列表
		async getProductList() {
			const res = await this.$myRequest({
				url: '/technologyProduct/listByConditions',
				method: 'POST',
				header: {
					'content-type': 'application/json'
				},
				data: {
					"duration": this.productStrattime,
					"field":this.productField,
					"progress":this.productProgress
				}
			});
			this.productList = res.data.data
			this.productList.forEach(item => {
				// if (!item.image) {
					item.image = this.DEFAULT_IMAGE
				// }
				item.progress=parseInt(item.progress)
				// 去掉发布日期的时分秒
				item.startTime=/\d{4}-\d{1,2}-\d{1,2}/g.exec(item.startTime)
			})
			console.log(this.productList)
		},
		jumpToDetail() {
			uni.navigateTo({
				url:'/pages/detail/transform/process/processDetail'
			})
		},
		choose1(index) {
			this.productField=this.optionsField[index].label
			this.getProductList()
		},
		choose2(index) {
			this.productProgress=this.optionsProgress[index].label
			this.getProductList()
			console.log(this.productProgress)
		},
		choose3(index) {
			this.productStrattime=this.optionsStartTime[index].label
			this.getProductList()
		}
	}
}
</script>

<style lang="scss" scoped>
.content {
	// padding: 0 30rpx;
	background-color: #f3f4f6;
	.search {
		padding: 20rpx 30rpx 0 30rpx;
		background-color: #f3f4f6!important;
	}
	.dropdown {
		padding: 0 30rpx;
		background-color: #f3f4f6!important;
	}
	.result {
		background-color: #fff;
		.item {
			border-bottom: 1rpx solid #ccc;
			.imgbox {
				margin-left: 15rpx;
				width: 150rpx;
				height: 150rpx;
				img {
					width: 100%;
					height: 100%;
				}
			}
			.title {
				height: 80rpx;
				line-height: 80rpx;
				font-size: 39rpx;
				color: #333;
				padding-left: 20rpx;
				text-overflow: ellipsis;
				white-space: nowrap;
				overflow: hidden;
			}
			.field,.time {
				padding-left: 20rpx;
				overflow: hidden;
				text-overflow: ellipsis;
				white-space: nowrap;
				color: gray;
			}
			.status {
				font-size: 35rpx;
				color: green;
			}
		}
	}
}
</style>

<template>
	<view class="content">
			<u-sticky offsetTop="0">
				<u-search class="search" bgColor="#fff" height="80" :clearabled="true" :show-action="false" v-model="keywords" @search="search(keywords)"></u-search>
				<u-dropdown class="dropdown">
					<u-dropdown-item v-model="field" title="行业领域" :options="optionsField" @change="changeTN1">
					</u-dropdown-item>
					<u-dropdown-item v-model="publishTime" title="发布时间" :options="optionsPublishTime"
						@change="changeTN2">
					</u-dropdown-item>
				</u-dropdown>
			</u-sticky>
			<scroll-view style="height: 80vh;" scroll-y="true" >
				<view class="main">
					<view class="box" v-for="(item,i) in TNList" @click="getTNDesc(item.technologyNeedId)">
						<u-row>
							<u-col span="4">
								<view class="iconbox">
									<img :src="item.image"></img>
								</view>
							</u-col>
							<u-col span="8">
								<view class="textbox1 u-line-1">{{item.title}}
								</view>
								<view class="notebox1 u-line-1">行业领域：{{item.field }}
								</view>
								<view class="notebox1 u-line-1">
									发布时间：{{$u.timeFormat(item.publishTime, 'yyyy-mm-dd')}}</view>
					
							</u-col>
					
						</u-row>
					</view>
				</view>
			</scroll-view>
		</view>
	</template>
</template>

<script>
export default{
	data(){
		return {
			DEFAULT_IMAGE:'static/defaultImage/1.png',
			publishTime:'',
			field:'',
			keywords:'',
			optionsPublishTime:[],
			optionsField:[],
			TNList:'',
			TNpublishTime: '全部',
			TNfield: '全部',
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
			optionsPublishTime: [
				{
					value:0,
					label:"全部"
				},
				{
					value:1,
					label:"一个月内"
				},
				{
					value:2,
					label:"六个月内"
				},
				{
					value:3,
					label:"一年内"
				},
				{
					value:4,
					label:"一年以上"
				}],
		}
	},
	onLoad(){
		this.getQueListByCategory()
	},
	// 模糊搜索
	watch:{
		keywords(newval,oldval){
			this.TNList=this.TNList.filter(item=>{
				return item.title.indexOf(newval)!==-1
			})
			if(newval==''){
				this.getQueListByCategory()
			}
		}
	},
	methods:{
		//获取科技需求列表
		async getQueListByCategory() {	
			const res = await this.$myRequest({
				url: '/technologyneed/listByCondition',
				method: 'POST',
				data: {
					"duration": this.TNpublishTime,
					"field": this.TNfield
				},
				header: {
					'content-type': 'application/json'
				}
			});
			this.TNList = res.data.data;
			this.TNList.forEach(item => {
				if (!item.image) {
					item.image = this.DEFAULT_IMAGE
				}
			})
		},
		changeTN1(index) {
			this.TNfield = this.optionsField[index].label
			this.getQueListByCategory()
		},
		changeTN2(index) {
			this.TNpublishTime = this.optionsPublishTime[index].label
			this.getQueListByCategory()
			console.log(this.TNpublishTime)
		},
		getTNDesc(item) {
			console.log(item)
			uni.navigateTo({
				// url: '/pages/detail/technology/technologyNeed/technologyNeed?item=' + JSON.stringify(item)
				url: '/pages/detail/transform/demand/demandDetail?item=' + JSON.stringify(item)
			});
		},
	}
}
</script>

<style lang='scss'>
.content {
	background-color: #f3f4f6;
	.search {
		padding: 20rpx 30rpx 0 30rpx;
		background-color: #f3f4f6!important;
	}
	.dropdown {
		padding: 0 30rpx;
		background-color: #f3f4f6!important;
	}
	.box {
		border-bottom: 1px solid;
		border-color: #e6e6e6;
		height: 200rpx;
		background: #FFFFFF;
		.iconbox img {
			margin-left: 40rpx;
			margin-top: 28rpx;
			width: 80px;
			height: 80px;
		}
		.iconbox image {
			margin-left: 40rpx;
			margin-top: 28rpx;
			width: 80px;
			height: 80px;
		}
		.textbox1 {
			margin: 0 30rpx 5rpx 10rpx;
			padding: 10rpx 30rpx 5rpx 10rpx;
			font-weight: 500;
			color: #000000;
			line-height: 2.5;
			font-size: 28rpx;
		}
		.notebox1 {
			padding: 0 20rpx;
			font-size: 12px;
			color: #949494;
			line-height: 2;
		}
		.textbox {
			margin: 0 30rpx 5rpx 10rpx;
			padding: 10rpx 30rpx 5rpx 10rpx;
			font-weight: 500;
			color: #000000;
			line-height: 1.5;
			font-size: 28rpx;
		}
		.notebox {
			padding: 0 20rpx;
			font-size: 12px;
			color: #949494;
			line-height: 1.5;
		}
	}
}
</style>

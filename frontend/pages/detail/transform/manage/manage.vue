<template>
	<view class="content">
		
			<u-search class="search" bgColor="#fff" height="80" :clearabled="true" :show-action="false" v-model="keywords" @search="search(keywords)"></u-search>
			<u-dropdown class="dropdown">
				<u-dropdown-item v-model="field" title="技术领域" :options="optionsField" @change="choose1"></u-dropdown-item>
				<u-dropdown-item v-model="publishtime" title="发布时间" :options="optionsPublishTime" @change="choose2"></u-dropdown-item>
				<u-dropdown-item v-model="maturity" title="成熟度" :options="optionsMaturity" @change="choose3"></u-dropdown-item>
				<u-dropdown-item v-model="level" title="成果水平" :options="optionsLevel" @change="choose4"></u-dropdown-item>
			</u-dropdown>
		
		<scroll-view style="height: 80vh;" scroll-y="true" >
			<view class="main">
				<view class="detail" @click="jumpToDetail(item.technologyAchievementId)" v-for="(item,index) in TAList" :key="index">
					<u-row>
						<u-col span="4">
							<view class="imgbox">
								<img :src="item.image" alt="">
							</view>
						</u-col>
						<u-col span="8">
							<view class="name">{{item.title}}</view>
							<u-tag class="tag" :text="Maturity[item.maturity]" plain size="mini"></u-tag>
							<u-tag class="tag" :text="Level[item.level]" plain size="mini"></u-tag>
							<view class="field">领域：{{item.field}}</view>
							<view class="publishtime">发布于：{{item.publishTime[0]}}</view>
						</u-col>
					</u-row>
				</view>
			</view>
		</scroll-view>
	</view>
</template>

<script>
export default {
	data() {
		return {
			DEFAULT_IMAGE:'static/defaultImage/1.png',
			TAList:[],
			keywords:'',
			field: '',
			publishtime: '',
			maturity: '',
			level: '',
			TAfield:'全部',
			TApublishtime:'全部',
			TAmaturity:'全部',
			TAlevel:'全部',
			Field:['全部','互联网+','生物医药','农业','高端智能设备','新能源','新材料','高技术服务','资源与环境'],
			PublishTime:["全部","一个月内","三个月内","六个月内","一年内"],
			Maturity:['全部','正在研发','已有样品','通过小试','通过中试','可以量产','无'],
			Level:['全部','国际领先','国际先进','国内领先','国内先进','国内一般','未评估'],
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
					label:"三个月内"
				},
				{
					value:3,
					label:"六个月内"
				},
				{
					value:4,
					label:"一年内"
				}],
			optionsMaturity: [
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
				},
				{
					value:6,
					label: '无'
				}
			],
			optionsLevel: [
				{
					value: 0,
					label: '全部'
				},
				{
					value: 1,
					label: '国际领先'
				},
				
				{
					value: 2,
					label: '国际先进'
				},
				{
					value: 3,
					label: '国内领先'
				},
				{
					value: 4,
					label: '国内先进'
				},
				{
					value: 5,
					label: '国内一般'
				},
				{
					value: 6,
					label: '未评估'
				}
			]
		}
	},
	onLoad(){
		this.getTAList()
	},
	// 模糊搜索
	watch:{
		keywords(newval,oldval){
			if(newval==''){
				this.getTAList()
			}
		}
	},
	methods:{
		// 根据发布时间、成熟度、成果水平来获取列表
		async getTAList() {
			const res = await this.$myRequest({
				url: '/technologyAchievement/listByConditions',
				method: 'POST',
				header: {
					'content-type': 'application/json'
				},
				data: {
					"duration": this.TApublishtime,
					"field":this.TAfield,
					"level": this.TAlevel,
					"maturity": this.TAmaturity	
				}
			});
			this.TAList = res.data.data
			this.TAList.forEach(item => {
				if (!item.image) {
					item.image = this.DEFAULT_IMAGE
				}
				if(!item.level){
					item.level=6
				}
				if(!item.maturity){
					item.maturity=6
				}
				// 去掉发布日期的时分秒
				item.publishTime=/\d{4}-\d{1,2}-\d{1,2}/g.exec(item.publishTime)
			})
			console.log(this.TAList)
		},
		jumpToDetail(item) {
			uni.navigateTo({
				url:'/pages/detail/transform/manage/manageDetail?item='+item
			})
		},
		// 搜索功能
		async search(val){
			const res = await this.$myRequest({
				url: '/technologyAchievement/search/'+val,
				method: 'GET',
				header: {
					'content-type': 'application/json'
				}
			});
			this.TAList = res.data.search
			this.TAList.forEach(item => {
				if (!item.image) {
					item.image = this.DEFAULT_IMAGE
				}
				// 去掉发布日期的时分秒
				item.publishTime=/\d{4}-\d{1,2}-\d{1,2}/g.exec(item.publishTime)
			})
			console.log(this.TAList)
		},
		choose1(index) {
			this.TAfield=this.optionsField[index].label
			this.getTAList()
		},
		choose2(index) {
			this.TApublishtime=this.optionsPublishTime[index].label
			this.getTAList()
		},
		choose3(index) {
			this.TAmaturity=this.optionsMaturity[index].label
			this.getTAList()
		},
		choose4(index) {
			this.TAlevel=this.optionsLevel[index].label
			this.getTAList()
		}
	}
}
</script>

<style lang="scss" scoped>
.content {
	// padding: 10rpx 30rpx;
	background-color: #f3f4f6;
	.search {
		padding: 20rpx 30rpx 0 30rpx;
		background-color: #f3f4f6!important;
	}
	.dropdown {
		padding: 0 30rpx;
		background-color: #f3f4f6!important;
	}
	.main {
		background-color: #fff;
		.detail {
			// margin-top: 20rpx;
			height: 200rpx;
			border-bottom: 2rpx solid #f3f4f6;
			.imgbox {
				margin-left: 30rpx;
				width: 150rpx;
				height: 140rpx;
		
				img {
					width: 100%;
					height: 100%;
				}
			}
			.name {
				height: 80rpx;
				line-height: 80rpx;
				font-size: 39rpx;
				color: #333333;
				overflow: hidden;
				text-overflow: ellipsis;
				white-space: nowrap;
			}
			.tag {
				margin-right: 5rpx;
				margin-bottom: 5rpx;
			}
			.field,.publishtime{
				overflow: hidden;
				text-overflow: ellipsis;
				white-space: nowrap;
				color: gray;
			}
		}
	}
}
</style>

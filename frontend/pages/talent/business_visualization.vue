<template>
	<view>
		<!-- <view class="title">
			<!-- <view class="titledot">

			</view>
			<view class="titletext">
				学历占比
			</view>

		</view>
		<view class="charts-box">
		   <qiun-data-charts
		     type="pie"
		     :opts="opts"
		     :chartData="chartData"
		   />
		 </view> --> 
		<view class="title">
			<view class="titledot">

			</view>
			<view class="titletext">
				企业招聘岗位占比
			</view>

		</view>
		<view class="charts-box">
		   <qiun-data-charts
		     type="pie"
		     :opts="opts"
		     :chartData="chartData1"
		   />
		 </view>
		<view class="shuju">
			(数据仅针对于本APP)
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				chartData: {},
				chartData1: {},
			// 	opts: {{
			// 	  color: ["#1890FF","#91CB74","#FAC858","#EE6666","#73C0DE","#3CA272","#FC8452","#9A60B4","#ea7ccc"],
			// 	  padding: [5,5,5,5],
			// 	  extra: {
			// 	    pie: {
			// 	      activeOpacity: 0.5,
			// 	      activeRadius: 10,
			// 	      offsetAngle: 0,
			// 	      labelWidth: 15,
			// 	      border: false,
			// 	      borderWidth: 3,
			// 	      borderColor: "#ffffff"
			// 	    }
			// 	  }
			// 	}

			// }
			}
		},
		onReady() {
		  this.getServerData();
		  this.getServerData1();
		},
		methods: {
			getServerData() {
			  //模拟从服务器获取数据时的延时
			  setTimeout(() => {
			    //模拟服务器返回数据，如果数据格式和标准格式不同，需自行按下面的格式拼接
			    let res = {
			        series: [
			          {
			            data: [{"name":"本科","value":50},{"name":"硕士","value":30},{"name":"博士","value":20},{"name":"其他学历","value":18}]
			          }
			        ]
			      };
			    this.chartData = JSON.parse(JSON.stringify(res));
			  }, 500);
			},
			getServerData1() {
			  //模拟从服务器获取数据时的延时
			  setTimeout(() => {
			    //模拟服务器返回数据，如果数据格式和标准格式不同，需自行按下面的格式拼接
			    let res = {
			        series: [
			          {
			            data: [{"name":"Java后端开发","value":80},{"name":"前端开发","value":60},{"name":"嵌入式开发","value":30},{"name":"Android开发工程师","value":60},{"name":"运维服务","value":10}]
			          }
			        ]
			      };
			    this.chartData1 = JSON.parse(JSON.stringify(res));
			  }, 500);
			}
	},
	}
</script>

<style lang="scss" scoped>
	.title {
		display: flex;
		flex-direction: row !important;
		flex-wrap: nowrap;
		align-items: center;
		height: 40px;
		margin-bottom: 20px;
	}

	.titletext {
		font-size: 18px;
		color: #666;
		margin-left: 10px;
		line-height: 22px;
		height: 22px;
		font-weight: 700;
	}

	.titledot {
		border-radius: 10px;
		background-color: #409eff;
		width: 5px;
		height: 16px;
		margin-left: 8px;
	}


	.charts-box {
		width: 100%;
		height: 400px;

	}

	.shuju {
		display: float;
		float: right;
		margin: 10px;
	}
</style>

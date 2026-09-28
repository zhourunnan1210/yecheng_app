<template>
 <view class="mainbox">

	<view class="imagebox">
			<u-swiper class="swiper"
						:list="list1"
						@change="change"
						@click="click"
				></u-swiper>

	</view>
	
		<view class="grid">
		  <u-grid :col="2">
		   <u-grid-item @click="clickitem" index="/talent/talent_examine">
		   			<image src="../../static/font/jinrong.png" class="icon"></image>
		   			<view class="grid-text">人才简历审核</view>
		    </u-grid-item>
		   <u-grid-item @click="clickitem" index="/talent/business_examine">
		   			<image src="../../static/font/jinrong.png" class="icon"></image>
		   			<view class="grid-text">企业招聘审核</view>
		    </u-grid-item>
		  </u-grid>
		</view>
		<view class="box">
			<view class="header">
				<text class="title">人才数据统计</text>
				<veiw class="subTitle" @click="jumpToManage">查看更多</veiw>
			</view>
			<view class="main">
				<view class="charts-box">
				   <qiun-data-charts
				     type="pie"
				     :opts="opts"
				     :chartData="chartData"
				   />
				 </view>
			</view>
		</view>
		<view class="box">
			<view class="header">
				<text class="title">企业数据统计</text>
				<veiw class="subTitle" @click="jumpToManage1">查看更多</veiw>
			</view>
			<view class="main">
				<view class="charts-box">
				   <qiun-data-charts
				     type="pie"
				     :opts="opts"
				     :chartData="chartData"
				   />
				 </view>
			</view>
		</view> 
		<u-tabbar :list="tabbar" active-color="#1296db" height="110"></u-tabbar>
 </view>
</template>
<script>
	import global from '../../store/global.js'
  import uCharts from '@/components/u-charts/u-charts.js';
  var _self;
  var canvaLineA=null;
	export default {

		data() {
			return{
				tabbar: [],
				list1: [
				                    // 'https://cdn.uviewui.com/uview/swiper/swiper1.png',
				                    // 'https://cdn.uviewui.com/uview/swiper/swiper2.png',
				                    // 'https://cdn.uviewui.com/uview/swiper/swiper3.png',
									"/static/pic1.png",
									"/static/pic2.png",
									"/static/pic3.png",

				                ],
        cWidth:'',
        cHeight:'',
        pixelRatio:1,
				questionList:[],

        chartData: {},
        //您可以通过修改 config-ucharts.js 文件中下标为 ['pie'] 的节点来配置全局默认参数，如都是默认参数，此处可以不传 opts 。实际应用过程中 opts 只需传入与全局默认参数中不一致的【某一个属性】即可实现同类型的图表显示不同的样式，达到页面简洁的需求。
        opts: {
          color: ["#1890FF","#91CB74","#FAC858","#EE6666","#73C0DE","#3CA272","#FC8452","#9A60B4","#ea7ccc"],
          padding: [5,5,5,5],
          extra: {
            pie: {
              activeOpacity: 0.5,
              activeRadius: 10,
              offsetAngle: 0,
              labelWidth: 15,
              border: false,
              borderWidth: 3,
              borderColor: "#FFFFFF"
            }
          }
        }
			}

		},
    onReady() {
      this.getServerData2();
      this.getServerData();
    },
		onLoad() {
			this.tabbar = global.tabbar;
      _self = this;
      // uni.upx2px(750) 这是uni-app自带的自适应，以750的尺寸为基准。动态变化
      this.cWidth=uni.upx2px(750);
      this.cHeight=uni.upx2px(500);
		},
		methods: {
      getServerData(){
      	setTimeout(() => {
      		this.chartData = {
      			categories: ['2016', '2017', '2018', '2019', '2020', '2021'],
      			series: [{
      				name: "成交量",
      				data: [35, 32, 36, 34, 38, 30]
      			}]
      		}
      		_self.showLineA("canvasLineA", this.chartData);
      	}, 800)
      },
      showLineA(canvasId,chartData){
      	canvaLineA=new uCharts({
      		$this:_self,
      		canvasId: canvasId,
      		// 图标类型
      		type: 'line',
      		fontSize:11,
      		legend:{show:true},
      		dataLabel:false,
      		dataPointShape:true,
      		background:'#FFFFFF',
      		pixelRatio:_self.pixelRatio,
      		categories: chartData.categories,
      		series: chartData.series,
      		animation: true,
      		context:uni.createCanvasContext(canvasId, _self), // 这里很重要
      		// x轴显示的内容
      		xAxis: {
      			type:'grid',
      			gridColor:'#CCCCCC',
      			gridType:'dash',
      			dashLength:8
      		},
      		// y轴显示的内容
      		yAxis: {
      			gridType:'dash',
      			gridColor:'#CCCCCC',
      			dashLength:8,
      			splitNumber:5,
      			min:10,
      			max:180,
      			format:(val)=>{return val.toFixed(0)+'元'}
      		},
      		width: _self.cWidth*_self.pixelRatio,
      		height: _self.cHeight*_self.pixelRatio,
      		extra: {
      			line:{
      				type: 'straight'
      			}
      		}
      	});

      },
      // 点击图表显示的内容
      touchLineA(e) {
      	// 使用声明的变量canvaLineA
      	canvaLineA.showToolTip(e, {
      		format: function (item, category) {
      			return category + ' ' + item.name + ':' + item.data
      		}
      	});
      },
			async getQueListByCategory() {

				const res = await this.$myRequest({
					url: '/consultation/list/combine',
					data: {
						category: '金融政策咨询'
					},
					header: {
						'content-type': 'x-www-form-urlencoded'
					}
				});

				let data = res.data.data
				this.questionList = data
			},

			/* 点击进入详情页 */
			getQueDesc(item) {
				let obj = {
					"item": item
				}
				uni.navigateTo({
					url: '/pages/question/questionList/questionDetil',
					success: function(res) {
						res.eventChannel.emit('obj', {
							item: item
						})
					}
				});
				// this.$router.push({
				// 	path: '/pages/question/questionList/questionDetil',
				// 	query: obj
				// })
			},
			jumpToManage() {
				uni.navigateTo({
					url: '/pages/talent/talent_visualization'
				});
			},
			jumpToManage1() {
				uni.navigateTo({
					url: '/pages/talent/business_visualization'
				});
			},
			jumpToDemand() {
				uni.navigateTo({
					url: '/pages/finance/financingProduct'
				});
			},

			clickitem2(index) {
				uni.navigateTo({
					url: "/pages" + index,

				});
			},

			clickitem(index) {
				uni.navigateTo({
					url: "/pages" + index,
				});
			},

      getServerData2() {
        //模拟从服务器获取数据时的延时
        setTimeout(() => {
          //模拟服务器返回数据，如果数据格式和标准格式不同，需自行按下面的格式拼接
          let res = {
              series: [
                {
                  data: [{"name":"Java后端开发","value":50},{"name":"前端开发","value":30},{"name":"嵌入式开发","value":20},{"name":"Android开发工程师","value":18},{"name":"运维服务","value":8}]
                }
              ]
            };
          this.chartData = JSON.parse(JSON.stringify(res));
        }, 500);
      },
		}
	}


</script>
<style lang="scss" scoped>
	
	.mainbox{
		height: 100%;
		background-color: #E9E9EB;
		padding: 20rpx,30rpx;
			.grid{
				// margin-bottom: 20rpx;
				// padding-bottom: 10rpx;
				margin-top: 25rpx;
				margin: 15rpx;
			}
			.swiper{
				padding: 20rpx;
			}
			.grid-text {
				font-size: 28rpx;
				margin-top: 4rpx;
				// color: $u-type-info;
				color:$uni-color-title;
			}
			.icon {
			  height: 65rpx;
			  width: 65rpx;
			}
			.title{
				font-size:38rpx ;
			}
			.box {
				height: 84%;
			}
			.imagebox{
				// background-color: #999999;
				width: 100%;
				height: 300rpx;
			}
			.content{
				font-size: 15rpx;
				color: #ADAFB3;
			}
			.box {
				margin-top: 30rpx;
				margin-left:15rpx;
				margin-right: 15rpx;
				background-color: #fff;
				border-radius: 15rpx;
				.header {
					height: 80rpx;
					line-height: 80rpx;
					border-bottom: 1rpx solid #ccc;
					.title {
						margin-left: 20rpx;
						font-size: 35rpx;
					}
					.subTitle {
						font-size: 30rpx;
						color: #c4c6c9;
						margin-left: 370rpx;
					}
				}
				.main {
					margin-bottom: 20rpx;
				}
			}
}	
	
</style>
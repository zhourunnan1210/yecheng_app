<template>
	<view>
		<view class="title">
			<view class="titledot">

			</view>
			<view class="titletext">
				技术领域
			</view>

		</view>
		<view class="charts-box">
			<qiun-data-charts type="ring" :chartData="this.chartData"     />
		</view>
		<view class="title">
			<view class="titledot">

			</view>
			<view class="titletext">
				企业规模
			</view>

		</view>
		<view class="charts-box">
			<qiun-data-charts type="ring" :chartData="this.chartData1"  />
		</view>
		<view class="shuju">
			(数据来源：火炬中心)
		</view>
	</view>
</template>

<script>
	import uCharts from '../../components/u-charts/u-charts.js'
	export default {
		data() {
			return {
				chartData: {},
				chartData1: {}
			}
		},
		methods: {
			initData() {
				let opt = {
						"series": [{
							"data": [{
									"name": "电子信息",
									"value": 385
								},
								{
									"name": "高技术服务",
									"value": 177
								},
								{
									"name": "先进制造与自动化",
									"value": 28
								},
								{
									"name": "航空航天",
									"value": 2
								},
								{
									"name": "生物与新医药",
									"value": 164
								},
								{
									"name": "新材料",
									"value": 37
								},
								{
									"name": "新能源与节能",
									"value": 26
								},
								{
									"name": "资源与环境",
									"value": 56
								}
							]
						}]
					},
					opt1 = {
						"series": [{
							"data": [{
									"name": "销售收入小于2000万元（含）",
									"value": 618
								},
								{
									"name": "2000万元以上 ~ 5000万元（含）",
									"value": 112
								},
								{
									"name": "5000万元以上 ~ 1亿元（含）",
									"value": 45
								},
								{
									"name": "1亿元以上 ~ 2亿元（含）",
									"value": 44
								},
								{
									"name": "2亿元以上 ~ 4亿元（含）",
									"value": 14
								},
								{
									"name": "4亿元以上",
									"value": 33
								}
							]
						}]
					}
				setTimeout(() => {
					this.chartData = JSON.parse(JSON.stringify(opt))
					this.chartData1 = JSON.parse(JSON.stringify(opt1))
				}, 1200);
			}
		},
		onLoad() {
			this.initData()
		}
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

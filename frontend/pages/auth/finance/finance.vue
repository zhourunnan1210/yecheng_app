<template>
	<view class="page">
		
		<view class="popup" v-if="showC">
			<view class="popup-info">
				<view><button @tap="album">本地相册</button></view>
				<view><button @tap="camera">相机拍照</button></view>
				<view><button @tap="cancel">取消</button></view>
			</view>
		</view>
			
		<!-- <view class="shape1" style="margin-top: 20upx;background-color: #FFFFFF;height: 180upx;">
			<view class="shape">
				<image class="icon" src="../../../static/circle1.png"></image>
				<text class="textShape">选择认证类型</text>
			</view>
			<text style="font-size: 30px;">></text>
			<view class="shape"> 
				<image class="icon" src="../../../static/circle2.png"></image>
				<text class="textShape">填写认证信息</text>
			</view>
			<text style="font-size: 30px;">></text>
			<view class="shape">
				<image class="icon" src="../../../static/circle3.png"></image>
				<text class="textShape">审核认证信息</text>
			</view>
			<text style="font-size: 30px;">></text>
			<view class="shape">
				<image class="icon" src="../../../static/circle3.png"></image>
				<text class="textShape">认证结果</text>
			</view>
		</view> -->
		<!-- <view class="container" style="background-color: #FFFFFF;height: 90upx;margin-top: 20upx;">
			<input type="idcard" style="width:200px;margin-left: 20upx;" placeholder="统一社会信用代码/法人代码"/>
			<button class=".shape1" style="background-color: #007AFF;margin-right: 20upx;height: 70upx;">
				查询
			</button>
		</view> -->
		<!-- <u-toast ref="uToast" /> -->
		<!-- <u-form :model="model" :rules="rules" ref="uForm"> -->
			<view class="title">
				填写认证信息
			</view>
			<u-line />
			<!-- </u-form> -->
		<view style="margin-top: 20upx;"></view>
		<!-- 列表 -->
		<scroll-view class="scrollItem">
		  
				<view class="viewItem">
					<text style="margin-left: 20upx;">{{viewArray[0].title}}</text>
					<view style="text-align: right;display: inline-block">
						<input id="value" @input="getName" style="margin-right: 20upx;" v-model="name" 
						   :placeholder="viewArray[0].statement" />
					</view>
				</view>
				<hr style='border:0.6upx inset #FfFfF8;'>
				<view class="viewItem">
					<text style="margin-left: 20upx;">{{viewArray[1].title}}</text>
					<view style="text-align: right;display: inline-block">
						<input @input="getCorporate" style="margin-right: 20upx;" v-model="legalPersonName" 
						   :placeholder="viewArray[1].statement" />
					</view>
				</view>
				<hr style='border:0.6upx inset #FfFfF8;'>
				<view class="viewItem">
					<text style="margin-left: 20upx;">{{viewArray[3].title}}</text>
					<view style="text-align: right;display: inline-block">
						<view class="content">
						     <pickerAddress @change="change">
								 <input disabled="true" style="margin-right: 20upx;" v-model="briefAddress"
								    :placeholder="viewArray[3].statement" /> 
							 </pickerAddress>
						 </view>
						<!-- <input @input="getValue" style="margin-right: 20upx;" v-model="location" 
						  :value="location" :placeholder="viewArray[3].statement" /> -->
					</view>
				</view>
				<hr style='border:0.6upx inset #FfFfF8;'>
				<view class="viewItem">
					<text style="margin-left: 20upx;">{{viewArray[4].title}}</text>
					<view style="text-align: right;display: inline-block">
						<input @input="getAddress" style="margin-right: 20upx;" v-model="detailedAddress" 
						   :placeholder="viewArray[4].statement" />
					</view>
				</view>
				<hr style='border:0.6upx inset #FfFfF8;'>
				<view class="viewItem">
					<text style="margin-left: 20upx;">{{viewArray[5].title}}</text>
					<view style="text-align: right;display: inline-block">
						<input @input="getManegeScope" style="margin-right: 20upx;" v-model="businessScope" 
						   :placeholder="viewArray[5].statement" />
					</view>
				</view>
				<hr style='border:0.6upx inset #FfFfF8;'>
				<view class="viewItem">
					<text style="margin-left: 20upx;">{{viewArray[6].title}}</text>
					<view style="text-align: right;display: inline-block">
						<input @input="getIntroduction" style="margin-right: 20upx;" v-model="briefIntroduction" 
						   :placeholder="viewArray[6].statement" />
					</view>
				</view>
				<hr style='border:0.6upx inset #FfFfF8;'>
				<view class="viewItem">
					<text style="margin-left: 20upx;">{{viewArray[7].title}}</text>
					<view style="text-align: right;display: inline-block">
						<input @tap="date()" disabled="true" style="margin-right: 20upx;" v-model="establishmentDay" 
						   :placeholder="viewArray[7].statement" />
					</view>
				</view>
				<hr style='border:0.6upx inset #FfFfF8;'>
				<view class="viewItem">
					<text style="margin-left: 20upx;">{{viewArray[8].title}}</text>
					<view style="text-align: right;display: inline-block">
						<input @tap="date1()" disabled="true" style="margin-right: 20upx;" v-model="sanctionDay" 
						   :placeholder="viewArray[8].statement" />
					</view>
				</view>
				<hr style='border:0.6upx inset #FfFfF8;'>
				<view class="viewItem">
					<text style="margin-left: 20upx;">{{viewArray[9].title}}</text>
					<view style="text-align: right;display: inline-block">
						<input @input="getWebsite" style="margin-right: 20upx;" v-model="websites" 
						   :placeholder="viewArray[9].statement" />
					</view>
				</view>
				<hr style='border:0.6upx inset #FfFfF8;'>
				<view class="viewItem">
					<text style="margin-left: 20upx;">{{viewArray[10].title}}</text>
					<view style="text-align: right;display: inline-block">
						<input @input="getEmail" style="margin-right: 20upx;" v-model="email" 
						   :placeholder="viewArray[10].statement" />
					</view>
				</view>
				<hr style='border:0.6upx inset #FfFfF8;'>
				<view class="viewItem">
					<text style="margin-left: 20upx;">{{viewArray[11].title}}</text>
					<view style="text-align: right;display: inline-block">
						<input @input="getCapital" style="margin-right: 20upx;" v-model="registeredCapital" 
						   :placeholder="viewArray[11].statement" />
					</view>
				</view>
				<hr style='border:0.6upx inset #FfFfF8;'>
				<view class="viewItem">
					<text style="margin-left: 20upx;">{{viewArray[12].title}}</text>
					<view style="text-align: right;display: inline-block">
						<input @input="getCode" style="margin-right: 20upx;" v-model="socialCreditCode" 
						   :placeholder="viewArray[12].statement" />
					</view>
				</view>
				<hr style='border:0.6upx inset #FfFfF8;'>
				<view class="viewItem">
					<text style="margin-left: 20upx;">{{viewArray[13].title}}</text>
					<view style="text-align: right;display: inline-block">
						<input @input="getRegOffice" style="margin-right: 20upx;" v-model="registrationAuthority" 
						   :placeholder="viewArray[13].statement" />
					</view>
				</view>
				<hr style='border:0.6upx inset #FfFfF8;'>
				<view class="viewItem">
					<text style="margin-left: 20upx;">{{viewArray[14].title}}</text>
					<view style="text-align: right;display: inline-block">
						<input @click="date2()" disabled="true" style="margin-right: 20upx;" v-model="timeLimit" 
						   :placeholder="viewArray[14].statement" />
					</view>
				</view>
				<hr style='border:0.6upx inset #FfFfF8;'>
				<view class="viewItem">
					<text style="margin-left: 20upx;">{{viewArray[15].title}}</text>
					<view style="text-align: right;display: inline-block">
						<input @input="getTelephone" style="margin-right: 20upx;" v-model="fixedLineTelephone" 
						   :placeholder="viewArray[15].statement" />
					</view>
				</view>
				<hr style='border:0.6upx inset #FfFfF8;'>
				<view class="container" style="height: 180upx;background-color: #FFFFFF;" 
						@click="tapPopup">
					<text style="margin-left: 20upx;">{{viewArray[16].title}}</text>
					
					<view v-for="item in value1" style="display: inline-block;margin-right: 145upx;" >
						<image class="icon" :src="item"></image>
					</view>
					
				</view>
				<hr style='border:0.6upx inset #FfFfF8;'>
				<view class="container" style="height: 180upx;background-color: #FFFFFF;" @click="tapPopup1">
					<text style="margin-left: 20upx;">{{viewArray[17].title}}</text>
					<view style="width: 400upx;white-space: nowrap;
									display: flex; flex-direction:row;">
					<scroll-view scroll-x="true" style="width: 400upx;">
					<view style="display: flex;flex-direction: row;justify-content: center;">
					<view v-for="item in value2" style="display: inline-block ">
						<image class="icon" :src="item"></image>
					</view>
					</view>
					</scroll-view>
					</view>
				</view>
				<hr style='border:0.6upx inset #FfFfF8;'>
				<view class="viewItem">
					<text style="margin-left: 20upx;">{{viewArray[18].title}}</text>
					<view style="text-align: right;display: inline-block">
						<input @input="getUserId" style="margin-right: 20upx;" v-model="userId" 
						   :placeholder="viewArray[18].statement" />
					</view>
				</view>
				<hr style='border:0.6upx inset #FfFfF8;'>
				
				<view class="viewItem" style="margin-top: 20upx;">
					<text style="margin-left: 20upx;">{{viewArray[19].title}}</text>
					<view style="text-align: right;display: inline-block">
						<picker @click="getTypeOfInvestField" @change="bindPickerChange" :range="typeOfInvestField">
						<input @input="getInvestField" disabled="ture" style="margin-right: 20upx;" v-model="industryField" 
						   :placeholder="viewArray[19].statement" />
						</picker>
					</view>
				</view>
				<hr style='border:0.6upx inset #FfFfF8;'>
				<view class="viewItem">
					<text style="margin-left: 20upx;">{{viewArray[20].title}}</text>
					<view style="text-align: right;display: inline-block">
						<input @input="getInvestIntroduction" style="margin-right: 20upx;" v-model="investDescription" 
						   :placeholder="viewArray[20].statement" />
					</view>
				</view>
				<hr style='border:0.6upx inset #FfFfF8;'>
				<view class="viewItem">
					<text style="margin-left: 20upx;">{{viewArray[21].title}}</text>
					
					<view style="text-align: right;display: inline-block">
						<input @input="getInvestMethod" style="margin-right: 20upx;" v-model="investWay" 
						   :placeholder="viewArray[21].statement" />
					</view>
					
				</view>
				<hr style='border:0.6upx inset #FfFfF8;'>
				<view class="viewItem">
					<text style="margin-left: 20upx;">{{viewArray[22].title}}</text>
					<view style="text-align: right;display: inline-block">
						<picker @click="getTypeOfInvestMoney" @change="bindPickerChange1" :range="typeOfInvestMoney">
						<input @input="getInvestMoney" disabled="ture" style="margin-right: 20upx;" v-model="investingMoney" 
						   :placeholder="viewArray[22].statement" />
						</picker>
					</view>
				</view>
				<hr style='border:0.6upx inset #FfFfF8;'>
				
				<view class="viewItem">
					<text style="margin-left: 20upx;">{{viewArray[23].title}}</text>
					
					<view class="uni-form-item uni-column" style="text-align: right;display: inline-block">
						<!-- <picker @change="bindPickerChange" :range="array">
							</picker>  -->
							<input @input="getInvestType" style="margin-right: 20upx;" v-model="investType" 
							   :placeholder="viewArray[23].statement" />
						
					</view>
				
				</view>
				<hr style='border:0.6upx inset #FfFfF8;'>
				<view class="viewItem">
					<text style="margin-left: 20upx;">{{viewArray[24].title}}</text>
					<view style="text-align: right;display: inline-block">
						<input @input="getSuccessCase" style="margin-right: 20upx;" v-model="successCase" 
						   :placeholder="viewArray[24].statement" />
					</view>
				</view>
				<hr style='border:0.6upx inset #FfFfF8;'>
				
				
				<view class="viewItem" style="margin-top: 20upx;">
					<text style="margin-left: 20upx;">{{viewArray[25].title}}</text>
					<view style="text-align: right;display: inline-block">
						<input @input="getContactName" style="margin-right: 20upx;" v-model="contactName" 
						   :placeholder="viewArray[25].statement" />
					</view>
				</view>
				<hr style='border:0.6upx inset #FfFfF8;'>
				<view class="viewItem">
					<text style="margin-left: 20upx;">{{viewArray[26].title}}</text>
					<view style="text-align: right;display: inline-block">
						<input @input="getContactPhone" style="margin-right: 20upx;" v-model="contactPhone" 
						   :placeholder="viewArray[26].statement" />
					</view>
				</view>
				<hr style='border:0.6upx inset #FfFfF8;'>
				<view class="viewItem">
					<text style="margin-left: 20upx;">{{viewArray[27].title}}</text>
					<view style="text-align: right;display: inline-block">
						<input @input="getContactPosition" style="margin-right: 20upx;" v-model="contactCompany" 
						  :placeholder="viewArray[27].statement" />
					</view>
				</view>
				<hr style='border:0.6upx inset #FfFfF8;'>
				<view class="viewItem">
					<text style="margin-left: 20upx;">{{viewArray[28].title}}</text>
					<view style="text-align: right;display: inline-block">
						<input @input="getContactEmail" style="margin-right: 20upx;" v-model="contactEmail" 
						   :placeholder="viewArray[28].statement" />
					</view>
				</view>
				<hr style='border:0.6upx inset #FfFfF8;'>
				<view class="viewItem">
					<text style="margin-left: 20upx;">{{viewArray[29].title}}</text>
					<view style="text-align: right;display: inline-block">
						<input @input="getContactAddress" style="margin-right: 20upx;" v-model="contactAddress" 
						   :placeholder="viewArray[29].statement" />
					</view>
				</view>
				<hr style='border:0.6upx inset #FfFfF8;'>
				
			        
	    </scroll-view>
		<!-- 下一步按钮 -->

		<view @click="postData" class="container1">
			<hr style='border:0.6upx inset #8F8F94;'>
			<view class="shape2">
				<text style="font-weight: 700">提交</text>
			</view>
			<!-- <u-button @click="submit" type="primary" :ripple="true">提交</u-button> -->
		</view>
	
		<!-- 日期选择器 -->
		<uni-popup ref="wenzi" type="bottom" :maskClick=false>
			
			<view class="date-select">
				<view style="display: flex;height: 150upx;justify-content: space-around;
				flex-direction: row; align-items: center;">
					<view class="btn-left" @tap="concel">
						取消
					</view>
					<view class="btn-right" @tap="confirm">
						确定
					</view>
				</view>
				<picker-view class="picker-view" v-if="visible" :indicator-style="indicatorStyle" :value="value" @change="bindChange">
					<picker-view-column>
						<view class="item" v-for="(item,index) in years" :key="index">{{item}}年</view>
					</picker-view-column>
					<picker-view-column>
						<view class="item" v-for="(item,index) in months" :key="index">{{item}}月</view>
					</picker-view-column>
					<picker-view-column>
						<view class="item" v-for="(item,index) in days" :key="index">{{item}}日</view>
					</picker-view-column>
				</picker-view>
			</view>
		
		</uni-popup>
		
	</view>
</template>

<script>
	import pickerAddress from '../../../components/pickerAddress.vue/pickerAddress.vue'
	export default {
		components:{
			pickerAddress
		},
		data() {
			
			const date = new Date()
			const years = []
			const year = date.getFullYear()
			const months = []
			const month = date.getMonth() + 1
			const days = []
			const day = date.getDate()
			
			for (let i = 2020; i <= date.getFullYear(); i++) {
				years.push(i)
			}
			
			for (let i = 1; i <= 12; i++) {
				months.push(i)
			}
			
			for (let i = 1; i <= 31; i++) {
				days.push(i)
			}
			
			return {
		
				countFine:0,
				typeOfInvestField:[],
				typeOfInvestMoney:[],
				//array:['有效期高企','培育库入库企业','当年申报企业'],
				index:0,
				
				panduan:0,
				title: 'picker-view',
				years,
				year,
				months,
				month,
				days,
				day,
				value: [0, month - 1, day - 1],
				/**
				 * 解决动态设置indicator-style不生效的问题
				 */
				visible: true,
				indicatorStyle: `height: ${Math.round(uni.getSystemInfoSync().screenWidth/(750/100))}px;`,
				nian:'',
				yue:'',
				ri:'',
	
				showC:false,
				value1:[
					"../../static/template.png"
					],
				value2:[
					"../../static/template.png"
					],
				
				
				
				name:"",legalPersonName:"" ,type:"",businessScope:"",briefIntroduction:"",
				sanctionDay:"",establishmentDay:"",websites:"" ,email:"",registeredCapital:"" ,briefAddress:"", 
				detailedAddress:"",socialCreditCode:"" ,fixedLineTelephone:"",registrationAuthority:"", timeLimit:"",imageUrl:"",examineImage:"",userId:"",
				 contactName:"",contactPhone:"",contactCompany:"",contactEmail:"",contactAddress:"",
				 industryField: "",investDescription: "",investWay: "",investingMoney: "",investType: "",
				 successCase:"",
				// name:"",corporate:"" ,type:"",manegeScope:"",introduction:"",
				// foundDate:"",manegeDeadline:"",website:"" ,email:"",capital:"" ,location:"", 
				// address:"",code:"" ,telephone:"",regOffice:"", examineDate:"",imageUrl:"",examineImage:"",userId:"",
				//  contactName:"",phone:"",position:"",contactEmail:"",contactAddress:"",
				viewArray:[
					{title:"单位名称*",statement:"请填写单位名称"},
					{title:"法人*",statement:"请填写法人"},
					{title:"类型",statement:"请填写类型"},
					{title:"省市区*",statement:"请选择省市区 >"},
					{title:"详细地址*",statement:"详细地址"},
					{title:"经营范围*",statement:"请填写经营范围"},
					{title:"简介",statement:"请填写简介"},
					{title:"企业成立日期",statement:"请选择企业成立日期 >"},
					{title:"企业经营限期",statement:"请选择企业经营限期 >"},
					{title:"金融机构网站",statement:"请填写网站"},
					{title:"邮箱",statement:"请填写邮箱"},
					{title:"注册资本",statement:"请填写注册资本"},
					{title:"统一社会信用代码*",statement:"请填写统一社会信用代码"},
					{title:"登记机关*",statement:"请填写登记机关"},
					{title:"核准日期",statement:"请填写核准日期"},
					{title:"固定电话*",statement:"请填写固定电话"},
					{title:"金融机构图片*(最多一张)",statement:"请上传图片"},
					{title:"审核所需图片资料*(最多5张)",statement:"请上传审核所需图片资料"},
					{title:"用户账号(本应用)",statement:"(本应用账号)"},
					
					{title:"投资领域*",statement:"请填写投资领域"},
					{title:"投资说明",statement:"请填写投资说明"},
					{title:"投资方式*",statement:"请填写投资方式"},
					{title:"投资金额*",statement:"请填写投资金额"},
					{title:"投资类型*",statement:"请填写投资类型"},
					{title:"投资成功案例",statement:"请填写投资成功案例"},
					
					{title:"联系人*",statement:"请填写联系人"},
					{title:"联系人手机*",statement:"请填写联系人手机"},
					{title:"联系人单位*",statement:"联系人单位"},
					{title:"联系人邮箱*",statement:"请填写联系人邮箱"},
					{title:"联系人地址*",statement:"请填写联系人地址"}
				]	
			};
			
		},
		methods: {
			submit(){
				uni.showToast({
					title: '提交成功'
				})
			},
			
			getName:function(e){
				this.name = e.target.value;
			},
			getCorporate:function(e){
				this.corporate = e.target.value;
			},
			getAddress:function(e){
				this.address = e.target.value;
			},
			getManegeScope:function(e){
				this.manegeScope = e.target.value;
			},
			getIntroduction:function(e){
				this.introduction = e.target.value;
			},
			getWebsite:function(e){
				this.website = e.target.value;
			},
			getEmail:function(e){
				this.email = e.target.value;
			},
			getTelephone:function(e){
				this.telephone = e.target.value;
			},
			getCapital:function(e){
				this.capital = e.target.value;
			},
			getCode:function(e){
				this.code = e.target.value;
			},
			getRegOffice:function(e){
				this.regOffice = e.target.value;
			},
			getUserId:function(e){
				this.userId = e.target.value;
			},
			
			getInvestField:function(e){
				this.investField = e.target.value;
			},
			
			getInvestIntroduction:function(e){
				this.InvestIntroduction = e.target.value;
			},
			
			getUserId:function(e){
				this.InvestMethod = e.target.value;
			},
			
			getInvestMoney:function(e){
				this.InvestMoney = e.target.value;
			},
			
			getInvestType:function(e){
				this.InvestType = e.target.value;
			},
			
			getSuccessCase:function(e){
				this.successCase = e.target.value;
			},
			getInvestMethod:function(e){
				this.investMethod = e.target.value;
			},
			getContactName:function(e){
				this.contactName = e.target.value;
			},
			getContactPhone:function(e){
				this.contactPhone = e.target.value;
			},
			getContactPosition:function(e){
				this.contactPosition = e.target.value;
			},
			getContactEmail:function(e){
				this.contactEmail = e.target.value;
			},
			getContactAddress:function(e){
				this.contactAddress = e.target.value;
			},
			
			tapPopup() {
				this.showC = true;
			},
			tapPopup1() {
				this.countFine = 1;
				this.showC = true;
			},
			album() {
				if(this.countFine==0)
				uni.chooseImage({
				    count: 1, //默认9
				    sizeType: ['original', 'compressed'], //可以指定是原图还是压缩图，默认二者都有
				    sourceType: ['album'], //从相册选择
				    success: res=>{
						
						this.value1 = res.tempFilePaths;
				        this.imageUrl = JSON.stringify(res.tempFilePaths);
						
				    }
				});
				else
				uni.chooseImage({
				    count: 5, //默认9
				    sizeType: ['original', 'compressed'], //可以指定是原图还是压缩图，默认二者都有
				    sourceType: ['album'], //从相册选择
				    success: res=> {
						this.value2 = res.tempFilePaths;
						this.examineImage = '';
						for(var i =0;i<res.tempFilePaths.length;i++){
						if(i!=(res.tempFilePaths.length-1))
						this.examineImage = this.examineImage+JSON.stringify(res.tempFilePaths[i])+";";
						else
						this.examineImage = this.examineImage+JSON.stringify(res.tempFilePaths[i]);
						} 
				    }
				});
				this.countFine = 0;
				this.showC = false;
			},
			camera() {
				if(this.countFine==0)
				uni.chooseImage({
				    count: 1, //默认9
				    sizeType: ['original', 'compressed'], //可以指定是原图还是压缩图，默认二者都有
				    sourceType: ['camera'], //从相机选择
				    success: res=> {
				       this.imageUrl = JSON.stringify(res.tempFilePaths);
					   this.value1 = this.res.tempFilePaths;
				    }
				});
				else
				uni.chooseImage({
				    count: 5, //默认9
				    sizeType: ['original', 'compressed'], //可以指定是原图还是压缩图，默认二者都有
				    sourceType: ['camera'], //从相机选择
				    success: res=> {
				        this.examineImage = '';
				        for(var i =0;i<res.tempFilePaths.length;i++){
				        if(i!=(res.tempFilePaths.length-1))
				        this.examineImage = this.examineImage+JSON.stringify(res.tempFilePaths[i])+";";
				        else
				        this.examineImage = this.examineImage+JSON.stringify(res.tempFilePaths[i]);
				        }
						this.value2 = res.tempFilePaths;
				    }
				});
				this.countFine = 0;
				this.showC = false;
			},	
			
			cancel() {
				this.showC = false;
			},
			change(data) {
			     this.location = data.data.join()
			},
			
			bindChange(e) {
					let a;
					let y;
					console.log(e);
					let val = e.detail.value;
					y = this.years[val[0]];
					a = this.months[val[1]];
					this.day = this.days[val[2]];
					this.month = a;
					this.year = y;
					this.days = [];
					if (a||y) {
						if (a == 1 || a == 3 || a == 5 || a == 7 || a == 8 || a == 10 || a == 12) {
							for (let i = 1; i <= 31; i++) {
								this.days.push(i)
							}
						} else if (a == 4 || a == 6 || a == 11 || a == 9) {
							for (let i = 1; i <= 30; i++) {
								this.days.push(i)
							}
							
						} else if (a == 2) {
							if (this.year % 4 == 0 && (this.year % 100 != 0 || this.year % 400 == 0)) {
								for (let i = 1; i <= 29; i++) {
									this.days.push(i)
								}
							} else {
								for (let i = 1; i <= 28; i++) {
									this.days.push(i)
								}
							}
						}
					
					}
				},
				date() {
					this.$refs.wenzi.open();
					this.panduan = 1;
				},
				date1() {
					this.$refs.wenzi.open();
					this.panduan = 2;
				},
				date2() {
					this.$refs.wenzi.open();
				},
				concel(){
					this.$refs.wenzi.close();
				},
				confirm(){
					if(this.panduan == 1)
					this.foundDate = this.year+"-"+this.month+"-"+this.day;
					else if(this.panduan == 2)
					 this.manegeDeadline = this.year+"-"+this.month+"-"+this.day;
					else
					 this.examineDate = this.year+"-"+this.month+"-"+this.day;
					console.log(this.foundDate);
					this.$refs.wenzi.close();
					this.panduan = 0;
				},
				
				bindPickerChange: function(e) {		//改变的事件名
					//console.log('picker发送选择改变，携带值为', e.target.value)   用于输出改变索引值
					this.index = e.target.value			//将数组改变索引赋给定义的index变量
					this.investField = this.typeOfInvestField[this.index]		//将array【改变索引】的值赋给定义的jg变量
				//	console.log("籍贯为：",this.jg)		//输出获取的籍贯值，例如：中国
				},
				
				bindPickerChange1: function(e) {		//改变的事件名
					//console.log('picker发送选择改变，携带值为', e.target.value)   用于输出改变索引值
					this.index = e.target.value			//将数组改变索引赋给定义的index变量
					this.investMoney = this.typeOfInvestMoney[this.index]		//将array【改变索引】的值赋给定义的jg变量
				//	console.log("籍贯为：",this.jg)		//输出获取的籍贯值，例如：中国
				},
				
				postData(){
					this.userId = parseInt(this.userId);
					var x;
					for(var i=1;i<=this.array.length;i++){
						if(this.investType == (this.array[i])){
							x = i;
							break;
						}
					}
					
					var verifyArray = [
						this.name,this.corporate,
						this.location,this.address,
						this.code,this.telephone,this.regOffice,this.imageUrl,this.examineImage,
						this.contactName,this.contactPhone,this.contactPosition,this.contactEmail,this.contactAddress,
						this.investField,this.investMethod,this.investMoney,this.investType
					];
					for(var i =0;i<=verifyArray.length;i++){
						if(verifyArray[i]==""){
							this.tip();
							return;
						}
					}
					  const res = this.$myRequest({
					  header: {
							  'Content-Type': 'application/x-www-form-urlencoded'  
						   }, 
						url: "/financialInstitution/request", 
					    method: 'POST',
						   data:{
							   
							   //     "name": this.name,
							   //     "corporate":this.corporate,
							   //     "type": this.type,
							   //     "manegeScope": this.manegeScope,
							   //     "introduction": this.introduction,
							   //     "foundDate": this.foundDate+" 00:00:00",
							   //     "manegeDeadline": this.manegeDeadline+" 00:00:00",
							   //     "website": this.website,
							   //     "email": this.email,
							   //     "capital": this.capital,
							   //     "location": this.location,
							   //     "address": this.address,
							   //     "code": this.code,
							   //     "telephone": this.telephone,
							   //     "regOffice": this.regOffice,
							   //     "examineDate": this.examineDate+" 00:00:00",
							   //     "imageUrl": this.imageUrl,
							   //     "examineImage":this.examineImage,
							   //     "userId": this.userId,
								   "investField":this.investField,
								   	"investDescription":this.investDescription,
								   	"investWay":this.investMethod,
								   	"investingMoney":this.investMoney,
								   	"investType":x,
								   "successCase": this.successCase,
							       "contactName": this.contactName,
							       "contactPhone": this.contactPhone,
							       "contactEmail": this.contactEmail,
							       "contactAddress": this.contactAddress,
							       "contactCompany": this.contactCompany,
								   
								     "briefAddress":this.briefAddress,
								     "briefIntroduction":this.briefIntroduction,
								     "businessScope":this.businessScope,
								     "detailedAddress":this.detailedAddress,
								     "email": this.email,
								     "establishmentDay": this.establishmentDay+" 00:00:00",
									 "sanctionDay": this.sanctionDay+" 00:00:00",
									 "timeLimit": this.timeLimit+" 00:00:00",
								     "financialInstitutionId": 0,
								     "financialInstitutionImage":this.financialInstitutionImage,
								     "fixedLineTelephone": this.fixedLineTelephone,
								     "legalPersonId": 0,
								     "legalPersonName": this.legalPersonName,
								     "registeredCapital": this.registeredCapital,
								     "registrationAuthority": this.registrationAuthority,
								     "result": this.result,
								     
								     "socialCreditCode": this.socialCreditCode,
								     
								     "websites": this.websites,
								   }
							   
						 
					   // dataType:'json',
					   }); 
				},
				
				async getTypeOfInvestField(){
					const res =await this.$myRequest({
						url: '/investfieldindex/getlist'
					});
					let objList = res.data.data;
					let objList1=[];
					for(let i = 0;i<objList.length;i++){
						objList1[i]=objList[i].name;
						
					}
					this.typeOfInvestField = objList1;
				},
				
				async getTypeOfInvestMoney(){
					const res =await this.$myRequest({
						url: '/investmoneyindex/getlist'
					});
					let objList = res.data.data;
					let objList1=[];
					for(let i = 0;i<objList.length;i++){
						objList1[i]=objList[i].name;
						
					}
					this.typeOfInvestMoney = objList1;
				},
				
				tip(){
					uni.showModal({
					    title: '提示',
					    content: '请把带 * 的内容填了！',
					    success: function (res) {
					        // if (res.confirm) {
					        //     console.log('用户点击确定');
					        // } else if (res.cancel) {
					        //     console.log('用户点击取消');
					        // }
					    }
					});
				}
				
			}
			
		 }
</script>
	
	

<style scoped lang="scss">
	@import '../allStyle.css';
	.title {
		font-size: 30rpx;
		position: relative;
		line-height: 1;
		padding-left: 28rpx;
		font-weight: 900;
		margin: 40rpx 0;
		color: $uni-color-title;
	
		&:before {
			width: 4px;
			height: 17px;
			border-radius: 100rpx;
			background-color: $uni-color-primary;
			content: '';
			position: absolute;
			left: 6rpx;
			top: -1px;
		}
	}
	.scrollItem{
		height:3800upx;
		background-color: #f0f0f0;
	}
	.picker-view {
		background-color: #EEEEEE;
		position: absolute;
		width: 100%;
		height: 500upx;
		bottom: 20upx;
		.item {
			line-height: 100rpx;
			font-size: 34upx;
			text-align: center;
		}
	}
</style>
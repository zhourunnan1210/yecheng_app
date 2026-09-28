<template>
	<view class="page">
		<view class="shape1" style="margin-top: 20upx;background-color: #FFFFFF;height: 180upx;">
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
		</view>
		
		<view style="margin-top: 20upx;"></view>
		
		
		<view class="popup" v-if="showC">
			<view class="popup-info">
				<view><button @tap="album">本地相册</button></view>
				<view><button @tap="camera">相机拍照</button></view>
				<view><button @tap="cancel">取消</button></view>
			</view>
		</view>
		
		<scroll-view class="scrollItem">
			<view class="viewItem">
				<text style="margin-left: 20upx;">{{viewArray[0].title}}</text>
				<view style="text-align: right;display: inline-block">
					<input id="value" @input="getName" style="margin-right: 20upx;" v-model="name" :placeholder="viewArray[0].statement" />
				</view>
			</view>
			<hr style='border:0.6upx inset #FfFfF8;'>
			<view class="viewItem">
				<text style="margin-left: 20upx;">{{viewArray[1].title}}</text>
				<view style="text-align: right;display: inline-block">
					<view class="content">
					     <pickerAddress @change="change">
							 <input disabled="true" style="margin-right: 20upx;" v-model="location" :placeholder="viewArray[1].statement" /> 
						 </pickerAddress>
					 </view>
					<!-- <input @input="getValue" style="margin-right: 20upx;" v-model="location" 
					  :value="location" :placeholder="viewArray[3].statement" /> -->
				</view>
			</view>
			<hr style='border:0.6upx inset #FfFfF8;'>
			<view class="viewItem">
				<text style="margin-left: 20upx;">{{viewArray[2].title}}</text>
				<view style="text-align: right;display: inline-block">
					<input @input="getAddress" style="margin-right: 20upx;" v-model="address"  :placeholder="viewArray[2].statement" />
				</view>
			</view>
			<hr style='border:0.6upx inset #FfFfF8;'>
			
			
			<view class="viewItem">
				<text style="margin-left: 20upx;">{{viewArray[3].title}}</text>
				<view style="text-align: right;display: inline-block">
					<input @input="getWebsite" style="margin-right: 20upx;" v-model="website"  :placeholder="viewArray[3].statement" />
				</view>
			</view>
			<hr style='border:0.6upx inset #FfFfF8;'>
			<view class="viewItem">
				<text style="margin-left: 20upx;">{{viewArray[4].title}}</text>
				<view style="text-align: right;display: inline-block">
					<input @input="getEmail" style="margin-right: 20upx;" v-model="email"  :placeholder="viewArray[4].statement" />
				</view>
			</view>
			<hr style='border:0.6upx inset #FfFfF8;'>
			
			<view class="viewItem">
				<text style="margin-left: 20upx;">{{viewArray[5].title}}</text>
				<view style="text-align: right;display: inline-block">
					<input @input="getCode" style="margin-right: 20upx;" :v-model="code"  :placeholder="viewArray[5].statement" />
				</view>
			</view>
			<hr style='border:0.6upx inset #FfFfF8;'>
			
			<view class="viewItem">
				<text style="margin-left: 20upx;">{{viewArray[6].title}}</text>
				<view style="text-align: right;display: inline-block">
					<input @input="getTelephone" style="margin-right: 20upx;" v-model="telephone"  :placeholder="viewArray[6].statement" />
				</view>
			</view>
			<hr style='border:0.6upx inset #FfFfF8;'>
			<view class="container" style="height: 180upx;background-color: #FFFFFF;" @click="tapPopup">
				<text style="margin-left: 20upx;">{{viewArray[7].title}}</text>
				
				<view v-for="item in value1" style="display: inline-block;margin-right: 145upx;" >
					<image class="icon" :src="item"></image>
				</view>
				
			</view>
			<hr style='border:0.6upx inset #FfFfF8;'>
			<view class="container" style="height: 180upx;" @click="tapPopup1">
				<text style="margin-left: 20upx;">{{viewArray[8].title}}</text>
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
				<text style="margin-left: 20upx;">{{viewArray[9].title}}</text>
				<view style="text-align: right;display: inline-block">
					<input @input="getUserId" style="margin-right: 20upx;" v-model="userId"   :placeholder="viewArray[9].statement" />
				</view>
			</view>
			<hr style='border:0.6upx inset #FfFfF8;'>
			<view class="viewItem">
				<text style="margin-left: 20upx;">{{viewArray[10].title}}</text>
				<view style="text-align: right;display: inline-block">
					<input @input="getContactName" style="margin-right: 20upx;" v-model="contactName"    :placeholder="viewArray[10].statement" />
				</view>
			</view>
			<hr style='border:0.6upx inset #FfFfF8;'>
			<view class="viewItem">
				<text style="margin-left: 20upx;">{{viewArray[11].title}}</text>
				<view style="text-align: right;display: inline-block">
					<input @input="getContactPhone" style="margin-right: 20upx;" v-model="contactPhone"    :placeholder="viewArray[11].statement" />
				</view>
			</view>
			<hr style='border:0.6upx inset #FfFfF8;'>
			<view class="viewItem">
				<text style="margin-left: 20upx;">{{viewArray[12].title}}</text>
				<view style="text-align: right;display: inline-block">
					<input @input="getContactPosition" style="margin-right: 20upx;" v-model="contactPosition"   :placeholder="viewArray[12].statement" />
				</view>
			</view>
			<hr style='border:0.6upx inset #FfFfF8;'>
			<view class="viewItem">
				<text style="margin-left: 20upx;">{{viewArray[13].title}}</text>
				<view style="text-align: right;display: inline-block">
					<input @input="getContactEmail" style="margin-right: 20upx;" v-model="contactEmail"    :placeholder="viewArray[13].statement" />
				</view>
			</view>
			<hr style='border:0.6upx inset #FfFfF8;'>
			<view class="viewItem">
				<text style="margin-left: 20upx;">{{viewArray[14].title}}</text>
				<view style="text-align: right;display: inline-block">
					<input @input="getContactAddress" style="margin-right: 20upx;" v-model="contactAddress"   :placeholder="viewArray[14].statement" />
				</view>
			</view>
			<hr style='border:0.6upx inset #FfFfF8;'>
		</scroll-view>
		<view @click="postData" class="container1">
			<hr style='border:0.6upx inset #8F8F94;'>
			<view class="shape2">
				<text style="font-weight: 700">下一步</text>
			</view>
		</view>
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
				
				array:['有效期高企','培育库入库企业','当年申报企业'],
				index:0,
				
				panduan:0,
				title: 'picker-view',
				years:"",
				year:"",
				months:"",
				month:"",
				days:"",
				day:"",
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
				
				
				
				address: "",
				code: "",
				email: "",
				examineImage: "",
				imageUrl: "",
				location: "",
				name: "",
				telephone: "",
				userId:"",
				website: "",
				contactAddress: "",
				contactEmail: "",
				contactName: "",
				contactPhone: "",
				contactPosition: "",
				 
				// name:"",corporate:"" ,type:"",manegeScope:"",introduction:"",
				// foundDate:"",manegeDeadline:"",website:"" ,email:"",capital:"" ,location:"", 
				// address:"",code:"" ,telephone:"",regOffice:"", examineDate:"",imageUrl:"",examineImage:"",userId:"",
				//  contactName:"",phone:"",position:"",contactEmail:"",contactAddress:"",
				viewArray:[
					{title:"单位名称*",statement:"请填写单位名称"},
					{title:"省市区*",statement:"请选择省市区 >"},
					{title:"详细地址*",statement:"详细地址"},
					{title:"学校网站",statement:"请填写学校网站"},
					{title:"邮箱",statement:"请填写邮箱"},
					{title:"统一社会信用代码*",statement:"请填写统一社会信用代码"},
					{title:"固定电话*",statement:"请填写固定电话"},
					{title:"学校图片*(最多一张)",statement:"请上传学校图片"},
					{title:"审核所需图片资料*(最多5张)",statement:"请上传审核所需图片资料"},
					{title:"用户账号(本应用)",statement:"(本应用账号)"},
					{title:"联系人*",statement:"请填写联系人"},
					{title:"联系人手机*",statement:"请填写手机"},
					{title:"联系人单位*",statement:"单位"},
					{title:"联系人邮箱*",statement:"请填写邮箱"},
					{title:"联系地址*",statement:"请填写联系地址"}
				]	
			};
			
		},
		methods: {
			getName:function(e){
				this.name = e.target.value;
			},
			getCorporate:function(e){
				this.corporate = e.target.value;
			},
			getAddress:function(e){
				this.address = e.target.value;
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
			getCode:function(e){
				this.code = e.target.value;
			},
			getUserId:function(e){
				this.userId = e.target.value;
			},
			getContactName:function(e){
				this.contactName = e.target.value;
			},
			getContactPhone:function(e){
				this.ContactPhone = e.target.value;
			},
			getContactPosition:function(e){
				this.ContactPosition = e.target.value;
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
					let a = "";
					let y= "";
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
					this.type = this.array[this.index]		//将array【改变索引】的值赋给定义的jg变量
				//	console.log("籍贯为：",this.jg)		//输出获取的籍贯值，例如：中国
				},
				
				postData(){
					
					this.userId = parseInt(this.userId);
					
					var verifyArray = [
						this.name,
						this.location,this.address,
						this.code,this.telephone,this.imageUrl,this.examineImage,
						this.contactName,this.contactPhone,this.contactPosition,this.contactEmail,this.contactAddress
						 
					];
					for(var i =0;i<=verifyArray.length;i++){
						if(verifyArray[i]==""){
							this.tip();
							return;
						}
					}
					const res = this.$myRequest({
					  header: {
							  'Content-Type': 'application/json'  
						   }, 
						url: "/schoolinfoauthentication/save", //仅为示例，并非真实接口地址。
					   method: 'POST',
						   data:{
							   
							   
							       "name": this.name || [],
							       "website": this.website || [],
							       "email": this.email,
							       "location": this.location || [],
							       "address": this.address || [],
							       "code": this.code || [],
							       "telephone": this.telephone || [],
							       "imageUrl": this.imageUrl || [],
							       "examineImage":this.examineImage || [],
							       "userId": this.userId || [],
							       "contactName": this.contactName || [],
							       "contactPhone": this.contactPhone || [],
							       "contactEmail": this.contactEmail || [],
							       "contactAddress": this.contactAddress || [],
							       "contactPosition": this.contactPosition || []
							   
						   },
							  
					   dataType:'json',
					   }); 
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
	
</script>

<style scoped lang="scss">
	
	//@import '../allStyle.css';
	
	.container{
			display: flex;
			flex-direction: row;
			align-items: center;
			justify-content: space-between;
		}
		.shape1{
				display: flex;
				flex-direction: row;
				justify-content: center;
				align-items: center;
			}
		.shape{
			width: 140upx;
			height: 180upx;
			background-color: #FFFFFF;
			display: flex;
			flex-direction: column;
			justify-content: space-around;
			align-items: center;
		}
		.icon {
			width: 15vw;
			height: 15vw;
		}
		.textShape{
			font-size: 8px;
		}
		.viewItem{
		    height: 120upx;
		    display: flex;
			background-color: #FFFFFF;
			flex-direction: row;
			justify-content: space-between;
			align-items: center;
		}
		.scrollItem{
			height:3125upx;
		}
		.container1{
			left: 0;
			right: 0;
			position: fixed;
			bottom: 0upx;
			background-color: #FFFFFF;
			height: 90upx;
		}
		.shape2{
			text-decoration: underline;
			display: flex;
			justify-content: center;
			margin-top: 20upx;
		}
		.icon {
			width: 15vw;
			height: 15vw;
		}
		.popup {
			position: fixed;
			left: 0;
			right: 0;
			top: 0;
			height: 100vh;
			background-color: rgba(0,0,0,0.6);
			z-index: 9998;
		}
		.popup-info{
			
			position: fixed;
			width: 550upx;
			top: 50%;
			left: 50%;
			transform: translate(-50%,-50%);
			font-size: 30upx;
			padding: 40upx;
			border-radius: 20upx;
			background-color: #fff;
			z-index: 9999;
		}
		.date-select {
			width: 100%;
			height: 700upx;
			border-top-left-radius: 40upx;
			border-top-right-radius: 40upx;
			background-color: #FFFFFF;
			position: relative;
		
			
					.btn-left,.btn-right{
						color: #FFFFFF;
						width: 150upx;
						height: 90upx;
						line-height: 90upx;
						text-align: center;
						// border: 1upx solid #BEBEBE;
						border-radius: 15upx;
					}
					.btn-left{
						background-color: #BEBEBE;
					}
					.btn-right{
						background-color: #1cb419;
					}
		
		}
	
	.scrollItem{
		height:2040upx;
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
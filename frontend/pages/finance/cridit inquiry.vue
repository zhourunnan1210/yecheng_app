<template>
	<view class="content">
		<view class="search-box">
			<u-search placeholder="请输入企业名称" v-model="keyword" shape="square" :show-action="false"></u-search>
		</view>
		<view class="button-box">
			<u-button @click="inquiry" type="primary" :ripple="true" size="medium">查询</u-button>
			<u-button @click="openWatermarkModal" type="warning" :ripple="true" size="medium">水印提取</u-button>
		</view>

		<view class="result-list" v-if="TAList.length > 0">
			<view class="result-card" v-for="(item, i) in TAList" :key="i">
				<view class="card-header">
					<text class="card-title">{{ item.financialInstitutionName || '未知机构' }}</text>
					<text class="card-label">信用评估如下</text>
				</view>

				<view class="credit-section">
					<view class="section-title">信用评估材料</view>
					<view class="credit-content">
						<image
							v-if="!item._imgError && isImageUrl(resolveImage(item.financialInstitutionImage))"
							:src="resolveImage(item.financialInstitutionImage)"
							mode="widthFix"
							style="width: 100%; border-radius: 8rpx;"
							@error="onImageError($event, i)"
							@click="previewImage(resolveImage(item.financialInstitutionImage))"
						></image>
						<image
							v-else
							:src="DEFAULT_IMAGE"
							mode="widthFix"
							style="width: 100%; border-radius: 8rpx;"
						></image>
					</view>
				</view>
			</view>
		</view>

		<view class="empty-tip" v-else-if="hasSearched">
			<u-empty text="未查询到相关企业" mode="search"></u-empty>
		</view>

		<!-- 水印提取弹窗 -->
		<u-popup v-model="showWatermarkModal" mode="center" border-radius="16" width="600rpx">
			<view class="modal-content">
				<view class="modal-title">水印提取</view>
				<view class="modal-tip">请上传需要提取水印的图片</view>
				<view class="upload-wrapper">
					<u-upload
						:key="watermarkUploadKey"
						:file-list="watermarkFileList"
						:action="'#'"
						:auto-upload="false"
						:max-count="1"
						@on-list-change="onWatermarkFileChange"
						width="200"
						height="200"
					></u-upload>
				</view>
				<view class="modal-btns">
					<u-button @click="cancelWatermark" type="default" size="medium">取消</u-button>
					<u-button @click="confirmWatermark" type="primary" size="medium">确定</u-button>
				</view>
			</view>
		</u-popup>
	</view>
</template>

<script>
	import { needDefaultImage, isStaleOssUrl } from '../../utils/imageUrl.js'
	export default {
		data() {
			return {
				keword: '',
				TAList: [],
				hasSearched: false,
				DEFAULT_IMAGE: '/static/defaultImage/1.png',
				showWatermarkModal: false,
				watermarkFileList: [],
				watermarkTempPath: '',
				watermarkUploadKey: 0
			}
		},
		methods: {
			resolveImage(url) {
				if (needDefaultImage(url)
					|| url.trim() === '') {
					return this.DEFAULT_IMAGE
				}
				// 本地隐写图片路径需要拼接后端 BASE_URL
				if (url.startsWith('/image/')) {
					return this.BASE_URL + url
				}
				// /static/ 开头的默认图直接返回（在前端项目中）
				return url
			},
			isImageUrl(str) {
				if (!str) return false
				const lower = str.toLowerCase()
				return lower.startsWith('http') ||
					lower.endsWith('.jpg') ||
					lower.endsWith('.jpeg') ||
					lower.endsWith('.png') ||
					lower.endsWith('.gif') ||
					lower.endsWith('.webp') ||
					lower.startsWith('/static/') ||
					lower.startsWith('/image/')
			},
			onImageError(event, index) {
				this.$set(this.TAList[index], '_imgError', true)
			},
			previewImage(url) {
				if (!url || url === this.DEFAULT_IMAGE || url === this.BASE_URL + this.DEFAULT_IMAGE) return
				uni.previewImage({
					urls: [url],
					current: url
				})
			},
			async inquiry() {
				if (!this.keyword || this.keyword.trim() === '') {
					return uni.showToast({
						title: '请输入企业名称',
						icon: 'none'
					})
				}
				const res = await this.$myRequest({
					url: '/financialInstitution/getCreditMaterialsByFinancialInstitutionName/' + encodeURIComponent(this.keyword.trim()),
					method: 'GET',
					header: {
						'content-type': 'application/json'
					}
				})
				console.log(res, 'credit inquiry result')
				this.hasSearched = true
				if (!res.data.data || res.data.data.length === 0) {
					this.TAList = []
					return uni.showToast({
						title: '未查询到该企业',
						icon: 'none'
					})
				}
				this.TAList = res.data.data
			},
			// 打开水印提取弹窗
			openWatermarkModal() {
				// 查询结果有且仅有1个有效项时，直接提取该图片水印
				if (this.TAList.length === 1) {
					const imageUrl = this.resolveImage(this.TAList[0].financialInstitutionImage)
					// 排除默认图和远程OSS图（无法直接下载提取）
					if (imageUrl && imageUrl !== this.DEFAULT_IMAGE && imageUrl !== this.BASE_URL + this.DEFAULT_IMAGE) {
						this.extractWatermarkFromUrl(imageUrl)
						return
					}
				}
				// 其他情况：打开上传弹窗，并确保组件为初始状态
				this.watermarkFileList = []
				this.watermarkTempPath = ''
				this.watermarkUploadKey++
				this.showWatermarkModal = true
			},
			// 上传组件文件变化回调
			onWatermarkFileChange(lists) {
				this.watermarkFileList = lists
				if (lists.length > 0 && lists[0].url) {
					this.watermarkTempPath = lists[0].url
				} else {
					this.watermarkTempPath = ''
				}
			},
			// 取消水印提取
			cancelWatermark() {
				this.showWatermarkModal = false
				this.watermarkFileList = []
				this.watermarkTempPath = ''
				this.watermarkUploadKey++
			},
			// 统一处理解码响应
			handleDecodeResponse(uploadRes) {
				uni.hideLoading()
				try {
					const res = JSON.parse(uploadRes.data)
					if (res.message) {
						uni.showModal({
							title: '提取成功',
							content: '隐写信息：' + res.message,
							showCancel: false
						})
					} else if (res.error) {
						uni.showToast({
							title: '提取失败：' + res.error,
							icon: 'none'
						})
					} else {
						uni.showToast({
							title: '未提取到水印信息',
							icon: 'none'
						})
					}
				} catch (e) {
					uni.showToast({
						title: '解析响应失败',
						icon: 'none'
					})
				}
			},
			// 从URL直接下载并提取水印（用于单条数据智能提取）
			extractWatermarkFromUrl(imageUrl) {
				uni.showLoading({ title: '正在提取水印...' })
				uni.downloadFile({
					url: imageUrl,
					success: (downloadRes) => {
						if (downloadRes.statusCode === 200) {
							uni.uploadFile({
								url: this.BASE_URL + '/imgstegano/decode',
								filePath: downloadRes.tempFilePath,
								name: 'file',
								success: (uploadRes) => {
									this.handleDecodeResponse(uploadRes)
								},
								fail: (err) => {
									uni.hideLoading()
									uni.showToast({
										title: '请求失败，请检查服务',
										icon: 'none'
									})
									console.error('水印提取请求失败:', err)
								}
							})
						} else {
							uni.hideLoading()
							uni.showToast({
								title: '图片下载失败',
								icon: 'none'
							})
						}
					},
					fail: () => {
						uni.hideLoading()
						uni.showToast({
							title: '图片下载失败',
							icon: 'none'
						})
					}
				})
			},
			// 确定提取水印（弹窗上传方式）
			confirmWatermark() {
				if (!this.watermarkTempPath) {
					return uni.showToast({
						title: '请先上传图片',
						icon: 'none'
					})
				}
				// 先关闭弹窗，避免遮挡后续提示
				this.showWatermarkModal = false
				uni.showLoading({ title: '正在提取水印...' })
				uni.uploadFile({
					url: this.BASE_URL + '/imgstegano/decode',
					filePath: this.watermarkTempPath,
					name: 'file',
					success: (uploadRes) => {
						this.handleDecodeResponse(uploadRes)
					},
					fail: (err) => {
						uni.hideLoading()
						uni.showToast({
							title: '请求失败，请检查服务',
							icon: 'none'
						})
						console.error('水印提取请求失败:', err)
					}
				})
			}
		}
	}
</script>

<style lang="scss" scoped>
	.content {
		min-height: 100vh;
		background-color: #f5f5f5;
		padding-bottom: 40rpx;
	}

	.search-box {
		padding: 30rpx 20rpx 10rpx;
	}

	.button-box {
		display: flex;
		justify-content: center;
		gap: 20rpx;
		margin-top: 20rpx;
		margin-bottom: 20rpx;
	}

	.result-list {
		padding: 0 20rpx;
	}

	.result-card {
		background-color: #ffffff;
		border-radius: 16rpx;
		padding: 30rpx;
		margin-bottom: 24rpx;
		box-shadow: 0 2rpx 12rpx rgba(0, 0, 0, 0.06);
	}

	.card-header {
		display: flex;
		flex-direction: column;
		align-items: center;
		margin-bottom: 24rpx;
		border-bottom: 1rpx solid #f0f0f0;
		padding-bottom: 20rpx;
	}

	.card-title {
		font-size: 34rpx;
		font-weight: bold;
		color: #333333;
		text-align: center;
		word-break: break-all;
	}

	.card-label {
		font-size: 26rpx;
		color: #999999;
		margin-top: 8rpx;
	}

	.credit-section {
		background-color: #fafafa;
		border-radius: 12rpx;
		padding: 24rpx;
	}

	.section-title {
		font-size: 28rpx;
		font-weight: 500;
		color: #555555;
		margin-bottom: 16rpx;
		padding-left: 12rpx;
		border-left: 6rpx solid #1296db;
	}

	.credit-content {
		width: 100%;
	}

	.credit-text {
		font-size: 26rpx;
		color: #666666;
		line-height: 1.6;
		word-break: break-all;
	}

	.credit-empty {
		display: flex;
		justify-content: center;
		align-items: center;
		padding: 30rpx 0;
	}

	.credit-empty text {
		font-size: 26rpx;
		color: #bbbbbb;
	}

	.empty-tip {
		margin-top: 100rpx;
	}

	/* 水印提取弹窗样式 */
	.modal-content {
		padding: 40rpx;
		display: flex;
		flex-direction: column;
		align-items: center;
	}

	.modal-title {
		font-size: 36rpx;
		font-weight: bold;
		color: #333;
		margin-bottom: 20rpx;
	}

	.modal-tip {
		font-size: 28rpx;
		color: #666;
		margin-bottom: 30rpx;
	}

	.upload-wrapper {
		margin-bottom: 30rpx;
	}

	.modal-btns {
		display: flex;
		gap: 30rpx;
		width: 100%;
		justify-content: center;
	}
</style>

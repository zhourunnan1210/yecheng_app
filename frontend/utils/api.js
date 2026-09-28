
// 后端 API 地址。
// 本项目用 HBuilderX 直接运行源码，没有走打包时的环境变量注入，
// 所以切换环境就改这一行：本地开发改成 http://localhost:10086，
// 部署后改成你的域名或 http://<你的服务器IP>:10086
const BASE_URL = "http://localhost:10086"

/**
 * 测试后端服务连接
 */
export const testBackendConnection = () => {
	return new Promise((resolve, reject) => {
		uni.request({
			url: BASE_URL + '/talentNeed/getList',
			method: 'GET',
			header: {
				'content-type': 'application/json'
			},
			success: (res) => {
				console.log('后端连接测试成功:', res);
				resolve(res);
			},
			fail: (err) => {
				console.error('后端连接测试失败:', err);
				reject(err);
			}
		});
	});
}

export const myRequest = (options) => {
	return new Promise((resolve, reject) => {
		uni.request({
			url: BASE_URL + options.url,
			// url: options.url, // 调用本地接口，使用完整的url
			method: options.method || 'GET',
			data: options.data || {},
			header: options.header,
			success: (res) => {
				console.log('API响应:', res);
				if (res.data.code !== 0
				// && res.data.code !==9999 
				// && res.data.code !==10000
				// && res.data.code !==10001
				// && res.data.code !==10002
				// && res.data.code !==10003
				// && res.data.code !==721
				) {
					let errorMsg = res.data.msg || res.data.message || '操作失败';
					console.log('API错误:', errorMsg);
					uni.showToast({
						icon: 'error',
						title: errorMsg
					})
					reject(new Error(errorMsg))
					return
				}
				console.log('API成功:', res.data);
				resolve(res)
			},
			fail: (err) => {
				uni.showToast({
					title: '请求数据失败'
				})
				reject(err)
			}
		})
	})
}
export default BASE_URL

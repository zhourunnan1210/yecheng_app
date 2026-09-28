import BASE_URL from './api.js'

/**
 * 推荐工具函数
 * 统一管理增强版和原版推荐接口的调用
 */

/**
 * 测试后端服务是否可用
 * @returns {Promise<boolean>} 服务是否可用
 */
export async function testBackendService() {
	try {
		const [error, res] = await uni.request({
			url: BASE_URL + '/talentNeed/getList',
			method: 'GET',
			header: {
				'content-type': 'application/json'
			}
		});
		
		if (error) {
			console.error('后端服务测试失败:', error);
			return false;
		}
		
		console.log('后端服务测试成功:', res.data);
		return true;
	} catch (error) {
		console.error('后端服务测试失败:', error);
		return false;
	}
}

/**
 * 获取增强版岗位推荐
 * @param {number} userId 用户ID
 * @returns {Promise<Array>} 推荐岗位列表
 */
export async function getEnhancedJobRecommendations(userId) {
	try {
		console.log('开始调用增强版岗位推荐API，用户ID:', userId);
		const [error, res] = await uni.request({
			url: BASE_URL + `/api/recommendation/enhanced/jobs/${userId}`,
			method: 'GET',
			header: {
				'content-type': 'application/json'
			}
		});
		
		if (error) {
			console.error('增强版岗位推荐网络错误:', error);
			throw error;
		}
		
		console.log('增强版岗位推荐API响应:', res);
		
		if (res.data.code === 0) {
			const result = res.data.data || [];
			console.log('增强版岗位推荐成功，返回数量:', result.length);
			return result;
		} else {
			console.error('增强版岗位推荐业务错误:', res.data);
			throw new Error(res.data.msg || '增强版推荐失败');
		}
	} catch (error) {
		console.error('增强版岗位推荐失败:', error);
		console.error('错误详情:', error.message);
		throw error;
	}
}

/**
 * 获取增强版简历推荐
 * @param {number} userId 用户ID
 * @returns {Promise<Array>} 推荐简历列表
 */
export async function getEnhancedTalentRecommendations(userId) {
	try {
		const [error, res] = await uni.request({
			url: BASE_URL + `/api/recommendation/enhanced/talents/${userId}`,
			method: 'GET',
			header: {
				'content-type': 'application/json'
			}
		});
		
		if (error) {
			throw error;
		}
		
		if (res.data.code === 0) {
			return res.data.data || [];
		} else {
			throw new Error(res.data.msg || '获取推荐失败');
		}
	} catch (error) {
		console.error('增强版简历推荐失败:', error);
		throw error;
	}
}

/**
 * 获取原版岗位推荐（备用）
 * @param {number} userId 用户ID
 * @returns {Promise<Array>} 推荐岗位列表
 */
export async function getFallbackJobRecommendations(userId) {
	try {
		const [error, res] = await uni.request({
			url: BASE_URL + `/talentSupply/recommendJobsByUserId/${userId}`,
			method: 'GET',
			header: {
				'content-type': 'application/json'
			}
		});
		
		if (error) {
			throw error;
		}
		
		return res.data.recommendedJobs || [];
	} catch (error) {
		console.error('原版岗位推荐失败:', error);
		throw error;
	}
}

/**
 * 获取原版简历推荐（备用）
 * @param {number} userId 用户ID
 * @returns {Promise<Array>} 推荐简历列表
 */
export async function getFallbackTalentRecommendations(userId) {
	try {
		const [error, res] = await uni.request({
			url: BASE_URL + `/talentNeed/recommendTalentsByUserId/${userId}`,
			method: 'GET',
			header: {
				'content-type': 'application/json'
			}
		});
		
		if (error) {
			throw error;
		}
		
		return res.data.recommendedTalents || [];
	} catch (error) {
		console.error('原版简历推荐失败:', error);
		throw error;
	}
}

/**
 * 智能获取岗位推荐（优先使用增强版，失败时回退到原版）
 * @param {number} userId 用户ID
 * @returns {Promise<Array>} 推荐岗位列表
 */
export async function getSmartJobRecommendations(userId) {
	try {
		// 优先使用增强版推荐
		const enhancedJobs = await getEnhancedJobRecommendations(userId);
		return enhancedJobs;
	} catch (error) {
		console.log('增强版推荐失败，尝试原版推荐...');
		try {
			// 回退到原版推荐
			const fallbackJobs = await getFallbackJobRecommendations(userId);
			return fallbackJobs;
		} catch (fallbackError) {
			console.error('所有推荐接口都失败:', fallbackError);
			
			// 显示详细的错误信息
			uni.showToast({
				title: `推荐服务不可用: ${fallbackError.message}`,
				icon: 'none',
				duration: 5000
			});
			
			return [];
		}
	}
}

/**
 * 智能获取简历推荐（优先使用增强版，失败时回退到原版）
 * @param {number} userId 用户ID
 * @returns {Promise<Array>} 推荐简历列表
 */
export async function getSmartTalentRecommendations(userId) {
	try {
		// 优先使用增强版推荐
		const enhancedTalents = await getEnhancedTalentRecommendations(userId);
		return enhancedTalents;
	} catch (error) {
		console.log('增强版推荐失败，尝试原版推荐...');
		try {
			// 回退到原版推荐
			const fallbackTalents = await getFallbackTalentRecommendations(userId);
			return fallbackTalents;
		} catch (fallbackError) {
			console.error('所有推荐接口都失败:', fallbackError);
			
			// 显示详细的错误信息
			uni.showToast({
				title: `推荐服务不可用: ${fallbackError.message}`,
				icon: 'none',
				duration: 5000
			});
			
			return [];
		}
	}
}

/**
 * 获取推荐统计信息
 * @param {Array} recommendations 推荐列表
 * @returns {Object} 统计信息
 */
export function getRecommendationStats(recommendations) {
	if (!recommendations || !Array.isArray(recommendations)) {
		return {
			total: 0,
			withScore: 0,
			avgScore: 0,
			scoreDistribution: {}
		};
	}

	const withScore = recommendations.filter(item => item.matchScore > 0).length;
	const scores = recommendations.map(item => item.matchScore || 0);
	const avgScore = scores.length > 0 ? scores.reduce((a, b) => a + b, 0) / scores.length : 0;

	// 分数分布统计
	const scoreDistribution = {
		'0-0.2': 0,
		'0.2-0.4': 0,
		'0.4-0.6': 0,
		'0.6-0.8': 0,
		'0.8-1.0': 0
	};

	scores.forEach(score => {
		if (score <= 0.2) scoreDistribution['0-0.2']++;
		else if (score <= 0.4) scoreDistribution['0.2-0.4']++;
		else if (score <= 0.6) scoreDistribution['0.4-0.6']++;
		else if (score <= 0.8) scoreDistribution['0.6-0.8']++;
		else scoreDistribution['0.8-1.0']++;
	});

	return {
		total: recommendations.length,
		withScore,
		avgScore: Math.round(avgScore * 100) / 100,
		scoreDistribution
	};
} 
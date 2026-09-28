/**
 * 图片 URL 与历史 OSS 桶相关工具。
 *
 * 背景：早期版本把图片存在阿里云 OSS 上，换存储后这些链接会失效。
 * 业务代码遇到失效链接时回退到本地默认图，避免页面出现裂图。
 */

/**
 * 已知的历史 OSS 桶域名。换成你自己的桶时在这里补充，
 * 例如 'my-bucket.oss-cn-hangzhou.aliyuncs.com'。
 */
export const STALE_OSS_DOMAINS = []

/**
 * 判断 URL 是否指向已失效的历史 OSS 桶。空值返回 false。
 * @param {string} url
 * @returns {boolean}
 */
export function isStaleOssUrl(url) {
	if (!url) return false
	const value = String(url)
	return STALE_OSS_DOMAINS.some(domain => domain && value.includes(domain))
}

/**
 * 判断一个图片 URL 是否需要回退到本地默认图：空值或指向失效 OSS 桶时为 true。
 * @param {string} url
 * @returns {boolean}
 */
export function needDefaultImage(url) {
	if (!url || !String(url).trim()) return true
	return isStaleOssUrl(url)
}

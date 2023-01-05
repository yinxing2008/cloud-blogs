import { baseURL } from './config'
function getType(data, method) {
	let type = {}
	if (method == 'post' || method == 'put') {
		type = {
			method,
			data: {
				...data
			},
			header: {
				'content-type': 'application/json',
				'Authorization': uni.getStorageSync('token')
			}
		}
	} else {
		type = {
			method,
			params: {
				...data
			},
			header: {
				'Authorization': uni.getStorageSync('token')
			}
		}
	}
	return type
}

function Request(data, url, method) {
	return new Promise((resolve, reject) => {
		//uni.showLoading()
		uni.request({
			url: baseURL + url,
			...getType(data, method),
			success: res => {
				resolve(res)
			},
			fail: err => {
				//uni.hideLoading()
				console.log('err')
				reject(err)
			}
		})
	}).catch(err => console.log(err))
}


export default function(data, url, method) {
	return Request(data, url, method)
}
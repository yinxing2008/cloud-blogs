import request from '../utils/request'

export function login(params) {
	return request(params, 'user/login', 'post').then(resp => resp)
}

export function register(params) {
	return request(params, 'user/register', 'post').then(resp => resp)
}

export function queryBlogs() {
	return request('', 'blog/blogs', 'get').then(resp => resp)
}

export function queryBlog(blogId) {
	return request('', `blog/blogs/${blogId}`, 'get').then(resp => resp)
}

export function addBlog(params) {
	return request(params, 'blog/blogs', 'post').then(resp => resp)
}

export function modifyBlog(blogId, params) {
  return request(params, `blog/blogs/${blogId}`, 'put').then(resp => resp)
}

export function delBlog(blogId) {
  return request('', `blog/blogs/${blogId}`, 'delete').then(resp => resp)
}


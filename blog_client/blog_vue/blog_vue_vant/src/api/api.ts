import axiosInstance, { AxiosResponseProps } from '@/uitls/request';

export const login = (params: any) => {
	return axiosInstance.post('user/login', params);
};

export const register = (params: any) => {
	return axiosInstance.post('user/register', params);
};

export const queryBlogList = () => {
	return axiosInstance.get('blog/blogs');
};

export const queryBlog = (blogId: string) => {
	return axiosInstance.get('blog/blogs/'+blogId);
};

export const addBlog = (params: any) => {
	return axiosInstance.post('blog/blogs', params);
};

export const modifyBlog = (blogId: string, params: any) => {
	return axiosInstance.put('blog/blogs/'+blogId, params);
};

export const deleteBlog = (blogId: string) => {
	return axiosInstance.delete('blog/blogs/'+blogId);
};
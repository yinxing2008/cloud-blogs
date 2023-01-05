import request from '../router/axios';
import {baseUrl} from "../config/env";

export const addBlog = (form) => {
    return request({
        url: baseUrl + 'blog/blogs',
        method: 'post',
        data: JSON.stringify(form),
        headers: {"Content-Type": "application/json"},
    })
};

export const modifyBlog = (blogId, form) => {
    return request({
        url: baseUrl + 'blog/blogs/'+blogId,
        method: 'put',
        data: JSON.stringify(form),
        headers: {"Content-Type": "application/json"},
    })
};

export const listBlog = () => {
    return request({
        url: baseUrl + 'blog/blogs',
        method: 'get',
    })
};

export const queryBlog = (blogId) => {
    return request({
        url: baseUrl + 'blog/blogs/'+blogId,
        method: 'get',
    })
};

export const delBlog = (blogId) => {
    return request({
        url: baseUrl + 'blog/blogs/'+blogId,
        method: 'delete',
    })
};

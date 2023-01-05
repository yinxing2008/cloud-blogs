/**
 * 厦门大学计算机专业 | 前华为工程师
 * 专注《零基础学编程系列》  http://lblbc.cn/blog
 * 包含：Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
 * 公众号：蓝不蓝编程
 */

import { User } from '../../data/UserDataStore';
import { BASE_URL } from './Constants';

import http from '@ohos.net.http';


export function httpRequestGet(url: string) {
  url = BASE_URL + url
  let httpRequest = http.createHttp();
  var user = User.get()
  var header = {
    'Content-Type': 'application/json',
    'Authorization': user.getToken(),
  }
  let responseResult = httpRequest.request(url, {
    method: http.RequestMethod.GET,
    header: header
  });
  let serverData: {
    code,
    data: any,
    msg: string | Resource
  } = { code: 0, data: '', msg: '' };
  // 处理数据，并返回
  return responseResult.then((value) => {
    if (value.responseCode === 200) {
      // 获取返回数据
      let result = `${value.result}`;
      let resultJson = JSON.parse(result);
      serverData.data = resultJson.data;
      serverData.code = resultJson.code;
      serverData.msg = resultJson.msg;
    } else {
      serverData.code = value.responseCode;
    }
    return serverData;
  }).catch(() => {
    serverData.msg = '调用接口失败';
    return serverData;
  })
}

export function httpRequestDel(url: string) {
  url = BASE_URL + url
  let httpRequest = http.createHttp();
  var user = User.get()
  var header = {
    'Content-Type': 'application/json',
    'Authorization': user.getToken(),
  }
  let responseResult = httpRequest.request(url, {
    method: http.RequestMethod.DELETE,
    header: header
  });
  let serverData: {
    code,
    data: any,
    msg: string | Resource
  } = { code: 0, data: '', msg: '' };
  // 处理数据，并返回
  return responseResult.then((value) => {
    if (value.responseCode === 200) {
      // 获取返回数据
      let result = `${value.result}`;
      let resultJson = JSON.parse(result);
      serverData.data = resultJson.data;
      serverData.code = resultJson.code;
      serverData.msg = resultJson.msg;
    } else {
      serverData.code = value.responseCode;
    }
    return serverData;
  }).catch(() => {
    serverData.msg = '调用接口失败';
    return serverData;
  })
}

export function httpRequestPost(url: string, params: any) {
  url = BASE_URL + url
  let httpRequest = http.createHttp();
  var user = User.get()
  var header = {
    'Content-Type': 'application/json',
    'Authorization': user.getToken(),
  }
  let responseResult = httpRequest.request(url, {
    method: http.RequestMethod.POST,
    extraData: params,
    header: header
  });
  let serverData: {
    code,
    data: any,
    msg: string | Resource
  } = { code: 0, data: '', msg: '' };
  // 处理数据，并返回
  return responseResult.then((value) => {
    if (value.responseCode === 200) {
      // 获取返回数据
      let result = `${value.result}`;
      let resultJson = JSON.parse(result);
      serverData.data = resultJson.data;
      serverData.code = resultJson.code;
      serverData.msg = resultJson.msg;
    } else {
      serverData.code = value.responseCode;
    }
    return serverData;
  }).catch((e) => {
    console.log(e)
    serverData.msg = '调用接口失败';
    return serverData;
  })
}

export function httpRequestPut(url: string, params: any) {
  url = BASE_URL + url
  let httpRequest = http.createHttp();
  var user = User.get()
  var header = {
    'Content-Type': 'application/json',
    'Authorization': user.getToken(),
  }
  let responseResult = httpRequest.request(url, {
    method: http.RequestMethod.PUT,
    extraData: params,
    header: header
  });
  let serverData: {
    code,
    data: any,
    msg: string | Resource
  } = { code: 0, data: '', msg: '' };
  // 处理数据，并返回
  return responseResult.then((value) => {
    if (value.responseCode === 200) {
      // 获取返回数据
      let result = `${value.result}`;
      let resultJson = JSON.parse(result);
      serverData.data = resultJson.data;
      serverData.code = resultJson.code;
      serverData.msg = resultJson.msg;
    } else {
      serverData.code = value.responseCode;
    }
    return serverData;
  }).catch((e) => {
    console.log(e)
    serverData.msg = '调用接口失败';
    return serverData;
  })
}


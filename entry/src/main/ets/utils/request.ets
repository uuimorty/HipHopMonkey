import axios from '@ohos/axios'
import { InternalAxiosRequestConfig } from '@ohos/axios'

// 获取数据在Model层
export const request = axios.create({
  // baseURL: 'https://proapi.azurewebsites.net',
  baseURL: 'http://tools.cretinzp.com/jokes',
  timeout: 5000,
  headers: {
    uk: 'sakodkoaodmom123456',
    channel: 'certain_open_api',
    app: '1.0.0;1:10',
    device: 'HUAWEI;EMULATOR',
    project_token: '8C2E963BDEFD4B828B58FF1A1F1E9DBA'
  }
})

request.interceptors.request.use((config: InternalAxiosRequestConfig) => {
  if (AppStorage.get('token')) {
    const token = AppStorage.get('token')!
    config.headers.token = token
  }
  console.log(`===================$${config.url}==================`)
  console.log(JSON.stringify(config.params, null, 2));
  return config;
})
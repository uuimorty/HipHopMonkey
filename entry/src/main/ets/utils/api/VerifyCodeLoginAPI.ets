import { AxiosResponse } from '@ohos/axios'
import { LoginCode } from '../../dto/LoginCode'
import { request } from '../request'

/**
 * 验证码登录
 * @param code 验证码
 * @param phone 手机号
 * @returns
 */
export function VerifyCodeLoginAPI(code: string, phone: string) {
  return request.post<LoginCode>('/user/login/code', null, {
    params: {
      code, phone
    }
  })
}

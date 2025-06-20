import { LoginCode, LoginResp } from '../../dto/LoginCode'
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

/**
 * 用户账号密码登录
 * @param phoneNumber
 * @param password
 */
export function userLogin(phoneNumber: string, password: string) {
  return request.post<LoginResp>('/user/login/psw', null, {
    params: { phone: phoneNumber, psw: password }
  })
}

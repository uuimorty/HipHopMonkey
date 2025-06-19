import { VerifyCode } from '../dto/VerifyCode'
import { request } from '../utils/request'
import { AxiosResponse } from "@ohos/axios"

export default class VerifyCodeModel {
  verifyCodeResponse: VerifyCode = {}

  async getVerifyCode(phone: string) {
    try {
      const res: AxiosResponse<VerifyCode> =
        await request.post<string, AxiosResponse<VerifyCode>>('/user/login/get_code', null, {
          params: {
            phone
          }
        })
      this.verifyCodeResponse = res.data
    } catch (e) {
      console.log(e)
    }
  }
}
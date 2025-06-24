import { UserTokenData } from "../dto/VerificationCodeLogin";
import { request } from '../utils/request'
import { AxiosResponse } from "@ohos/axios"

export default class UserTokenModel {
  userTokenResponse: UserTokenData = {}

  async getUserToken() {
    try {
      const res: AxiosResponse<UserTokenData> = await request.post("/user/login/code")
      this.userTokenResponse = res.data
    } catch (e) {
      console.log(e)
    }
  }
}
import { UserToken } from "../dto/VerificationCodeLogin";
import { request } from '../utils/request'
import { AxiosResponse } from "@ohos/axios"

export default class UserTokenModel {
  userTokenResponse: UserToken = {}

  async getUserToken() {
    try {
      const res: AxiosResponse<UserToken> = await request.post("/user/login/code")
      this.userTokenResponse = res.data
    } catch (e) {
      console.log(e)
    }
  }
}
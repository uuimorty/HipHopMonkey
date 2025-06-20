import { request } from '../utils/request'
import { AxiosResponse } from "@ohos/axios"
import { AttentionUser } from '../dto/AttentionUser'

export interface attentionParams {
  status: string
  userId: string
}

export default class AttentionModel {
  attentionUserResponse: AttentionUser = {}

  /**
   * 关注用户
   * @param queryParams 请求参数 用户id+用户status
   * @returns
   */
  async attentionUser(queryParams: attentionParams) {
    try {
      const res: AxiosResponse<AttentionUser> =
        await request.post('/user/attention', null, {
          params: {
            status: queryParams.status,
            userId: queryParams.userId
          }
        })
      this.attentionUserResponse = res.data
    } catch (e) {
      console.log(e)
    }
  }
}


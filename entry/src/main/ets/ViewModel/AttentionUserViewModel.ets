import { AttentionUser } from "../dto/AttentionUser"
import AttentionModel from "../Model/AttentionUserModel"

interface paramsType {
  userId: string,
  status: string
}

@Observed
export default class GetAttentionViewModel {
  //关注状态
  @Track attentionState: number = 0
  @Track attentionUserData: AttentionUser = {}


  async loadingAttentionUserData(params: paramsType) {
    const userId = params.userId
    const status = params.status
    const attentionModel = new AttentionModel()
    await attentionModel.attentionUser({ userId, status })
    if (attentionModel.attentionUserResponse.data) {
      this.attentionUserData = attentionModel.attentionUserResponse
      this.attentionState = attentionModel.attentionUserResponse.data?.attentionState
    }
  }
}
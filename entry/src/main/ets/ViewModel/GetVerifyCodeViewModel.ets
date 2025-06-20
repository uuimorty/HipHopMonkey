//获取Model层的数据，同时，数据变化UI要刷新
import { VerifyCode } from '../dto/VerifyCode'
import VerifyCodeModel from '../Model/VerifyCodeModel'

@Observed
export default class GetVerifyCodeViewModel {
  //   验证码登录数据
  @Track VerifyCodeData: VerifyCode = {}
  @Track loading: boolean = true

  async loadVerifyCodeData(phone: string) {
    const getVerifyCodeModel = new VerifyCodeModel()
    await getVerifyCodeModel.getVerifyCode(phone)
    
    if (getVerifyCodeModel.verifyCodeResponse) {
      this.VerifyCodeData = getVerifyCodeModel.verifyCodeResponse
    }
    this.loading = false
  }
}
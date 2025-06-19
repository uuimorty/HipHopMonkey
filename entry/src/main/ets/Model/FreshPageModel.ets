import { Logger } from "@nzy/logger"
import { AxiosResponse } from "@ohos/axios"
import { FreshPage } from "../dto/FreshPage"
import { FreshPageData } from "../dto/FreshPage"
import { request } from "../utils/request"

export default class FreshPageModel {
  freshPageDataResponse: FreshPageData[] = []

  async getFreshPageData() {
    try {
      const res: AxiosResponse<FreshPage> = await request.post('/home/latest')
      if (res.data.data) {
        this.freshPageDataResponse = res.data.data
        console.log(JSON.stringify(res.data.data, null, 2))
        // Logger.info('freshPageDataResponse', JSON.stringify(this.freshPageDataResponse, null, 2))
      } else {
        throw new Error('新鲜页数据获取fail')
      }
    } catch (e) {
      console.log(e)
    }
  }
}
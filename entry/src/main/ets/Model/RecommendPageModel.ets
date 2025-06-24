import { Logger } from "@nzy/logger";
import { AxiosResponse } from "@ohos/axios";
import { RecommendData, RecommendDataItem } from "../dto/RecommendData";
import { request } from '../utils/request'

export default class RecommendPageModel {
  recommendDataResponse: RecommendDataItem[] = []
  async getRecommendData() {
    try {
      const res: AxiosResponse<RecommendData> = await request.post('/home/recommend')
      if (res.data) {
        this.recommendDataResponse = res.data.data!
      }
    } catch (e) {
      console.log(e)
    }
  }
}
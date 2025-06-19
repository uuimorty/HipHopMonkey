//获取Model层的数据，同时，数据变化UI要刷新
import { Logger } from "@nzy/logger"
import { RecommendDataItem } from "../dto/RecommendData"
import RecommendPageModel from "../Model/RecommendPageModel"

@Observed
export default class GetRecommendPageDataViewModel {
  // 推荐页数据
  @Track recommendData: RecommendDataItem[] = []
  @Track loading: boolean = true

  async loadRecommendPageData() {
    const getRecommendPageModel = new RecommendPageModel()

    await getRecommendPageModel.getRecommendData()
    
    if (getRecommendPageModel.recommendDataResponse) {
      this.recommendData = [...this.recommendData,...getRecommendPageModel.recommendDataResponse]
    }
    Logger.info(JSON.stringify(this.recommendData, null, 2))
    this.loading = false
  }
}
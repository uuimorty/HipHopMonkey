//获取Model层的数据，同时，数据变化UI要刷新
import { RecommendDataItem } from "../dto/RecommendData"
import RecommendPageModel from "../Model/RecommendPageModel"

@Observed
export default class GetRecommendPageDataViewModel {
  // 推荐页数据
  @Track recommendData: RecommendDataItem[] = []
  @Track loading: boolean = true

  async loadRecommendPageData(isFresh?: boolean) {
    const getRecommendPageModel = new RecommendPageModel()

    await getRecommendPageModel.getRecommendData()

    if (getRecommendPageModel.recommendDataResponse) {
      if (isFresh) {
        this.recommendData = getRecommendPageModel.recommendDataResponse
      } else {
        this.recommendData = [...this.recommendData, ...getRecommendPageModel.recommendDataResponse]
      }
    }
    this.loading = false
  }
}
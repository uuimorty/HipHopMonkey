import { Logger } from "@nzy/logger"
import { FreshPageData } from "../dto/FreshPage"
import FreshPageModel from "../Model/FreshPageModel"

@Observed
export default class GetFreshPageViewModel {
  @Track loading: boolean = true
  @Track FreshPageDataList: FreshPageData[] = []
  
  async loadingFreshPageData() {
    const freshPageModel = new FreshPageModel()
    await freshPageModel.getFreshPageData()

    if (freshPageModel.freshPageDataResponse) {
      this.FreshPageDataList = freshPageModel.freshPageDataResponse
    }
    Logger.info('FreshPageDataList', JSON.stringify(this.FreshPageDataList, null, 2))
    this.loading = false
  }
}
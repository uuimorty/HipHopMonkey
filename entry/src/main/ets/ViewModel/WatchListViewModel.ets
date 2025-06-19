//获取Model层的数据，同时，数据变化UI要刷新
import { Logger } from '@nzy/logger'
import { WatchListDataType, WatchListDataTypeData } from '../dto/WatchListDataType'
import WatchListModel from '../Model/WatchListModel'

@Observed
export default class GetWatchListViewModel {
  @Track watchListData: WatchListDataTypeData[] = []
  @Track loading: boolean = true

  async loadWatchListData() {
    const watchListModel = new WatchListModel()

    await watchListModel.getWatchList()
    if (watchListModel.watchListData.data) {
      this.watchListData = watchListModel.watchListData.data!
    }
    Logger.info('loading=' + this.loading)
    Logger.info(JSON.stringify(this.watchListData))
    this.loading = false
  }
}
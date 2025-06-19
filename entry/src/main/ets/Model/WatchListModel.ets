import { AxiosResponse } from "@ohos/axios";
import { WatchListDataType } from "../dto/WatchListDataType";
import { request } from '../utils/request'

export default class WatchListModel {
  watchListData: WatchListDataType = {}
  
  async getWatchList() {
    try {
      const res: AxiosResponse<WatchListDataType> =
        await request.post<WatchListDataType>('/home/attention/recommend')
      this.watchListData = res.data
    } catch (e) {
      console.log(e)
    }
  }
}
//获取Model层的数据，同时，数据变化UI要刷新
import { Logger } from '@nzy/logger'
import { MessageReq, MessageRespData } from '../dto/MessageResp'
import MessageListModel from '../Model/MessageModel'


@Observed
export default class MessageListViewModel {
  @Track data: MessageRespData[] = []
  @Track loading: boolean = true

  async getMessageListData(params:MessageReq,isRefresh?:boolean) {
    const model = new MessageListModel()
    // this.loading=true
    await model.getMessageList(params)
    if (model.resp.data) {
      if (isRefresh) {
        this.data = model.resp.data
      } else {
        this.data = [...this.data, ...model.resp.data]
      }
      Logger.info('loading=' + this.loading)
      Logger.info(JSON.stringify(this.data))
    }
    this.loading = false
  }
}
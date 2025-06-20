import { AxiosResponse } from "@ohos/axios";
import { MessageReq, MessageResp } from "../dto/MessageResp";
import { request } from '../utils/request'

export default class MessageListModel {
  resp: MessageResp = {}
  
  async getMessageList(params:MessageReq) {
    try {
      const res: AxiosResponse<MessageResp> =
        await request.post<MessageResp>('/user/message/list',null,{
          params
        })
      this.resp = res.data
    } catch (e) {
      console.log(e)
    }
  }
}
import { AxiosResponse } from "@ohos/axios";
import { request } from "../request";

export class reportParamsType {
  content: string
  report_tips: string
  target_id: string
  type: '0' | '1'

  constructor(content: string, report_tips: string, target_id: string, type: '0' | '1') {
    this.content = content;
    this.report_tips = report_tips;
    this.target_id = target_id;
    this.type = type;
  }
}

export  interface resultType {
  data: string,
  msg: string
  code: number
}

/**
 * 举报用户或者举报段子
 * @param params
 * @returns
 */
export function reportUserOrContentApi(params: reportParamsType) {
  return request.post<string, AxiosResponse<resultType>>('/helper/report', null, {
    params: {
      content: params.content,
      report_tips: params.report_tips,
      target_id: params.target_id,
      type: params.type
    }
  })
}
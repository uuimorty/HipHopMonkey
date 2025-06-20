import { Issues } from "../dto/Issues";
import { request } from '../utils/request'
import { AxiosResponse } from "@ohos/axios"

export default class IssuesModel {
  issuesResponse: Issues = {}

  async getIssues() {
    try {
      const res: AxiosResponse<Issues> = await request.get("/github/issues")
      this.issuesResponse = res.data
    } catch (e) {
      console.log(e)
    }
  }
}
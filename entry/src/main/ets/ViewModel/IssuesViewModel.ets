//获取Model层的数据，同时，数据变化UI要刷新
import { IssuesData } from "../dto/Issues";
import IssuesModel from "../Model/IssuesModel";

@Observed
export default class IssuesViewModel {
  // 列表数据 (使用Track)
  @Track loading: boolean = true
  @Track IssuesData: IssuesData[] = []

  async loadIssuesData() {
    const issuesModel = new IssuesModel()
    
    await issuesModel.getIssues()

    if (issuesModel.issuesResponse.data) {
      this.IssuesData = issuesModel.issuesResponse.data
    }
    this.loading = false
  }
}
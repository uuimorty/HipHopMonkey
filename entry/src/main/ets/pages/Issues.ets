import { IssuesData } from '../dto/Issues';
import IssuesModel from '../Model/IssuesModel';
import IssuesViewModel from '../ViewModel/IssuesViewModel';

@Entry
@Component
struct Issues {
  @State message: string = 'Issues';
  @State issuesViewModel: IssuesViewModel = new IssuesViewModel()

  aboutToAppear(): void {
    this.issuesViewModel.loadIssuesData()
  }

  build() {
    Column() {
      if (this.issuesViewModel.loading) {
        Text(`加载中`)
      } else {
        ForEach(this.issuesViewModel.IssuesData, (issues: IssuesData) => {
          Row() {
            Text(issues.title)
          }
        })
      }
    }
    .height('100%')
    .width('100%')
  }
}
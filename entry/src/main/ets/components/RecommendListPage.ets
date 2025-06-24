import { IBestLoading } from "@ibestservices/ibest-ui"
import { RecommendDataItem } from "../dto/RecommendData"
import GetRecommendPageDataViewModel from "../ViewModel/RecommendPageViewModel"
import { recommendListCard } from "./recommendListCard";

@Component
export struct RecommendListPage {
  // 这里一定要用@state装饰
  @State recPageDataViewModel: GetRecommendPageDataViewModel = new GetRecommendPageDataViewModel()
  @State isLoading: boolean = this.recPageDataViewModel.loading
  @State refreshing: boolean = false;
  @State commonSheetIsShow: boolean = false
  @State bindSheetIsShow: boolean = false
  @Provide recommendDataList: RecommendDataItem[] = []

  async onRefresh() {
    // 重新加载数据
    await this.recPageDataViewModel.loadRecommendPageData(true)
    this.isLoading = this.recPageDataViewModel.loading
    this.refreshing = this.recPageDataViewModel.loading
  }

  async aboutToAppear(): Promise<void> {
    await this.recPageDataViewModel.loadRecommendPageData()
    this.recommendDataList = this.recPageDataViewModel.recommendData
  }

  @Builder
  Main() {
    Refresh({ refreshing: $$this.refreshing }) {

      List() {
        ForEach(this.recommendDataList, (item: RecommendDataItem, index: number) => {
          ListItem() {
            recommendListCard({ item, index })
          }.width('100%')
        })
      }
      .scrollBar(BarState.Off)
      .width('100%')
      .height('100%')
      .backgroundColor(0xf8f8f8)
      .onScrollIndex((start, end, center) => {
        if (center === this.recPageDataViewModel.recommendData.length - 7) {
          console.log('current index', center + '-' + this.recPageDataViewModel.recommendData.length)
          this.recPageDataViewModel.loadRecommendPageData()
        }
      })
    }
    .onRefreshing(() => {
      this.onRefresh()
    })

  }

  build() {
    Column() {
      if (this.recPageDataViewModel.loading) {
        Column() {
          IBestLoading({ loadingText: '玩命加载中...', loadingTextFontSize: 18, loadingSize: 30 })
        }.width('100%').height('100%').justifyContent(FlexAlign.Center)
      } else {
        this.Main()
      }
    }
    .width('100%')
    .height('100%')
  }
}
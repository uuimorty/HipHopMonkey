import { IBestPullRefresh, IBestLoading } from "@ibestservices/ibest-ui";
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
  private scroll: Scroller = new Scroller()
  private controller: VideoController = new VideoController()

  @Builder
  myBindSheet() {
    Column() {
      Text('bindSheet').fontSize(30)
    }
    .width('100%')
    .height('100%')
    .padding({
      top: 16,
      bottom: 16
    })
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Start)
  }

  async onRefresh() {
    // 重新加载数据
    await this.recPageDataViewModel.loadRecommendPageData(true)
    this.isLoading = this.recPageDataViewModel.loading
    this.refreshing = this.recPageDataViewModel.loading
  }

  aboutToAppear(): void {
    this.recPageDataViewModel.loadRecommendPageData()
  }

  @Builder
  Main() {
    Refresh({ refreshing: $$this.refreshing }) {
      List() {
        ForEach(this.recPageDataViewModel.recommendData, (item: RecommendDataItem) => {
          ListItem() {
            recommendListCard({ item })
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
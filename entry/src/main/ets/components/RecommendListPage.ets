import { IBestPullRefresh,IBestLoading } from "@ibestservices/ibest-ui";
import { IBestLoading } from "@ibestservices/ibest-ui";
import { RecommendDataItem } from "../dto/RecommendData"
import GetRecommendPageDataViewModel from "../ViewModel/RecommendPageViewModel"
import { recommendListCard } from "./recommendListCard";

@Extend(Row)
function actionItemStyle() {
  .layoutWeight(1).justifyContent(FlexAlign.Center).alignItems(VerticalAlign.Center)
}

@Component
export struct RecommendListPage {
  // 这里一定要用@state装饰
  @State recPageDataViewModel: GetRecommendPageDataViewModel = new GetRecommendPageDataViewModel()
  @State isLoading: boolean = this.recPageDataViewModel.loading
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

  @Builder
  commonBindSheet() {
    Column() {
      Text('commonSheetIsShow').fontSize(30)
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

  onRefresh() {
    //   返回页面顶部
    this.scroll.scrollTo({ xOffset: 0, yOffset: 0 })
    // 重新加载数据
    this.recPageDataViewModel.loadRecommendPageData()
    this.isLoading = this.recPageDataViewModel.loading
  }

  aboutToAppear(): void {
    this.recPageDataViewModel.loadRecommendPageData()
  }

  @Builder
  Main() {
    List() {
      ForEach(this.recPageDataViewModel.recommendData, (item: RecommendDataItem) => {
        ListItem() {
          this.recommendListCard(item)
        }.width('100%')
        .bindSheet($$this.commonSheetIsShow, this.commonBindSheet(), {
          width: '100%',
          height: 300,
          enableOutsideInteractive: true, //允许交互，不显示蒙层
          blurStyle: BlurStyle.Regular,
          title: { title: '评论区', subtitle: '欢迎留下你的评论' }
        })

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

  build() {
    Column() {
      if (this.recPageDataViewModel.loading) {
        Column() {
          IBestLoading({ loadingText: '玩命加载中...', loadingTextFontSize: 18, loadingSize: 30 })
        }.width('100%').height('100%').justifyContent(FlexAlign.Center)
      } else {
        IBestPullRefresh({
          loading: $isLoading,
          scroller: this.scroll,
          defaultContent: (): void => this.Main(),
          onRefresh: (): void => this.onRefresh(),
          successText: '刷新成功',
          slideUpSuccessText: '加载成功',
          slideUpSuccessDuration: 300,
          successDuration: 300
        })
      }
    }
    .bindSheet($$this.bindSheetIsShow, this.myBindSheet(), {
      width: '100%',
      height: 300,
      enableOutsideInteractive: true, //允许交互，不显示蒙层
      blurStyle: BlurStyle.Regular,
      title: { title: '分享', subtitle: '分享给你的好友吧' }
    })
    .width('100%')
    .height('100%')
  }
}
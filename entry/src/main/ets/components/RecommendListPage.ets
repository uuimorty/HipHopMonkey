import { IBestPullRefresh } from "@ibestservices/ibest-ui";
import { IBestLoading } from "@ibestservices/ibest-ui";
import { RecommendDataItem } from "../dto/RecommendData"
import GetRecommendPageDataViewModel from "../ViewModel/RecommendPageViewModel"

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
  actionBottomBar(item: RecommendDataItem) {
    //   底部分享栏
    Row() {
      Row({ space: 10 }) {
        SymbolGlyph($r('sys.symbol.face_smiling')).fontSize(24)
        Text(item.info?.likeNum?.toString())
      }
      .actionItemStyle()


      Row({ space: 10 }) {
        SymbolGlyph($r('sys.symbol.capture_smiles')).fontSize(24)
        Text(item.info?.disLikeNum?.toString())
      }.actionItemStyle()

      Row({ space: 10 }) {
        SymbolGlyph($r('sys.symbol.message')).fontSize(24)
        Text(item.info?.commentNum?.toString())
      }.actionItemStyle()
      .onClick(() => {
        this.commonSheetIsShow = true
      })

      Row({ space: 10 }) {
        SymbolGlyph($r('sys.symbol.share')).fontSize(24)
        Text(item.info?.shareNum?.toString())
      }.actionItemStyle()
      .onClick(() => {
        this.bindSheetIsShow = true
      })
    }
    .width('100%')
    .height(60)
    .justifyContent(FlexAlign.SpaceBetween)
  }

  @Builder
  recommendListCard(item: RecommendDataItem) {
    Column() {
      // 用户数据
      Row({ space: 14 }) {
        Image(item.user?.avatar).width(50).height(50).borderRadius(50)
        Column({ space: 6 }) {
          Text(item.user?.nickName)
          Text(item.user?.signature).fontSize(12)
        }
        .height(50)
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)
        .justifyContent(FlexAlign.Center)

        Row({ space: 4 }) {
          Button('+  关注')
            .backgroundColor(Color.Transparent)
            .fontColor(0xdcac89)
            .fontSize(18)
          Text('···').fontColor(0x333).fontSize(16).fontWeight(FontWeight.Bold)
        }
        .height(50)
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
      }
      .height(50)
      .justifyContent(FlexAlign.SpaceBetween)
      .width('100%')

      // 段子内容
      Row() {
        Text(item.joke?.content).lineHeight(24)
      }
      .width('100%')
      .margin({ top: 10, bottom: 10 })

      // 视频
      if (item.joke?.videoUrl) {
        Video({
          src: 'https://cdn.plyr.io/static/demo/View_From_A_Blue_Moon_Trailer-720p.mp4',
          controller: this.controller,
          previewUri: 'https://cdn.plyr.io/static/demo/View_From_A_Blue_Moon_Trailer-HD.jpg'
        })
          .width('100%')
          .borderRadius(10)
          .height(300)
          .autoPlay(false)// 设置是否自动播放
          .loop(false) // 设置是否循环播放
      }

      this.actionBottomBar(item)
    }
    .width('100%')
    .padding({
      top: 10,
      bottom: 10,
      left: 12,
      right: 12
    })
    .margin({
      bottom: 16
    })
    .backgroundColor(Color.White)
  }

  @Builder
  Main() {
    Scroll(this.scroll) {
      Column() {
        ForEach(this.recPageDataViewModel.recommendData, (item: RecommendDataItem) => {
          this.recommendListCard(item)
        })
      }
      .width('100%')
      .bindSheet($$this.commonSheetIsShow, this.commonBindSheet(), {
        width: '100%',
        height: 300,
        enableOutsideInteractive: true, //允许交互，不显示蒙层
        blurStyle: BlurStyle.Regular,
        title: { title: '评论区', subtitle: '欢迎留下你的评论' }
      })
    }
    .scrollBar(BarState.Auto)
    .width('100%')
    .height('100%')
    .backgroundColor(0xf8f8f8)
    
    // .onScrollIndex((start,end,center)=>{
    // if (center===this.recommendJokesViewModel.data.length-7) {
    //   console.log('current index',center+'-'+this.recommendJokesViewModel.data.length)
    //   this.recommendJokesViewModel.loadRecommendJokesData()
    // }
    // })
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
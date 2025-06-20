import { RecommendDataItem } from '../dto/RecommendData'

@Extend(Row)
function actionItemStyle() {
  .layoutWeight(1).justifyContent(FlexAlign.Center).alignItems(VerticalAlign.Center)
}

@ComponentV2
export struct recommendListCard {
  @Param item: RecommendDataItem = {}
  private scroll: VideoController = new VideoController()

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

      Row({ space: 10 }) {
        SymbolGlyph($r('sys.symbol.share')).fontSize(24)
        Text(item.info?.shareNum?.toString())
      }
    }
    .width('100%')
    .height(60)
    .justifyContent(FlexAlign.SpaceBetween)
  }

  build() {
    Column() {
      // 用户数据
      Row({ space: 14 }) {
        Image(this.item.user?.avatar).width(50).height(50).borderRadius(50)
        Column({ space: 6 }) {
          Text(this.item.user?.nickName)
          Text(this.item.user?.signature).fontSize(12)
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
        Text(this.item.joke?.content).lineHeight(24)
      }
      .width('100%')
      .margin({ top: 10, bottom: 10 })

      // 视频
      if (this.item.joke?.videoUrl) {
        Video({
          src: 'https://cdn.plyr.io/static/demo/View_From_A_Blue_Moon_Trailer-720p.mp4',
          controller: this.scroll,
          previewUri: 'https://cdn.plyr.io/static/demo/View_From_A_Blue_Moon_Trailer-HD.jpg'
        })
          .width('100%')
          .borderRadius(10)
          .height(300)
          .autoPlay(false)// 设置是否自动播放
          .loop(false) // 设置是否循环播放
      }
      this.actionBottomBar(this.item)
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
}

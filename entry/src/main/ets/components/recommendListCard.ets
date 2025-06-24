import { IBestCell, IBestCellGroup, IBestPopup, IBestToast } from '@ibestservices/ibest-ui'
import { Logger } from '@nzy/logger'
import { AxiosResponse } from '@ohos/axios'
import { AttentionUser } from '../dto/AttentionUser'
import { RecommendDataItem } from '../dto/RecommendData'
import { reportJokesParamsType } from '../types/common'
import { attentionUserApi, attentionUserParams } from '../utils/api/attentionUserApi'
import { reportParamsType, reportUserOrContentApi, resultType } from '../utils/api/reportUserOrPiece'

@Extend(Row)
function actionItemStyle() {
  .layoutWeight(1).justifyContent(FlexAlign.Center).alignItems(VerticalAlign.Center)
}

@Extend(Row)
function popChoice() {
  .width('100%')
  .height(50)
  .justifyContent(FlexAlign.Center)
}

// 功能列表 项
@Component
export struct recommendListCard {
  @State index: number = -1
  @State item: RecommendDataItem = new RecommendDataItem()
  videoScroll: VideoController = new VideoController()

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

  @Builder
  pieceContent() {
    // 段子内容
    Row() {
      Text(this.item.joke?.content).lineHeight(24)
    }
    .width('100%')
    .margin({ top: 10, bottom: 10 })
  }

  @Builder
  videoPlayBox() {
    // 视频播放
    if (this.item.joke?.videoUrl) {
      Video({
        src: 'https://cdn.plyr.io/static/demo/View_From_A_Blue_Moon_Trailer-720p.mp4',
        controller: this.videoScroll,
        previewUri: 'https://cdn.plyr.io/static/demo/View_From_A_Blue_Moon_Trailer-HD.jpg'
      })
        .width('100%')
        .borderRadius(10)
        .height(300)
        .autoPlay(false)// 设置是否自动播放
        .loop(false) // 设置是否循环播放
    }
  }

  build() {
    Column() {
      // 用户信息
      userInfoBuilder({ item: this.item, index: this.index })
      // 段子内容
      this.pieceContent()

      // 视频播放
      this.videoPlayBox()

      // 操作栏
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

// 关注按钮
@Component
export struct FollowingButton {
  @State item: RecommendDataItem = new RecommendDataItem()
  @State isAttention: boolean = false
  @State userId: string = ''

  aboutToAppear(): void {
    this.isAttention = this.item.info?.isAttention!
    this.userId = this.item.user?.userId?.toString()!
  }

  build() {
    Button(this.isAttention ? "已关注" : '+ 关注')
      .fontColor(this.isAttention ? Color.Gray : Color.Black)
      .width(70)
      .height(40)
      .backgroundColor(Color.White)
      .border({ width: 1, color: this.isAttention ? 0Xe1c8ae : 0x777777, radius: 30 })
      .onClick(async () => {
        Logger.info('点击了关注按钮')
        //   todo 发送关注请求  响应成功之后修改数据 视图数据同步刷新
        attentionUserApi(new attentionUserParams(this.userId, this.isAttention ? '0' : '1'))
          .then((res: AxiosResponse<AttentionUser>) => {
            console.log(JSON.stringify(res.data))
            if (res.data.data?.attentionState === 0) {
              this.isAttention = false
            } else {
              this.isAttention = true
            }
          })
      })
  }
}


// 卡片上方用户信息

@Component
struct userInfoBuilder {
  @Consume('navPathStack') navPathStack: NavPathStack
  @State item: RecommendDataItem = new RecommendDataItem()
  @State downVisible: boolean = false
  @Consume('recommendDataList') recommendDataList: RecommendDataItem[]
  @Link index: number

  // 关闭弹窗
  closePopup() {
    this.downVisible = false
  }

  @Builder
  popContent(item: RecommendDataItem) {

    Column() {
      Row() {
        Text('举报此发布者')
      }
      .popChoice()
      .onClick(() => {
        const params: reportJokesParamsType = {
          content: this.item.joke?.content,
          target_id: this.item.user?.userId?.toString()
        }
        this.navPathStack.pushPath({ name: 'ReportJokeUser', param: params })
        this.closePopup()
      })


      Row() {
        Text('举报此内容')
      }
      .popChoice()
      .border({ color: '#666', width: { top: 1, bottom: 1 }, style: BorderStyle.Solid })
      .onClick(() => {
        const params: reportJokesParamsType = {
          // 举报的内容
          content: this.item.joke?.content,
          // 段子id
          target_id: this.item.joke?.jokesId?.toString()
        }
        this.navPathStack.pushPath({ name: 'ReportJokeContent', param: params })
        this.closePopup()
      })

      Row() {
        Text('对此不感兴趣')
      }
      .popChoice()
      .onClick(() => {
        // 隐藏该项卡片
        this.closePopup()
        // Logger.info('index=' + this.index)
        // Logger.info(JSON.stringify(this.recommendDataList, null, 2))
        this.recommendDataList.splice(this.index, 1)
      })

      Row() {
      }
      .width('100%').height(10).backgroundColor('#999999')

      Row() {
        Text('取消')
      }
      .margin({ top: 10 })
      .popChoice()
      .onClick(() => {
        this.closePopup()
      })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.SpaceAround)
    .alignItems(HorizontalAlign.Center)
  }

  build() {
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
        // 关注按钮
        FollowingButton({ item: this.item })
        // 点击举报
        Text('···').fontColor(0x333).fontSize(16).fontWeight(FontWeight.Bold)
          .onClick(() => {
            this.downVisible = true
          })
      }
      .height(50)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)

      IBestPopup({
        visible: $downVisible,
        popupAlign: "bottom",
        cornerRadius: 10,
        popupHeight: 250,
        contentBuilder: () => this.popContent(this.item),
        safeAreaInsetBottom: true
      })
    }
    .height(50)
    .justifyContent(FlexAlign.SpaceBetween)
    .width('100%')

  }
}


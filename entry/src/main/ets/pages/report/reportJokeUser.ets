import { IBestButton, IBestNavBar, IBestToast } from "@ibestservices/ibest-ui"
import { LengthMetrics } from "@kit.ArkUI"
import { Logger } from "@nzy/logger"
import { AxiosResponse } from "@ohos/axios"
import { reportJokesParamsType } from "../../types/common"
import { reportParamsType, reportUserOrContentApi, resultType } from "../../utils/api/reportUserOrPiece"


@Component
export struct repostJokeUser {
  @Consume('navPathStack') navPathStack: NavPathStack
  @State reportTypes: string[] = ['淫秽头像', '反动昵称', '人身攻击', '消息骚扰', '泄漏隐私', '垃圾营销']
  // 举报的描述
  @State isActiveItem: string = ''
  // 举报的内容
  @State reportContent: string = ''
  @State navPathStackParam: reportJokesParamsType = {}

  aboutToAppear(): void {
    this.navPathStackParam = this.navPathStack.getParamByName('ReportJokeUser')[0] as reportJokesParamsType
  }

  build() {
    NavDestination() {
      Column() {
        IBestNavBar({
          title: "举报用户",
          isShowBorder: true,
          onLeftClick: () => {
            this.navPathStack.pop()
          }
        })
        Column() {
          Column() {
            Text('举报类型').fontWeight(FontWeight.Bold).width('100%').height(50).textAlign(TextAlign.Start)
            Flex({ wrap: FlexWrap.Wrap, space: { main: LengthMetrics.vp(10), cross: LengthMetrics.vp(12) } }) {
              ForEach(this.reportTypes, (item: string) => {
                Text(item)
                  .width(100)
                  .textAlign(TextAlign.Center)
                  .height(40)
                  .border({ radius: 10, color: this.isActiveItem === item ? Color.Red : Color.Black, width: 1 })
                  .onClick(() => {
                    this.isActiveItem = item
                  })
              })
            }
          }.width('100%')

          Column() {
            Text('举报详情').fontWeight(FontWeight.Bold).width('100%').height(50).textAlign(TextAlign.Start)
            TextArea({ placeholder: '请输入举报内容', text: $$this.reportContent }).width('100%').height(160)
          }.width('100%')

          IBestButton({
            text: '举报',
            type: 'primary',
            plain: true,
            btnWidth: '100%',
            btnHeight: 40,
            onBtnClick: () => {
              // 举报发布者
              reportUserOrContentApi(new reportParamsType(this.reportContent, this.isActiveItem,
                this.navPathStackParam.target_id,
                '1'))
                .then((res: AxiosResponse<resultType>) => {
                  console.log(JSON.stringify(res.data, null, 2))
                  if (res.data.code === 200) {
                    //举报用户成功
                    IBestToast.show({
                      type: "success",
                      message: "举报成功"
                    })
                    this.navPathStack.pop()
                  } else {
                    //举报失败
                    IBestToast.show({
                      type: "success",
                      message: "举报失败 请重试"
                    })
                    this.navPathStack.pop()
                  }
                })
            }
          }).margin({ top: 20 })
        }
        .width('100%')
        .layoutWeight(1)
        .padding({ left: 16, right: 16 })
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')
      .height('100%')
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .defaultNavDestinationStyle()
  }
}

@Builder
export function repostJokeUserBuilder() {
  repostJokeUser()
}

@Extend(NavDestination)
function defaultNavDestinationStyle() {
  .hideTitleBar(true)
  .hideBackButton(true)
  .hideToolBar(true)
}
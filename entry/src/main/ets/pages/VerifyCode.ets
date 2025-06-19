import { IBestPasswordInput } from '@ibestservices/ibest-ui'
import { AxiosResponse } from '@ohos/axios'
import { LoginCode } from '../dto/LoginCode'
import { VerifyCodeLoginAPI } from '../utils/api/VerifyCodeLoginAPI'

@Preview
@Component
struct VerifyCode {
  @Consume navPathStack: NavPathStack
  @State phone: string = ''
  @State verifyCodeValue: string = ''

  @Builder
  cannotLogin() {
    Row() {
      SymbolGlyph($r('sys.symbol.xmark')).fontSize(24)
      Text(`无法登录?`).fontColor('#a6a6a6').fontSize(20)
    }
    .width('100%')
    .height(60)
    .justifyContent(FlexAlign.SpaceBetween)
  }

  aboutToAppear() {
    // 在组件出现前获取参数，确保尽早获取
    // console.log('传递过来的手机号参数=', this.navPathStack.getParamByName("VerifyCode").toString())
    this.phone = this.navPathStack.getParamByName("VerifyCode").toString()
  }

  build() {
    NavDestination() {
      Column() {
        this.cannotLogin()
        Column({ space: 12 }) {
          Text('请输入验证码').fontWeight(FontWeight.Bold).fontSize(32)
            .width('100%').textAlign(TextAlign.Start)

          Row({ space: 18 }) {
            Text() {
              Span('已经发送至')
              Span(this.phone) // 这里正常显示是因为每次渲染都会更新
            }
            .fontColor(0x999999)

            Text('重新发送')
          }
          .width('100%')
        }
        .width('100%')
        .margin({ top: 10, bottom: 10 })
        .justifyContent(FlexAlign.Start)
        .alignItems(HorizontalAlign.Center)

        // 验证码输入框
        IBestPasswordInput({
          value: $verifyCodeValue,
          isHidden: false,
          isHighlightCurrent: true,
          autoFocus: true,
          showCursor: true,
          useSystemKeyboard: true
        }).margin({
          top: 30,
          bottom: 30
        })

        Button(`验证码登录`)
          .width('100%')
          .height(60)
          .onClick(() => {
            console.log('用户点击了验证码登录按钮 this.phone', this.phone)
            console.log('用户点击了验证码登录按钮 this.verifyCodeValue', this.verifyCodeValue)
            VerifyCodeLoginAPI(this.verifyCodeValue, this.phone)
              .then((res: AxiosResponse<LoginCode>) => {
                console.log(JSON.stringify(res.data, null, 2))
                // 登陆成功之后的逻辑
                if (res.data.code === 200) {
                  // 将Token 和用户信息 进行全局持久化存储
                  AppStorage.set('token', res.data.data?.token)
                  AppStorage.set('userInfo', res.data.data?.userInfo)
                  this.navPathStack.pushPath({ name: 'Index' })
                }
              })
          })
      }
      .height('100%')
      .width('100%')
      .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
      .linearGradient({
        direction: GradientDirection.Left,
        repeating: true,
        colors: [[0xe4f3fe, 0.0], [0xeaf7f8, 0.5], [0xf6fcec, 1.0]]
      })
      .padding({
        left: 16,
        right: 16
      })
    }
    .hideTitleBar(true)
    .hideBackButton(true)
    .hideToolBar(true)
  }
}

@Builder
function VerifyCodeBuilder() {
  VerifyCode()
}
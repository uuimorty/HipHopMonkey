import { IBestPopup } from "@ibestservices/ibest-ui";
import { Logger } from "@nzy/logger";
import GetVerifyCodeViewModel from "../ViewModel/GetVerifyCodeViewModel";
import { router } from "@kit.ArkUI";

function getIsCanSend(phone: string) {
  if (phone.length === 11) {
    return true
  } else {
    return false
  }
}

@Component
struct Login {
  @State phoneNumber: string = ''
  @Consume isAgreeLicense: boolean //是否同意协议
  @State upVisible: boolean = false //隐藏弹出层
  @State verifyCodeViewModel: GetVerifyCodeViewModel = new GetVerifyCodeViewModel()
  @Consume navPathStack: NavPathStack
  // 判断发送验证码按钮是否启用
  @State isSend: boolean = false;

  build() {
    NavDestination() {
      Column() {
        cannotLogin()
        pleaseInputPhoneNumber()
        this.phoneForm()
        anotherLoginMethod()
        // 弹出层
        IBestPopup({
          visible: this.upVisible,
          popupAlign: "bottom",
          contentBuilder: () => this.popCustomerContent(this),
          headerBuilder: () => this.popCustomerHeader(this),
          isShowHeader: true,
          cornerRadius: 10
        })
      }
      .height('100%')
      .width('100%')
      .linearGradient({
        direction: GradientDirection.Left, // 渐变方向
        repeating: true, // 渐变颜色是否重复
        colors: [[0xe4f3fe, 0.0], [0xeaf7f8, 0.5], [0xf6fcec, 1.0]] // 数组末尾元素占比小于1时满足重复着色效果
      })
      .padding({
        left: 16,
        right: 16
      })
      .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
    }.hideTitleBar(true)
    .hideBackButton(true)
    .hideToolBar(true)
    .onBackPressed((): boolean => {
      router.back();
      return true;
    })
  }

  // 自定义表单UI组件
  @Builder
  phoneForm() {
    Column({ space: 18 }) {
      Row() {
        Select([{
          value: '+86'
        }, {
          value: '+11'
        }, {
          value: '+45'
        }, {
          value: '+47'
        }]).value('+86')
          .backgroundColor(Color.Transparent)
        TextInput({
          text: $$this.phoneNumber,
          placeholder: '请输入手机号',
        }).maxLength(11)
          .type(InputType.PhoneNumber)
          .backgroundColor(Color.Transparent)
          .onChange((value: string) => {
            this.isSend = getIsCanSend(value)
          })
      }
      .width('100%')
      .height(60)
      .backgroundColor('#f7f7f7')
      .padding({ left: 10, right: 10 })
      .borderRadius(24)

      Button(`获取短信验证码`, { stateEffect: this.isSend })
        .opacity(this.isSend ? 1 : 0.4)
        .width('100%')
        .height(60)
        .onClick(() => {
          if (!this.isAgreeLicense) {
            this.upVisible = true
          } else {
            if (this.isSend) {
              // 发送获取验证码的请求
              this.verifyCodeViewModel.loadVerifyCodeData(this.phoneNumber).then(() => {
                Logger.info(JSON.stringify(this.verifyCodeViewModel.VerifyCodeData, null, 2))
                // 验证码获取成功，跳转到验证码填写页
                if (this.verifyCodeViewModel.VerifyCodeData.code === 200) {
                  this.navPathStack.pushPath({ name: 'VerifyCode', param: this.phoneNumber })
                }
              })
            }
          }
        })

      Text('密码登录').fontColor('#979797')
        .onClick(() => {
          // 调用账号密码登录
          this.navPathStack.pushPath({ name: "LoginPwd" })
        })

      Row() {
        Checkbox().width(16).height(16).select($$this.isAgreeLicense)
        Text() {
          Span('我已经阅读并同意')
          Span(`《用户协议》`).fontColor('#75cafe')
          Span(`《隐私政策》`).fontColor('#75cafe')
        }.fontSize(14)
      }

    }.margin({
      top: 30
    })
  }

  @Builder
  popCustomerContent(component: Login) {
    Column({ space: 12 }) {
      Row({ space: 8 }) {
        Text(`《用户协议》`).fontColor('#75cafe')
        Text(`《隐私政策》`).fontColor('#75cafe')
      }

      Row() {
        Text(`《天翼账号认证股务条款》`).fontColor('#75cafe')
      }

      Button(`同意并继续`)
        .width('100%').height(45).margin({ top: 10 })
        .onClick(() => {
          component.upVisible = false
          component.isAgreeLicense = true
        })
    }
    .width('100%')
    .height('90%')
    .padding({
      left: 16,
      right: 16
    })
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  popCustomerHeader(component: Login) {
    Row({ space: 12 }) {
      SymbolGlyph($r('sys.symbol.xmark'))
        .onClick(() => {
          component.upVisible = false
        })
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .position({ left: 0, top: '50%' })
        .translate({ y: '-50%' })
      Text(`请阅读并同意以下条款`).fontSize(22).fontWeight(FontWeight.Bold)
    }
    .width('100%')
    .height(60)
    .padding({
      left: 16,
      right: 16
    })
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .border({ width: { bottom: 1 }, color: "#ececec" })
  }
}


@Builder
function cannotLogin() {
  Row() {
    SymbolGlyph($r('sys.symbol.xmark')).fontSize(24)
    Text(`无法登录?`).fontColor('#a6a6a6').fontSize(20)

  }.width('100%').height(60)
  .justifyContent(FlexAlign.SpaceBetween)
}

@Builder
function pleaseInputPhoneNumber() {
  Column({ space: 12 }) {
    Text(`请输入手机号`).fontWeight(FontWeight.Bold).fontSize(30)
    Text(`未注册的手机号验证后将自动注册`).fontSize(14).fontColor('#a6a6a6')
  }
  .width('100%')
  .margin({
    top: 20,
    bottom: 20
  })
  .alignItems(HorizontalAlign.Start)
}

@Builder
function anotherLoginMethod() {
  Row({ space: 18 }) {
    Image($r('app.media.wechatLogo')).logo()
    Image($r('app.media.QQLogo')).logo()
    Image($r('app.media.appleLogo')).logo()
  }
  .height(60)
  .width('100%')
  .position({
    bottom: 18,
    left: '50%'
  })
  .translate({ x: '-50%' })
  .justifyContent(FlexAlign.Center)
}

@Styles
function logo() {
  .width(50)
  .height(50)
  .border({ width: 2, color: '#ececec' })
  .padding(10)
  .borderRadius('50%')
}

@Builder
export function LoginPageBuilder() {
  Login()
}
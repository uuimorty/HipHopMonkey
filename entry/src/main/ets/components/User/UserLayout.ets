import { AppointUserData } from '../../dto/User'
import { CommonModifier } from '@kit.ArkUI'
import { UserMarkImage } from './UserMarkImage'

@Component
export default struct UserLayout {
  @Consume navPathStack: NavPathStack
  @State visible: boolean = false
  @Prop userViewModel: AppointUserData = {}
  @Prop tabActiveIndex: number = 0
  @State activeIndex: number = 0
  private tabBarModifier: CommonModifier = new CommonModifier()
  private tabsController: TabsController = new TabsController()
  private tabsControllerOne: TabsController = new TabsController()
  @Link isActiveTool: boolean

  aboutToAppear(): void {
    this.tabBarModifier.align(Alignment.Start)
    this.tabsControllerOne.changeIndex(this.tabActiveIndex)
  }

  @Builder
  tabItem(text: string, index: number) {
    Row() {
      Text(text)
        .fontColor(this.activeIndex === index ? "#ffe94f20" : "#999")
        .fontSize(13)
        .hitTestBehavior(HitTestMode.None)
    }
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .borderRadius("5%")
    .backgroundColor(this.activeIndex === index ? "#ffececec" : Color.Transparent)
    .padding(3)
    .margin({ left: 20 })
    .onClick(() => {
      this.activeIndex = index
      this.tabsController.changeIndex(index)
      console.log("我点击", this.activeIndex, index)
    })
  }

  build() {
    Column() {

      Row() {
        Image(this.userViewModel.avatar)
          .width("100%")
          .height("100%")
          .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP])
      }.width("100%").height(125).backgroundColor("#fff").clip(false)

      Column() {
        Row() {
          Row() {
            Image(this.userViewModel.avatar).width("100%").onClick(() => {
              this.visible = true
            })
          }
          .borderWidth(1)
          .borderColor("#ccc")
          .borderRadius("50%")
          .height(60)
          .width(60)
          .margin({ top: -20 })

          Row() {
            Text("编辑资料").fontColor("#fff65425")
          }
          .justifyContent(FlexAlign.Center)
          .width(100)
          .height(35)
          .borderRadius("15%")
          .borderWidth(1)
          .borderColor("#fff65425")
          .margin({ top: 10 })
        }
        .width("100%")
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        Column() {
          Text(this.userViewModel.nickname).fontSize(18)
          Text() {
            Span("入驻嘻哈猴： ")
            Span(this.userViewModel.joinTime)
          }.fontSize(13).fontColor("#999").margin({ top: 5 })
        }.alignItems(HorizontalAlign.Start).width("100%").margin({ top: 10 })

        Text(this.userViewModel.sigbature).margin({ top: 20 }).fontWeight(300).fontSize(15)
        Row() {
          Text() {
            Span(this.userViewModel.likeNum).fontSize(16).fontWeight(500)
            Span(" 获赞").fontWeight(300)
          }

          Text() {
            Span(this.userViewModel.attentionNum).fontWeight(500)
            Span(" 关注").fontWeight(300)
          }.onClick(() => {
            this.navPathStack.pushPath({ name: "UserConcerned", param: this.userViewModel.userId })
          })

          Text() {
            Span(this.userViewModel.fansNum).fontWeight(500)
            Span(" 粉丝").fontWeight(300)
          }
        }.width(250).justifyContent(FlexAlign.SpaceBetween).margin({ top: 16 })

      }.padding({ left: 20, right: 20 }).alignItems(HorizontalAlign.Start)

      Tabs({ controller: this.tabsControllerOne, index: this.tabActiveIndex }) {
        TabContent() {
          Tabs({ barModifier: this.tabBarModifier, controller: this.tabsController, index: this.activeIndex }) {
            TabContent() {
              Text("内容1")
            }
            .tabBar(this.tabItem("文字·图片", 0))

            TabContent() {

            }.tabBar(this.tabItem("视频", 1))
          }
          .barMode(BarMode.Scrollable)
          .barHeight(35)
          .divider({ color: "#ccc", strokeWidth: 1 })

        }.tabBar(`作品 ${this.userViewModel.jokesNum}`).align(Alignment.Start)

        TabContent() {
          // Row() {
          Row() {
            Tabs({ barModifier: this.tabBarModifier, controller: this.tabsController, index: this.activeIndex }) {
              TabContent() {

              }
              .tabBar(this.tabItem("文字·图片", 0))

              TabContent() {

              }.tabBar(this.tabItem("视频", 1))

            }
            .barMode(BarMode.Scrollable)
            .barHeight(35)
            .divider({ color: "#ccc", strokeWidth: 1 })
          }
        }.tabBar(`喜欢 ${this.userViewModel.jokeLikeNum}`)

        TabContent() {
          Text("内容3")
        }.tabBar(`评论 ${this.userViewModel.commentNum}`)

        TabContent() {
          Text("内容4")
        }.tabBar(`收藏 ${this.userViewModel.collectNum}`)
      }.divider({ strokeWidth: 1, color: "#ccc" })

      UserMarkImage({ visible: this.visible, src: this.userViewModel.avatar })
    }.width("100%")
  }
}
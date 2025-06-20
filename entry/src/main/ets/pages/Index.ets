import { LoginCode } from "../dto/LoginCode"
import { Home } from "./Home"
import { router } from "@kit.ArkUI"
import { Message } from "./msg/Message"

@Preview
@Component
struct Index {
  @State activeIndex: number = 0
  private tabsController: TabsController = new TabsController()

  @Builder
  TabBarItemBuilder(defaultIcon: Resource, activeIcon: Resource, label: string, index: number) {
    Column({ space: 6 }) {
      SymbolGlyph(this.activeIndex === index ? activeIcon : defaultIcon).fontSize(30)
      Text(label).fontSize(16).fontColor(this.activeIndex === index ? Color.Black : '#666')
    }
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
    .width('100%')
    .onClick(() => {
      this.activeIndex = index
      this.tabsController.changeIndex(index)
    })
  }
    
  build() {
    NavDestination() {
      Tabs({ barPosition: BarPosition.End, controller: this.tabsController }) {
        TabContent() {
          Home()
        }
        .tabBar(this.TabBarItemBuilder($r('sys.symbol.house'), $r('sys.symbol.house_fill'), '首页', 0))

        //    内容二
        TabContent() {

        }.tabBar(this.TabBarItemBuilder($r('sys.symbol.play_video'), $r('sys.symbol.play_video_fill'), '视频', 1))


        TabContent() {
          //  消息页面
          Message()
        }.tabBar(this.TabBarItemBuilder($r('sys.symbol.message'), $r('sys.symbol.message_fill'), '消息', 2))


        TabContent() {
          //   内容四
          Text('内容四')
        }.tabBar(this.TabBarItemBuilder($r('sys.symbol.person'), $r('sys.symbol.person_crop_circle_fill'), '我的', 3))

      }
      .width('100%')
      .height('100%')
      .barHeight(70)
      .barBackgroundColor(0Xfefffe)
      .divider({ strokeWidth: 1, color: '#eeeeee' })
      .scrollable(false)
      .backgroundColor(0Xfefffe)
      .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP])
    }
    .height('100%')
    .width('100%')
    .hideTitleBar(true)
    .hideBackButton(true)
    .hideToolBar(true)
    .onBackPressed((): boolean => {
      router.back();
      return true;
    })
  }
}

@Builder
export function IndexBuilder() {
  Index()
}
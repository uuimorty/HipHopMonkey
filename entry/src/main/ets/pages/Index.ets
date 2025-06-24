import { Home } from "./Home"
import User from './User/User'
import { router } from "@kit.ArkUI"
import { Message } from "./msg/Message"

@Preview
@Component
struct Index {
  @State activeIndex: number = 0
  // 通过卡片跳转的索引
  @Consume targetNavIndex:number;
  private  tabsController: TabsController = new TabsController()

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
      Tabs({ barPosition: BarPosition.End, index:this.activeIndex, controller: this.tabsController }) {
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

          User()
        }.tabBar(this.TabBarItemBuilder($r('sys.symbol.person'), $r('sys.symbol.person_crop_circle_fill'), '我的', 3))

      }
      .width('100%')
      .height('100%')
      .barHeight(70)
      .barBackgroundColor(0Xfefffe)
      .divider({ strokeWidth: 1, color: '#eeeeee' })
      .scrollable(false)
      .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP]) //拓展安全区
    }
    .height('100%')
    .width('100%')
    .hideTitleBar(true)
    .hideBackButton(true)
    .hideToolBar(true)
    .onShown(()=>{

      // 尝试拿卡片进入索引，有就直接使用没有就默认
      const targetIndexParam = AppStorage.get("targetNavIndex") as number
      console.log("target+++++++",targetIndexParam)
      if (targetIndexParam || targetIndexParam===0) {

        this.activeIndex=targetIndexParam
        this.tabsController.changeIndex(targetIndexParam)
        AppStorage.set("targetNavIndex",null)
        return
      }

      if (this.targetNavIndex || this.targetNavIndex===0) {
        console.log("show++++",this.targetNavIndex)
        this.activeIndex=this.targetNavIndex
        this.tabsController.changeIndex(this.targetNavIndex)
      }
    })
    .onHidden(()=>{
      console.log("hide++++activeIndex",this.activeIndex)
      this.targetNavIndex=this.activeIndex
      console.log("hide++++targetNavIndex",this.targetNavIndex)
    })

    .onBackPressed((): boolean => {
      router.back();
      return true;
    })
  }

  onPageShow(): void {
    console.log("showshow")
  }

}

@Builder
export function IndexBuilder() {
  Index()
}
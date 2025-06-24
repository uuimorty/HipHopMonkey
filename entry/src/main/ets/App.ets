import { Splash } from './pages/splash'

@Entry
@Component
struct App {
  // 路由栈
  @Provide navPathStack: NavPathStack = new NavPathStack()
  @Provide isAgreeLicense: boolean = false;
  @Provide targetNavIndex: number | null = null;

  build() {
    Navigation(this.navPathStack) {
      Column() {
        // 启动页
        Splash()
      }
    }
    .height('100%')
    .width('100%')
    .hideTitleBar(true)
    .hideBackButton(true)
    .hideToolBar(true)
  }

  aboutToAppear(): void {
    const targetIndexParam = AppStorage.get("targetNavIndex") as number
    if (targetIndexParam || targetIndexParam===0) {
      console.log("app targetIndexParam",targetIndexParam)
      this.targetNavIndex = targetIndexParam
    }
  }

  onPageShow(): void {
    AppStorage.setOrCreate('navPathStackLocal',this.navPathStack)
  }

}
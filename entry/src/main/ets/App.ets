import { Splash } from './pages/splash'

@Entry
@Component
struct App {
  // 路由栈
  @Provide navPathStack: NavPathStack = new NavPathStack()
  @Provide isAgreeLicense: boolean = false;
  
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
}
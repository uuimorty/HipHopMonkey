import { Splash } from './pages/splash'

@Entry
@Component
struct App {
  // 路由栈
  @Provide navPathStack: NavPathStack = new NavPathStack()
  
  aboutToAppear(): void {
    setTimeout(() => {
      const token: string = AppStorage.get('token')!
      console.log('token', token)
      if (token) {
        this.navPathStack.pushPath({ name: 'Index' })
      } else {
        this.navPathStack.pushPath({ name: 'Login' })
      }
    }, 200)
  }

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
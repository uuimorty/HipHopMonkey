@Component
export struct Splash {
  @Consume navPathStack: NavPathStack

  build() {
    Navigation(this.navPathStack) {
      Column() {
        Button('跳过')
          .width(80)
          .height(40)
          .position({
            top: 20,
            right: 18
          })
          .backgroundColor('rgba(0,0,0,0.3)')
          .onClick(() => {
            this.navPathStack.pushPath({ name: 'Index' })
          })
      }
      .height('100%')
      .width('100%')
      .backgroundImage($r('app.media.splash'))
      .backgroundImageSize(ImageSize.FILL)
      .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
    }.hideTitleBar(true)
    .hideBackButton(true)
    .hideToolBar(true)
  }
}
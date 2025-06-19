@Component
export struct Splash {
  @Consume navPathStack: NavPathStack

  @State num:number =5;
  @State timerOut:number =-1;
  @State timerInt:number =-1;
  token:string|undefined = undefined;

  build() {
    Navigation(this.navPathStack) {
      Column() {
        Button(`跳过 ${this.num}`)
          .width(80)
          .height(40)
          .position({
            top: 20,
            right: 18
          })
          .backgroundColor('rgba(0,0,0,0.3)')
          .onClick(()=>{
            clearInterval(this.timerInt);
            clearTimeout(this.timerOut)
            if (this.token) {
              this.navPathStack.pushPath({ name: 'Index' });
            }else {
              this.navPathStack.pushPath({ name: 'Login' });
            }
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


  onDidBuild(): void {
    this.num=5;
    this.timerInt=setInterval(()=>{
      if (this.num>0) {
        this.num--;
      }
    },1000)
    this.timerOut=setTimeout(()=>{
      if (this.token) {
        this.navPathStack.pushPath({ name: 'Index' });
      }else {
        this.navPathStack.pushPath({ name: 'Login' });
      }
    },5000)
  }
  onPageHide(): void {
    console.log("onPageHide")
    clearInterval(this.timerInt);
    clearTimeout(this.timerOut);
  }

  aboutToAppear(): void {
    console.log("token",AppStorage.get('token'))
    this.token=AppStorage.get('token') as string
  }


}
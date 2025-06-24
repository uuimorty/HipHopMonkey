import { IBestPopup } from '@ibestservices/ibest-ui'

@Component
export struct UserMarkImage {
  @Link visible: boolean
  @Prop src: string

  @Builder
  centerBuilder(src: string) {
    Column() {
      Image(src).width("100%")
        .aspectRatio(1).hitTestBehavior(HitTestMode.None)
    }
    .width("100%")
    .height("100%")
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
    .onClick(() => {
      this.visible = false
    })
  }

  build() {
    IBestPopup({
      visible: $visible,
      bgColor: Color.Black,
      popupWidth: "100%",
      popupHeight: "100%",
      contentBuilder: (): void => this.centerBuilder(this.src),
    })
  }
}
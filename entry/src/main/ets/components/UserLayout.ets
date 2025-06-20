import { UserData } from '../dto/User';

@Component
export default struct UserLayout {
  @State userData: UserData = {}

  aboutToAppear(): void {
    const res: UserData | undefined = AppStorage.get("allUserData")
    if (res) {
      this.userData = res
    }
  }

  build() {
    Column() {
      //上背景图
      Row() {
        Image("").width("100%")
      }.width("100%").height(125)

      Column() {
        Row() {
          Row() {
            Image("").width("100%")
          }
          .borderWidth(1)
          .borderRadius("50%")
          .height(60)
          .width(60)
          .position({ top: -2 })

          Row() {
            Text("编辑资料").fontColor("#fff65425")
          }.width(100).height(30).borderRadius("15%")
        }.justifyContent(FlexAlign.SpaceBetween).padding({ left: 20, right: 20 }).alignItems(VerticalAlign.Center)

        Column() {
          Text()
          Text() {
            Span("入驻嘻哈猴： ")
            // Span(`${}年${}个月`)
          }.fontSize(13).fontColor("#999")
        }
      }

    }
  }
}
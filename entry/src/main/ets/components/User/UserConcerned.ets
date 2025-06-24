import { UserConcernedData } from '../../dto/User';
import UserViewModel from '../../ViewModel/UserViewModel';

@Component
struct _UserConcerned {
  @Consume navPathStack: NavPathStack
  @State userViewModel: UserViewModel = new UserViewModel()
  @State count: number = 0

  aboutToAppear(): void {
    const targetUserId = this.navPathStack.getParamByName("UserConcerned")[0] as number
    this.userViewModel.getUserConcerned(targetUserId)
    console.log("我是指定获取的关注数据", JSON.stringify(this.userViewModel.concernedUserData, null, 2))
  }

  build() {
    NavDestination() {
      Column() {
        Tabs() {
          TabContent() {
            Column() {
              List({ space: 20 }) {
                ForEach(this.userViewModel.concernedUserData, (item: UserConcernedData, index) => {
                  ListItem() {
                    Row() {
                      Row() {
                        Row() {
                          Image(item.avatar).width("100%")
                        }.width(50).height(50).borderRadius("50%").clip(true)

                        Column() {
                          Text(item.nickname)
                          Text(item.signature)
                            .maxLines(1)// 限制为1行
                            .textOverflow({ overflow: TextOverflow.Ellipsis })// 超出部分显示...
                            .width('100%')
                            .margin({ top: 5 })
                            .fontSize(13)
                            .fontColor("#ccc")
                        }
                        .margin({ left: 15 })
                        .justifyContent(FlexAlign.Start)
                        .alignItems(HorizontalAlign.Start)
                        .width(175)
                      }

                      Row() {
                        if (item.attention === 2) {
                          Text("已关注").fontColor("#ccc").fontSize(15)
                        } else if (item.attention === 3) {
                          Text("互相关注").fontColor("#ccc").fontSize(15)
                        }
                      }
                      .id(`${item.userId}`)
                      .width(75)
                      .height(30)
                      .borderRadius("35%")
                      .borderWidth(1)
                      .justifyContent(FlexAlign.Center)
                      .borderColor("#999")

                    }.justifyContent(FlexAlign.SpaceBetween).width("100%")
                  }.onClick(() => {
                    this.userViewModel.cancelConcernedUSer(index, 0, item.userId)
                  })
                })
              }.width("100%").height("100%").scrollBarWidth(0)
            }.width("100%").padding({ left: 20, right: 20 })
          }.tabBar("关注").width("100%")

          TabContent() {
          }.tabBar("粉丝")
        }
      }
    }.title(this.userViewModel.appointUserData.nickname)
  }
}

@Builder
function UserConcernedBuilder() {
  _UserConcerned()
}

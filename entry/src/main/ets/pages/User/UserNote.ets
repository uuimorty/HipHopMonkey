import UserLayout from '../../components/User/UserLayout';
import UserViewModel from '../../ViewModel/UserViewModel';

import { Params } from './User';
@Component
struct UserNote {
  @Consume navPathStack: NavPathStack
  @State userId: number = 0
  @State userViewModel: UserViewModel = new UserViewModel()
  @State isActiveTools: boolean = true
  @State tabActiveIndex: number = 0
  private scrollScroller: Scroller = new Scroller();
  @State arr: number[] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0]

  aboutToAppear(): void {
    const params = this.navPathStack.getParamByName("UserNotes")[0] as Params
    this.userId = params.userId
    this.tabActiveIndex = params.tabActiveIndex
    console.log("我是携带参数", JSON.stringify(this.navPathStack.getParamByName("UserNotes"), null, 2))
    this.userViewModel.getAppointUser(this.userId)
  }

  build() {
    NavDestination() {
      Scroll() {
        Column() {
          if (this.userViewModel.loading) {
            LoadingProgress().width(30)
          } else {
            UserLayout({
              userViewModel: this.userViewModel.appointUserData,
              isActiveTool: this.isActiveTools,
              tabActiveIndex: this.tabActiveIndex
            })
          }
        }
      }.expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP])
      .onScrollEdge((edge) => {
        if (edge === 0) {
          this.isActiveTools = true
        } else {
          this.isActiveTools = false
        }
      })
    }
    .hideTitleBar(this.isActiveTools)
    .title(this.userViewModel.appointUserData.nickname)
  }
}

@Builder
function UserNotesBuilder() {
  UserNote()
}

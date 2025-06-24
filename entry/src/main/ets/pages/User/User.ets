import { IBestCell, IBestCellGroup } from '@ibestservices/ibest-ui';
import UserViewModel from '../../ViewModel/UserViewModel';
import { UserMarkImage } from '../../components/User/UserMarkImage';

export interface Params {
  userId: number
  tabActiveIndex: number
}

@Component
export default struct User {
  @Consume navPathStack: NavPathStack
  @State userViewModel: UserViewModel = new UserViewModel()
  @State visible: boolean = false

  params(index: number): Params | void {
    if (this.userViewModel.userData.user?.userId) {
      return {
        userId: this.userViewModel.userData.user.userId,
        tabActiveIndex: index
      }
    } else {
      console.log("userId未获取成功")
    }
  }

  @Builder
  icons(src: string) {
    SymbolGlyph($r(src))
  }

  aboutToAppear(): void {
    this.userViewModel.getUserData()
  }

  build() {
    Scroll() {
      Column() {
        if (this.userViewModel.loading) {
          LoadingProgress().width(60)
          Text("玩命加载中...").fontColor("#999")
        } else {
          Column() {
            Column() {
              Row() {
                Image(this.userViewModel.userData.user?.avatar).width(60).height(60).borderRadius("50%").onClick(() => {
                  this.visible = true
                })
                Row() {
                  Text(this.userViewModel.userData.user?.nickname).fontSize(20).margin({ left: 10 })
                  SymbolGlyph($r("sys.symbol.chevron_right")).fontSize(30)
                }.flexGrow(1).margin({ left: 10 }).justifyContent(FlexAlign.SpaceBetween).onClick(() => {
                  this.navPathStack.pushPath({
                    name: "UserNotes",
                    param: this.params(0)
                  })
                })
              }.alignItems(VerticalAlign.Center).width("100%")

              Row() {
                Column() {
                  Text(`${this.userViewModel.userData.info?.attentionNum}`)
                  Text("关注").fontWeight(300).fontColor("#999").margin({ top: 3 })
                }.justifyContent(FlexAlign.Center)

                Column() {
                  Text(`${this.userViewModel.userData.info?.fansNum}`)
                  Text("粉丝").fontWeight(300).fontColor("#999").margin({ top: 3 })
                }.justifyContent(FlexAlign.Center)

                Column() {
                  Text(`${this.userViewModel.userData.info?.experienceNum}`)
                  Text("乐豆").fontWeight(300).fontColor("#999").margin({ top: 3 })
                }.justifyContent(FlexAlign.Center)
              }.width(250).justifyContent(FlexAlign.SpaceAround).margin({ top: 15 })

            }.alignItems(HorizontalAlign.Start)

            Row() {
              Column() {
                Image($r("app.media.note")).width(30)
                Text("帖子").margin({ top: 5 })
              }.onClick(() => {
                this.navPathStack.pushPath({ name: "UserNotes", param: this.params(0) })
              })

              Column() {
                Image($r("app.media.remark")).width(30)
                Text("评论").margin({ top: 5 })
              }.onClick(() => {
                this.navPathStack.pushPath({ name: "UserNotes", param: this.params(2) })
              })

              Column() {
                Image($r("app.media.good")).width(30)
                Text("点赞").margin({ top: 5 })
              }.onClick(() => {
                this.navPathStack.pushPath({ name: "UserNotes", param: this.params(1) })
              })

              Column() {
                Image($r("app.media.like")).width(30)
                Text("收藏").margin({ top: 5 })
              }.onClick(() => {
                this.navPathStack.pushPath({ name: "UserNotes", param: this.params(3) })
              })
            }
            .width("100%")
            .height(90)
            .backgroundColor("#f9f8fa")
            .borderRadius("5%")
            .justifyContent(FlexAlign.SpaceAround)
            .alignItems(VerticalAlign.Center)
            .margin({ top: 20 })

            Row() {
              Image($r("app.media.arrange")).width("100%")
            }.width("100%").borderRadius("5%").clip(true).margin({ top: 20 })

          }.padding(30)

          Column() {
            Column() {
              IBestCellGroup({ inset: true }) {
                IBestCell({
                  title: "我的客服",
                  iconBuilder: () => this.icons("sys.symbol.service"),
                  isLink: true,
                })
              }
            }

            Column() {
              IBestCellGroup({ inset: true }) {
                IBestCell({
                  title: "审核中",
                  iconBuilder: () => this.icons("sys.symbol.timer"),
                  isLink: true
                })
                IBestCell({
                  title: "审核失败",
                  iconBuilder: () => this.icons("sys.symbol.exclamationmark_circle"),
                  isLink: true
                })
              }
            }.margin({ top: 20 })

            Column() {
              IBestCellGroup({ inset: true, }) {
                IBestCell({
                  title: "分享给朋友",
                  iconBuilder: () => this.icons("sys.symbol.share"),
                  isLink: true
                })
                IBestCell({
                  title: "意见反馈",
                  iconBuilder: () => this.icons("sys.symbol.ellipsis_message"),
                  isLink: true
                })
                IBestCell({
                  title: "赏个好评",
                  iconBuilder: () => this.icons("sys.symbol.checkmark_circle"),
                  isLink: true
                })
                IBestCell({
                  title: "设置",
                  iconBuilder: () => this.icons("sys.symbol.gearshape"),
                  isLink: true,
                  hasBorder: false
                })
              }
            }.margin({ top: 20 })

          }.padding(14)

          UserMarkImage({ visible: this.visible, src: this.userViewModel.userData.user?.avatar })
        }

      }
    }

  }
}
import GetWatchListViewModel from '../ViewModel/WatchListViewModel'
// 下拉刷新组件
import { IBestPullRefresh } from "@ibestservices/ibest-ui";
import { IBestButton } from "@ibestservices/ibest-ui";
import { WatchListDataTypeData } from '../dto/WatchListDataType';

@Component
export struct WatchListPage {
  @State watchListViewModel: GetWatchListViewModel = new GetWatchListViewModel()
  @State isLoading: boolean = this.watchListViewModel.loading
  private listScroller: ListScroller = new ListScroller()

  @Builder
  watchList(item: WatchListDataTypeData) {
    Row() {
      Image(item.avatar).width(60).height(60).borderRadius(60)
      Column({ space: 10 }) {
        Text(item.nickname).fontSize(18).fontWeight(FontWeight.Bold)
        Row({ space: 10 }) {
          Text(`发表 ${item.jokesNum}`).fontColor(0xacacac).fontSize(14)
          Text(`粉丝 ${item.fansNum}`).fontColor(0xacacac).fontSize(14)
        }
      }
      .padding({ left: 14 })
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      Button('+ 关注')
        .fontColor(0Xe1c8ae)
        .width(70)
        .height(40)
        .backgroundColor(Color.White)
        .border({ width: 1, color: 0Xe1c8ae, radius: 30 })
    }
    .width('100%')
    .padding({ top: 12, bottom: 12 })
    .justifyContent(FlexAlign.SpaceBetween)
  }

  onRefresh() {
    this.watchListViewModel.loadWatchListData()
    this.isLoading = this.watchListViewModel.loading
  }

  aboutToAppear(): void {
    this.watchListViewModel.loadWatchListData()
  }

  @Builder
  customContent() {
    List({ scroller: this.listScroller }) {
      ForEach(this.watchListViewModel.watchListData, (item: WatchListDataTypeData) => {
        ListItem() {
          this.watchList(item)
        }
      })
    }
    .padding({ left: 16, right: 16 })
    .width("100%")
    .edgeEffect(EdgeEffect.None)
    .height("100%")
    .scrollBar(BarState.Off)
  }

  build() {
    Column() {
      IBestPullRefresh({
        loading: $isLoading,
        scroller: this.listScroller,
        defaultContent: (): void => this.customContent(),
        onRefresh: (): void => this.onRefresh(),
        successText: '刷新成功',
        isEnableSlideUp: false
      })
    }
    .height('100%')
    .width('100%')
  }
}
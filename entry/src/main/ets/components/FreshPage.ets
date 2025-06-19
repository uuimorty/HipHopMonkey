import { IBestPullRefresh } from '@ibestservices/ibest-ui'
import GetFreshPageViewModel from '../ViewModel/FreshPageViewModel'

@Component
export struct FreshPage {
  @State isLoading: boolean = false
  @State freshPageViewModel: GetFreshPageViewModel = new GetFreshPageViewModel()
  private scroll: Scroller = new Scroller()
  private controller: VideoController = new VideoController()

  aboutToAppear(): void {
    this.freshPageViewModel.loadingFreshPageData()
  }

  // 刷新的逻辑
  onRefresh() {

  }

  @Builder
  Main() {
    Scroll(this.scroll) {
      Column() {
        Text('新鲜页').fontSize(40)
        Text('???')

      }
      .width('100%')
    }
    .scrollBar(BarState.Auto)
    .width('100%')
    .height('100%')
    .backgroundColor(0xf8f8f8)
  }

  build() {
    Column() {
      IBestPullRefresh({
        loading: $isLoading,
        scroller: this.scroll,
        defaultContent: (): void => this.Main(),
        onRefresh: (): void => this.onRefresh(),
        successText: '刷新成功',
        slideUpSuccessText: '加载成功',
        slideUpSuccessDuration: 300,
        successDuration: 300
      })
    }.width('100%')
    .height('100%')
    .backgroundColor(Color.Yellow)
  }
}

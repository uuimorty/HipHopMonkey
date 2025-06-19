import { RecommendListPage } from "../components/RecommendListPage"
import { WatchListPage } from "../components/WatchListPage"
import { FreshPage } from "../components/FreshPage"

@Component
export struct Home {
  build() {
    Tabs() {
      TabContent() {
        WatchListPage()
      }.tabBar(SubTabBarStyle.of('关注'))

      TabContent() {
        RecommendListPage()
      }.tabBar(SubTabBarStyle.of('推荐'))


      TabContent() {
        FreshPage()
      }.tabBar(SubTabBarStyle.of('新鲜'))


      TabContent() {
        Text('纯文页')
      }.tabBar(SubTabBarStyle.of('纯文'))

      TabContent() {
        Text('趣图页')
      }.tabBar(SubTabBarStyle.of('趣图'))
    }
    .barWidth('80%')
  }
}
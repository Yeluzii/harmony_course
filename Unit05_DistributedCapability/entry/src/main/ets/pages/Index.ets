import { TabBar } from '../components/TabBar'
import { TabItem } from '../model/tabItem'
import { HandTapPage } from './HandTapPage'
import { HeartPage } from './HeartPage'
import { StarPage } from './StarPage'

@Entry
@Component
struct Index {
  @State currentIndex: number = 0
  tabItems: TabItem[] = [
    {
      title: 'heart',
      icon: $r('app.media.heart'),
      selectedIcon: $r('app.media.heart_selected')
    },
    {
      title: 'star',
      icon: $r('app.media.star'),
      selectedIcon: $r('app.media.star_selected')
    },
    {
      title: 'hand tap',
      icon: $r('app.media.hand_tap'),
      selectedIcon: $r('app.media.hand_tap_selected')
    }
  ]

  @Builder
  getPageContent() {
    if (this.currentIndex === 0) {
      HeartPage()
    } else if (this.currentIndex === 1) {
      StarPage()
    } else if (this.currentIndex === 2) {
      HandTapPage()
    }
  }

  build() {
    Column() {
      // 内容区域
      Column() {
        this.getPageContent()
      }
      .layoutWeight(1)

      // 底部导航栏
      TabBar({
        tabItems: this.tabItems,
        selectedIndex: this.currentIndex,
        onTabClick: (index: number) => {
          this.currentIndex = index
        }
      })
    }
    .height('100%')
    .backgroundColor($r('app.color.index_bg'))
  }
}
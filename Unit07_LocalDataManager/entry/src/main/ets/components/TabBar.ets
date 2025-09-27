import { TabItem } from '../model/tabItem'

@Component
export struct TabBar {
  @Prop selectedIndex: number = 0
  tabItems: TabItem[] = []
  onTabClick?: (index: number) => void

  build() {
    Row() {
      ForEach(this.tabItems, (item: TabItem, index: number) => {
        Column() {
          Image(this.selectedIndex === index ? item.selectedIcon : item.icon)
            .width(24)
            .height(24)

          Text(item.title)
            .fontSize(10)
            .fontColor(this.selectedIndex === index ? $r('app.color.icon_selected') : $r('app.color.icon_normal'))
            .margin({ top: 4 })
            .fontWeight(this.selectedIndex === index ? FontWeight.Medium : FontWeight.Normal)
        }
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .padding({ top: 8, bottom: 8 })
        .onClick(() => {
          this.onTabClick?.(index)
        })
      })
    }
    .width('100%')
    .height(60)
    .backgroundColor($r('app.color.bg_white'))
    .border({
      width: { top: 0.5 },
      color: $r('app.color.border_light')
    })
  }
}
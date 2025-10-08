/**
 * @file: GridItemExample.ets
 * @author: Yeluzii
 * @date: 2025/10/08
 */
import { DashboardGridItem } from '../IrregularGridPage'

@Component
export struct GridItemExample {
  @Prop gridItems: DashboardGridItem[]

  @Builder
  GridItemContent(item: DashboardGridItem) {
    Column() {
      Text(item.title)
        .fontSize(20)
        .fontColor(Color.Black)
        .fontWeight(FontWeight.Medium)
        .margin({ bottom: 10 })

      Text(item.content)
        .fontSize(16)
        .fontColor(Color.Black)
        .opacity(0.9)
    }
    .width('100%')
    .height(item.height || 100)
    .backgroundColor(item.backgroundColor)
    .borderRadius(16)
    .padding(5)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .shadow({
      radius: 16,
      color: Color.Yellow,
      offsetX: 0,
      offsetY: 2
    })
  }

  build() {
    Column() {
      Text("不规则网格布局")
        .fontSize(24)
        .fontColor(Color.Black)
        .fontWeight(FontWeight.Medium)
        .margin({ bottom: 20 })

      Grid() {
        ForEach(this.gridItems, (item: DashboardGridItem) => {
          GridItem() {
            this.GridItemContent(item)
          }
          .columnStart((item.id - 1) % 4)
          .rowStart(Math.floor((item.id - 1) / 4))
        })
      }
      .columnsTemplate('1fr 1fr 1fr 1fr')
      .rowsGap(10)
      .columnsGap(10)
      .height(400)
      .width('100%')
      .backgroundColor('#fff')
      .borderRadius(16)
      .padding(5)
    }
  }
}
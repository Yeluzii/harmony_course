/**
 * @file: WaterfallExample.ets
 * @author: Yeluzii
 * @date: 2025/10/08
 */

@Component
export struct WaterfallExample {
  @State cards: WaterfallCard[] = [
    {
      id: 1,
      title: "图片卡片",
      height: 180,
      color: Color.Blue
    },
    {
      id: 2,
      title: "文字卡片",
      height: 120,
      color: Color.Green
    },
    {
      id: 3,
      title: "混合卡片",
      height: 200,
      color: Color.Yellow
    },
    {
      id: 4,
      title: "简短卡片",
      height: 80,
      color: Color.Red
    },
    {
      id: 5,
      title: "长内容卡片",
      height: 240,
      color: Color.Brown
    },
    {
      id: 6,
      title: "中等卡片",
      height: 160,
      color: Color.Gray
    },
    {
      id: 7,
      title: "图表卡片",
      height: 220,
      color: Color.Grey
    },
    {
      id: 8,
      title: "数据卡片",
      height: 140,
      color: Color.Orange
    },
    {
      id: 9,
      title: "统计卡片",
      height: 100,
      color: Color.Blue
    },
    {
      id: 10,
      title: "报表卡片",
      height: 260,
      color: Color.Green
    }
  ]

  build() {
    Column() {
      Text("瀑布流布局模拟")
        .fontSize(24)
        .fontColor(Color.Black)
        .fontWeight(FontWeight.Medium)
        .margin({ bottom: 20 })

      Flex({ direction: FlexDirection.Row, wrap: FlexWrap.Wrap, justifyContent: FlexAlign.SpaceBetween }) {
        ForEach(this.cards, (card: WaterfallCard) => {
          this.WaterfallCardItem(card)
        })
      }
      .width('100%')
      .backgroundColor('fff')
      .borderRadius(16)
      .padding(5)
    }
  }

  @Builder
  WaterfallCardItem(card: WaterfallCard) {
    Column() {
      Text(card.title)
        .fontSize(20)
        .fontColor(Color.Black)
        .fontWeight(FontWeight.Medium)
        .margin({ bottom: 10 })

      Text(`高度: ${card.height}vp`)
        .fontSize(16)
        .fontColor(Color.Black)
        .opacity(0.8)
    }
    .width('48%')
    .height(card.height)
    .backgroundColor(card.color)
    .borderRadius(16)
    .padding(5)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .margin({ bottom: 20 })
    .shadow({
      radius: 16,
      color: Color.Blue,
      offsetX: 0,
      offsetY: 2
    })
  }
}

interface WaterfallCard {
  id: number
  title: string
  height: number
  color: ResourceColor
}
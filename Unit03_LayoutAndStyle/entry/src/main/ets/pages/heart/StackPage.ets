@Entry
@Component
struct StackPage {
  @State title: string = ''

  aboutToAppear() {
    let params = this.getUIContext().getRouter().getParams() as Record<string, Object>
    if (params) {
      this.title = params['title'] as string
    }
  }

  // 基础层叠
  @Builder
  BasicStackDemo() {
    Column({ space: 12 }) {
      Text('基础层叠布局').fontSize(16).fontWeight(FontWeight.Medium)

      Stack() {
        // 背景
        Circle({ width: 120, height: 120 }).fill('#E3F2FD')
        // 中层
        Circle({ width: 80, height: 80 }).fill('#2196F3')
        // 前景
        Circle({ width: 40, height: 40 }).fill('#0D47A1')
        // 文本
        Text('Stack').fontSize(16).fontColor(Color.White).fontWeight(FontWeight.Bold)
      }
      .width(140)
      .height(140)
      .alignSelf(ItemAlign.Center)
      .backgroundColor('#F8F9FA')
      .borderRadius(8)
      .padding(12)
    }
  }

  // 对齐方式
  @Builder
  AlignmentDemo() {
    Column({ space: 12 }) {
      Text('对齐位置演示').fontSize(16).fontWeight(FontWeight.Medium)

      Row({ space: 16 }) {
        // TopStart
        Stack({ alignContent: Alignment.TopStart }) {
          Rect().width(80).height(80).fill('#E0E0E0').borderRadius(6)
          Circle({ width: 16, height: 16 }).fill('#FF5722')
        }
        .width(80).height(80)

        // Center
        Stack({ alignContent: Alignment.Center }) {
          Rect().width(80).height(80).fill('#E0E0E0').borderRadius(6)
          Circle({ width: 16, height: 16 }).fill('#FF5722')
        }
        .width(80).height(80)

        // BottomEnd
        Stack({ alignContent: Alignment.BottomEnd }) {
          Rect().width(80).height(80).fill('#E0E0E0').borderRadius(6)
          Circle({ width: 16, height: 16 }).fill('#FF5722')
        }
        .width(80).height(80)
      }
    }
  }

  // 实际应用
  @Builder
  PracticalDemo() {
    Column({ space: 16 }) {
      Text('实际应用案例').fontSize(16).fontWeight(FontWeight.Medium)

      // 头像徽章
      Stack({ alignContent: Alignment.TopEnd }) {
        Image($r('app.media.camera_icon')).width(60).height(60).borderRadius(30)
        Circle({ width: 20, height: 20 }).fill('#ff278be2').margin({ right: -4, top: -4 })
      }
      .width(80).height(80)
      .backgroundColor('#78b5e2')

      // 浮动按钮
      Stack({ alignContent: Alignment.BottomEnd }) {
        // 内容
        Column({ space: 6 }) {
          ForEach([1, 2, 3], (i: number) => {
            Text(`列表项 ${i}`)
              .width('100%')
              .padding(8)
              .backgroundColor('#FFF')
              .borderRadius(4)
              .border({ width: 1, color: '#E0E0E0' })
          })
        }
        .width('90%')
        .position({ top: 0, left: 0 })

        // 浮动按钮，先是填充圆，再是文本叠加
        Circle({ width: 48, height: 48 }).fill('#2196F3').margin({ right: -12, bottom: -12 })
        Text('+')
          .fontSize(20)
          .fontColor(Color.White)
          .width(24)
          .fontWeight(FontWeight.Bold)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(150)
      .backgroundColor('#ff92c0ee')
    }
  }

  build() {
    Navigation() {
      Scroll() {
        Column({ space: 20 }) {
          Text('Stack 层叠布局示例')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)

          // 1. 基础层叠
          this.BasicStackDemo()

          // 2. 对齐方式
          this.AlignmentDemo()

          // 3. 实际应用案例
          this.PracticalDemo()
        }
        .padding(20)
      }
      .scrollable(ScrollDirection.Vertical)
      .scrollBar(BarState.Auto)
    }
    .title(this.title)
    .titleMode(NavigationTitleMode.Mini)
    .hideBackButton(false)
    .navBarWidth('100%')
    .navBarPosition(NavBarPosition.Start)
  }
}
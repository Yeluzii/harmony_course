// 对齐方式选项接口
interface AlignOption {
  title: string
  align: HorizontalAlign
  color: string
}

// 分布方式选项接口
interface JustifyOption {
  title: string
  justify: FlexAlign
  color: string
}

@Entry
@Component
struct ColumnPage {
  @State title: string = ''

  aboutToAppear() {
    let params = this.getUIContext().getRouter().getParams() as Record<string, Object>
    if (params) {
      this.title = params['title'] as string
    }
  }

  // 对齐方式选项
  private readonly alignmentOptions: AlignOption[] = [
    { title: '左对齐 (Start)', align: HorizontalAlign.Start, color: '#E3F2FD' },
    { title: '居中对齐 (Center)', align: HorizontalAlign.Center, color: '#E8F5E8' },
    { title: '右对齐 (End)', align: HorizontalAlign.End, color: '#FFF3E0' }
  ]
  // 分布方式选项
  private readonly justifyOptions: JustifyOption[] = [
    { title: 'Start', justify: FlexAlign.Start, color: '#FFEBEE' },
    { title: 'Center', justify: FlexAlign.Center, color: '#E3F2FD' },
    { title: 'Between', justify: FlexAlign.SpaceBetween, color: '#E8F5E8' }
  ]

  // 基础垂直布局
  @Builder
  BasicColumnDemo() {
    Column({ space: 8 }) {
      Text('基础垂直布局')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)

      Column({ space: 6 }) {
        Text('项目 1')
          .width('100%')
          .padding(10)
          .backgroundColor('#FF5722')
          .fontColor(Color.White)
          .textAlign(TextAlign.Center)

        Text('项目 2')
          .width('70%')
          .padding(10)
          .backgroundColor('#FF9800')
          .fontColor(Color.White)
          .textAlign(TextAlign.Center)

        Text('项目 3')
          .width('50%')
          .padding(10)
          .backgroundColor('#FFC107')
          .fontColor(Color.Black)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .alignItems(HorizontalAlign.Center)
      .backgroundColor('#F8F9FA')
      .padding(10)
      .borderRadius(8)
    }
  }

  // 对齐方式演示
  @Builder
  AlignmentDemo() {
    Column({ space: 8 }) {
      Text('对齐方式演示')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)

      ForEach(this.alignmentOptions, (item: AlignOption) => {
        Column({ space: 4 }) {
          Text(item.title).fontSize(12).fontColor('#666')

          Column({ space: 4 }) {
            ForEach(['短', '中等长度', '长文本'], (t: string) => {
              Text(t).padding(6).backgroundColor(item.color).borderRadius(4)
            })
          }
          .alignItems(item.align)
          .width('100%')
        }
      }, (item: AlignOption) => item.title) // key 保证唯一
    }
  }

  // 分布方式演示
  @Builder
  JustifyContentDemo() {
    Column({ space: 8 }) {
      Text('分布方式演示')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)

      Row({ space: 12 }) {
        ForEach(this.justifyOptions, (cfg: JustifyOption) => {
          Column({ space: 4 }) {
            Text(cfg.title).fontSize(10).fontColor('#666')

            Column() {
              ForEach(['A', 'B', 'C'], (t: string) => {
                Text(t)
                  .width(28)
                  .height(28)
                  .backgroundColor(cfg.color)
                  .textAlign(TextAlign.Center)
                  .fontColor('#333')
                  .borderRadius(4)
              })
            }
            .height(100).width(40)
            .justifyContent(cfg.justify)
            .backgroundColor('#F5F5F5')
          }
        }, (cfg: JustifyOption) => cfg.title)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
    }
  }

  build() {
    Navigation() {
      Scroll() {
        Column({ space: 20 }) {
          Text('Column 垂直布局示例')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)

          this.BasicColumnDemo()
          this.AlignmentDemo()
          this.JustifyContentDemo()
        }
        .width('100%')
        .padding(16)
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
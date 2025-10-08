// Row 的对齐方式选项接口（纵向对齐）
interface RowAlignOption {
  title: string
  align: VerticalAlign
  color: string
}

// Row 的分布方式选项接口（横向分布）
interface RowJustifyOption {
  title: string
  justify: FlexAlign
  color: string
}

@Entry
@Component
struct RowPage {
  @State title: string = ''

  aboutToAppear() {
    let params = this.getUIContext().getRouter().getParams() as Record<string, Object>
    if (params) {
      this.title = params['title'] as string
    }
  }

  // 纵向对齐选项
  private readonly alignmentOptions: RowAlignOption[] = [
    { title: '顶端对齐 (Top)', align: VerticalAlign.Top, color: '#E3F2FD' },
    { title: '居中对齐 (Center)', align: VerticalAlign.Center, color: '#E8F5E8' },
    { title: '底部对齐 (Bottom)', align: VerticalAlign.Bottom, color: '#FFF3E0' }
  ]

  // 横向分布选项
  private readonly justifyOptions: RowJustifyOption[] = [
    { title: 'Start',   justify: FlexAlign.Start,        color: '#FFEBEE' },
    { title: 'Center',  justify: FlexAlign.Center,       color: '#E3F2FD' },
    { title: 'Between', justify: FlexAlign.SpaceBetween, color: '#E8F5E8' }
  ]

  // 1) 基础水平布局
  @Builder
  BasicRowDemo() {
    Column({ space: 8 }) {
      Text('基础水平布局')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)

      Row({ space: 8 }) {
        Text('项目 1')
          .height(40).width(80)
          .backgroundColor('#FF5722').fontColor(Color.White).textAlign(TextAlign.Center)

        Text('项目 2')
          .height(40).width(60)
          .backgroundColor('#FF9800').fontColor(Color.White).textAlign(TextAlign.Center)

        Text('项目 3')
          .height(40).width(40)
          .backgroundColor('#FFC107').fontColor(Color.Black).textAlign(TextAlign.Center)
      }
      .width('100%')
      .backgroundColor('#F8F9FA')
      .padding(10)
      .borderRadius(8)
    }
  }

  // 2) 交叉轴对齐（纵向对齐）
  @Builder
  AlignmentDemo() {
    Column({ space: 8 }) {
      Text('交叉轴对齐演示')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)

      ForEach(this.alignmentOptions, (item: RowAlignOption) => {
        Column({ space: 4 }) {
          Text(item.title).fontSize(12).fontColor('#666')

          Row({ space: 6 }) {
            ForEach(['高', '中', '低'], (t: string, idx: number) => {
              Text(t)
                .width(40)
                .height(20 + idx * 20) // 制造不同高度
                .backgroundColor(item.color)
                .textAlign(TextAlign.Center)
                .fontColor('#333')
                .borderRadius(4)
            })
          }
          .width('100%')
          .height(80)
          .alignItems(item.align) // 使用 VerticalAlign
          .backgroundColor('#F5F5F5')
          .borderRadius(6)
        }
      }, (item: RowAlignOption) => item.title)
    }
  }

  // 3) 主轴分布（横向分布）
  @Builder
  JustifyContentDemo() {
    Column({ space: 8 }) {
      Text('主轴分布演示')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)

      Column({ space: 12 }) {
        ForEach(this.justifyOptions, (cfg: RowJustifyOption) => {
          Column({ space: 4 }) {
            Text(cfg.title).fontSize(12).fontColor('#666')

            Row() {
              ForEach(['A', 'B', 'C'], (t: string) => {
                Text(t)
                  .width(28).height(28)
                  .backgroundColor(cfg.color)
                  .textAlign(TextAlign.Center)
                  .fontColor('#333')
                  .borderRadius(4)
              })
            }
            .width('100%')
            .height(40)
            .justifyContent(cfg.justify) // FlexAlign
            .backgroundColor('#EEE')
            .borderRadius(6)
          }
        }, (cfg: RowJustifyOption) => cfg.title)
      }
    }
  }

  build() {
    Navigation() {
      Scroll() {
        Column({ space: 20 }) {
          Text('Row 水平布局示例')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)

          this.BasicRowDemo()
          this.AlignmentDemo()
          this.JustifyContentDemo()
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
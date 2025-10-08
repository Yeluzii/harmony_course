@Entry
@Component
struct FlexPage {
  @State title: string = ''
  @State growValues: number[] = [1, 1, 1]

  aboutToAppear() {
    let params = this.getUIContext().getRouter().getParams() as Record<string, Object>
    if (params) {
      this.title = params['title'] as string
    }
  }

  // 1. 基础 Flex 布局
  @Builder
  BasicFlexDemo() {
    Column({ space: 12 }) {
      Text('基础 Flex 布局').fontSize(16).fontWeight(FontWeight.Medium)

      // Row 布局
      Text('Row 排列').fontSize(12).fontColor('#666')
      Flex({ direction: FlexDirection.Row, justifyContent: FlexAlign.SpaceAround }) {
        ForEach(['A', 'B', 'C'], (t: string) => {
          Text(t)
            .width(40)
            .height(40)
            .backgroundColor('#4CAF50')
            .textAlign(TextAlign.Center)
            .fontColor(Color.White)
            .borderRadius(6)
        })
      }
      .width('100%').height(60).backgroundColor('#E8F5E9').borderRadius(8)

      // Column 布局
      Text('Column 排列').fontSize(12).fontColor('#666')
      Flex({ direction: FlexDirection.Column, alignItems: ItemAlign.Center }) {
        ForEach(['X', 'Y', 'Z'], (t: string) => {
          Text(t)
            .width(40)
            .height(40)
            .backgroundColor('#2196F3')
            .textAlign(TextAlign.Center)
            .fontColor(Color.White)
            .borderRadius(6)
        })
      }
      .width('100%').height(140).backgroundColor('#E3F2FD').borderRadius(8)
    }
  }

  // 2. 对齐方式
  @Builder
  AlignDemo() {
    Column({ space: 12 }) {
      Text('对齐方式演示').fontSize(16).fontWeight(FontWeight.Medium)

      // 主轴对齐
      Text('主轴对齐 (justifyContent)').fontSize(12).fontColor('#666')
      Flex({ justifyContent: FlexAlign.SpaceBetween }) {
        ForEach([1, 2, 3], (n: number) => {
          Text(`${n}`)
            .width(30)
            .height(30)
            .backgroundColor('#9C27B0')
            .textAlign(TextAlign.Center)
            .fontColor(Color.White)
            .borderRadius(4)
        })
      }
      .width('100%').height(40).backgroundColor('#F3E5F5').borderRadius(6)

      // 交叉轴对齐
      Text('交叉轴对齐 (alignItems)').fontSize(12).fontColor('#666')
      Flex({ alignItems: ItemAlign.Center }) {
        Text('短').width(40).height(20).backgroundColor('#FF5722').fontColor(Color.White)
        Text('中').width(40).height(30).backgroundColor('#FF9800').fontColor(Color.White)
        Text('高').width(40).height(50).backgroundColor('#FFC107').fontColor(Color.Black)
      }
      .width('100%').height(60).backgroundColor('#FFF3E0').borderRadius(6)
    }
  }

  // 3. 项目属性演示
  @Builder
  ItemPropsDemo() {
    Column({ space: 16 }) {
      Text('项目属性').fontSize(16).fontWeight(FontWeight.Medium)

      // flexGrow
      Column({ space: 6 }) {
        Text('flexGrow - 放大比例').fontSize(12).fontColor('#666')
        Row({ space: 8 }) {
          ForEach(this.growValues, (v: number, idx: number) => {
            Button(`项目${idx + 1}:${v}`).onClick(() => {
              this.growValues[idx] = v === 3 ? 1 : v + 1
            })
          })
        }

        Flex() {
          ForEach(this.growValues, (v: number, idx: number) => {
            Text(`${idx + 1}`)
              .flexGrow(v)
              .height(40)
              .backgroundColor(['#E91E63', '#9C27B0', '#2196F3'][idx])
              .textAlign(TextAlign.Center)
              .fontColor(Color.White)
              .borderRadius(4)
          })
        }
        .width('100%')
        .height(40)
        .backgroundColor('#F5F5F5')
        .borderRadius(6)
        .padding(6)
      }

      // flexShrink
      Column({ space: 6 }) {
        Text('flexShrink - 收缩比例').fontSize(12).fontColor('#666')
        Flex() {
          Text('不收缩')
            .width(100)
            .height(40)
            .flexShrink(0)
            .backgroundColor('#4CAF50')
            .fontColor(Color.White)
          Text('正常收缩')
            .width(100)
            .height(40)
            .flexShrink(1)
            .backgroundColor('#8BC34A')
            .fontColor(Color.White)
          Text('快速收缩')
            .width(100)
            .height(40)
            .flexShrink(2)
            .backgroundColor('#CDDC39')
            .fontColor(Color.Black)
        }
        .width(200).backgroundColor('#F5F5F5').borderRadius(6).padding(6)
      }

      // flexBasis & alignSelf
      Column({ space: 6 }) {
        Text('flexBasis & alignSelf').fontSize(12).fontColor('#666')
        Flex({ alignItems: ItemAlign.Start }) {
          Text('Auto').flexBasis('auto').height(40).backgroundColor('#2196F3').fontColor(Color.White)
          Text('100px').flexBasis(100).height(40).backgroundColor('#03A9F4').fontColor(Color.White)
          Text('居中')
            .flexBasis(80)
            .height(40)
            .alignSelf(ItemAlign.Center)
            .backgroundColor('#00BCD4')
            .fontColor(Color.White)
        }
        .width('100%')
        .height(80)
        .backgroundColor('#F5F5F5')
        .borderRadius(6)
        .padding(6)
      }
    }
  }

  build() {
    Navigation() {
      Scroll() {
        Column({ space: 20 }) {
          Text('Flex 弹性布局示例')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)

          this.BasicFlexDemo()
          this.AlignDemo()
          this.ItemPropsDemo()
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
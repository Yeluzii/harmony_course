@Entry
@Component
struct StyleSystemPage {
  @State title: string = ''

  aboutToAppear() {
    let params = this.getUIContext().getRouter().getParams() as Record<string, Object>
    if (params) {
      this.title = params['title'] as string
    }
  }

  build() {
    Navigation() {
      Scroll() {
        Column({ space: 24 }) {
          // 字体样式
          Column({ space: 8 }) {
            Text("字体样式系统")
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
            Text("正文文字 - Regular")
              .fontSize(14)
              .fontWeight(FontWeight.Regular)
            Text("强调文字 - Medium")
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
            Text("标题文字 - Bold")
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
          }

          // 颜色系统
          Column({ space: 8 }) {
            Text("颜色系统").fontSize(20).fontWeight(FontWeight.Bold)
            Row({ space: 12 }) {
              Circle({ width: 40, height: 40 }).fill('#2196F3') // 主色
              Circle({ width: 40, height: 40 }).fill('#4CAF50') // 成功
              Circle({ width: 40, height: 40 }).fill('#FFC107') // 警告
              Circle({ width: 40, height: 40 }).fill('#F44336') // 错误
            }
          }

          // 边距,边框与阴影
          Column({ space: 8 }) {
            Text("边距/边框/阴影").fontSize(20).fontWeight(FontWeight.Bold)
            Text("卡片内容")
              .padding({
                left: 32,
                right: 32,
                top: 16,
                bottom: 16
              })
              .backgroundColor(Color.White)
              .border({ width: 1, color: '#E0E0E0' })
              .borderRadius(12)
              .shadow({
                radius: 8,
                color: 'rgba(0,0,0,0.15)',
                offsetX: 0,
                offsetY: 4
              })
          }

          // 背景与渐变
          Column({ space: 8 }) {
            Text("背景与渐变").fontSize(20).fontWeight(FontWeight.Bold)
          }
          .width('100%')
          .height(100)
          .linearGradient({
            angle: 90,
            colors: [['#2196F3', 0.0], ['#ffaa67cf', 1.0]]
          })
          .borderRadius(12)
          .alignItems(HorizontalAlign.Center)
          .justifyContent(FlexAlign.Center)

          // 主题与适配
          Column({ space: 8 }) {
            Text("主题与适配系统").fontSize(20).fontWeight(FontWeight.Bold)
            Text("当前主题颜色")
              .padding(16)
              .backgroundColor(Color.Pink)
              .fontColor(Color.Black)
              .borderRadius(8)
            Text("跟随系统深浅色模式适配").fontSize(14).opacity(0.7)
          }
        }
        .padding(16)
      }
      .scrollable(ScrollDirection.Vertical)
    }
    .title(this.title)
    .titleMode(NavigationTitleMode.Mini)
    .hideBackButton(false)
    .navBarWidth('100%')
    .navBarPosition(NavBarPosition.Start)
  }
}
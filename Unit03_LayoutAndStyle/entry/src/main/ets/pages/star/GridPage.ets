@Entry
@Component
struct GridPage {
  @State title: string = ''

  aboutToAppear() {
    let params = this.getUIContext().getRouter().getParams() as Record<string, Object>
    if (params) {
      this.title = params['title'] as string
    }
  }

  build() {
    Navigation() {
      Grid() {
        ForEach([1, 2, 3, 4, 5, 6, 7, 8, 9], (n: number) => {
          GridItem() {
            Text(`${n}`)
              .width('100%')
              .height('100%')
              .backgroundColor('#2196F3')
              .fontColor(Color.White)
              .fontSize(16)
              .textAlign(TextAlign.Center)
              .borderRadius(6)
              .margin(6)
          }
        })
      }
      .height('60%') // 高度占页面的60%
      .columnsTemplate('1fr 1fr 1fr') // 三列等分
      .rowsTemplate('1fr 1fr 1fr') // 三行固定高度
      .columnsGap(8)
      .rowsGap(8)
      .padding(16)
    }
    .title(this.title)
    .titleMode(NavigationTitleMode.Mini)
    .hideBackButton(false)
    .navBarWidth('100%')
    .navBarPosition(NavBarPosition.Start)
  }
}
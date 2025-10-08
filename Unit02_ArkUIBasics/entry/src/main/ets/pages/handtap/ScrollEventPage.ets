@Entry
@Component
struct ScrollEventPage {
  @State title: string = ''
  @State scrollInfo: string = '等待滚动...'; // 滚动提示信息
  @State scrollOffset: number = 0; // 滚动偏移量
  @State isScrolling: boolean = false; // 滚动状态
  @State articles: string[] = []; // 模拟文章数据列表
  private scrollController: Scroller = new Scroller(); // 滚动控制器

  aboutToAppear() {
    let params = this.getUIContext().getRouter().getParams() as Record<string, Object>
    if (params) {
      this.title = params['title'] as string
    }
    // 初始化文章列表
    for (let i = 1; i <= 20; i++) {
      this.articles.push(`第${i}篇文章 - 这是一篇关于 HarmonyOS 开发的技术文章，内容丰富详实。`);
    }
  }

  build() {
    Navigation() {
      Column() {
        // 滚动状态显示区域
        Row() {
          Column() {
            Text(this.scrollInfo)
              .fontSize(14)
              .fontColor(Color.Blue)

            Text(`滚动位置：${this.scrollOffset.toFixed(0)}px`)
              .fontSize(12)
              .fontColor(Color.Gray)

            Text(`滚动状态：${this.isScrolling ? '滚动中' : '静止'}`)
              .fontSize(12)
              .fontColor(this.isScrolling ? Color.Orange : Color.Green)
          }
          .alignItems(HorizontalAlign.Start)
          .layoutWeight(1)

          // 回到顶部按钮
          Button('回到顶部')
            .fontSize(12)
            .height(32)
            .onClick(() => {
              this.scrollController.scrollTo({ xOffset: 0, yOffset: 0, animation: true });
            })
        }
        .width('100%')
        .padding(16)
        .backgroundColor('#F8F8F8')

        // 滚动内容区域
        Scroll(this.scrollController) {
          Column({ space: 12 }) {
            ForEach(this.articles, (article: string, index: number) => {
              Column({ space: 8 }) {
                Text(`标题 ${index + 1}`)
                  .fontSize(16)
                  .fontWeight(FontWeight.Bold)
                  .width('100%')
                  .textAlign(TextAlign.Start)

                Text(article)
                  .fontSize(14)
                  .fontColor('#666666')
                  .lineHeight(20)
                  .width('100%')

                Divider()
                  .color('#E0E0E0')
              }
              .width('100%')
              .padding(16)
              .backgroundColor('#FFFFFF')
              .borderRadius(8)
            })

            // 底部提示
            Text('已到底部')
              .fontSize(14)
              .fontColor('#999999')
              .padding(20)
          }
          .width('100%')
        }
        .layoutWeight(1)
        .scrollable(ScrollDirection.Vertical)
        .scrollBar(BarState.Auto)
        // 滚动事件绑定
        .onScroll((xOffset: number, yOffset: number) => {
          this.scrollOffset = yOffset;
          this.scrollInfo = '正在滚动...';
          this.isScrolling = true;
        })
        .onScrollStart(() => {
          this.scrollInfo = '开始滚动';
          this.isScrolling = true;
        })
        .onScrollStop(() => {
          this.scrollInfo = '滚动停止';
          this.isScrolling = false;
        })
        .onReachStart(() => {
          this.scrollInfo = '已到达顶部';
        })
        .onReachEnd(() => {
          this.scrollInfo = '已到达底部';
        })
        .padding({ left: 16, right: 16 })
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F5F5F5')
    }
    .title(this.title)
    .titleMode(NavigationTitleMode.Mini)
    .hideBackButton(false)
    .navBarWidth('100%')
    .navBarPosition(NavBarPosition.Start)
  }
}
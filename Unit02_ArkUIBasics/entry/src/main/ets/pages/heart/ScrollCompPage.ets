@Entry
@Component
struct ScrollCompPage {
  @State title: string = ''

  aboutToAppear() {
    let params = this.getUIContext().getRouter().getParams() as Record<string, Object>
    if (params) {
      this.title = params['title'] as string
    }
  }

  @State articles: string[] = [
    '第一章：ArkUI框架概述',
    '第二章：基础组件详解',
    '第三章：状态管理机制',
    '第四章：事件处理系统',
    '第五章：动画与特效',
    '第六章：性能优化策略',
    '第七章：调试技巧总结',
    '第八章：项目实战案例',
    '第九章：最佳实践指南',
    '第十章：未来发展趋势'
  ];
  private scrollController: Scroller = new Scroller();

  build() {
    Navigation() {
      Column({ space: 16 }) {
        // 标题栏
        Text('学习章节')
          .width('100%')
          .height(48)
          .textAlign(TextAlign.Center)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)

        // 滚动内容
        Scroll(this.scrollController) {
          Column({ space: 16 }) {
            ForEach(this.articles, (article: string, index: number) => {
              Column({ space: 8 }) {
                Text(article)
                  .fontSize(18)
                  .fontWeight(FontWeight.Bold)
                  .width('100%')
                  .textAlign(TextAlign.Start)

                Text(`这是${article}的详细内容介绍。在这里我们会深入讲解相关的技术要点、实现原理和最佳实践。通过系统性的学习，帮助开发者更好地掌握HarmonyOS应用开发技能。`)
                  .fontSize(14)
                  .fontColor('#666666')
                  .lineHeight(20)
                  .width('100%')

                Text('—————————————————')
                  .fontSize(12)
                  .fontColor('#CCCCCC')
                  .width('100%')
                  .textAlign(TextAlign.Center)
              }
              .width('100%')
              .padding(16)
              .backgroundColor('#FFFFFF')
              .borderRadius(8)
            })

            Button('回到顶部')
              .fontSize(12)
              .height(32)
              .onClick(() => {
                this.scrollController.scrollTo({ xOffset: 0, yOffset: 0, animation: true });
              })
          }
          .width('100%')
        }
        .layoutWeight(1)
        .scrollable(ScrollDirection.Vertical)
        .scrollBar(BarState.Auto)
        .padding({ left: 16, right: 16 })
      }
      // 顶端对齐
      .align(Alignment.Top)
      .padding(16)
    }
    .title(this.title)
    .titleMode(NavigationTitleMode.Mini)
    .hideBackButton(false)
    .navBarWidth('100%')
    .navBarPosition(NavBarPosition.Start)
  }
}
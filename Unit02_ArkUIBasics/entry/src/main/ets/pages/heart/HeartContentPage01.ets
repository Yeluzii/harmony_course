@Entry
@Component
struct HeartContentPage01 {
  @State title: string = ''
  @State currentTime: string = '';
  @State clickCount: number = 0;

  aboutToAppear() {
    let params = this.getUIContext().getRouter().getParams() as Record<string, Object>
    if (params) {
      this.title = params['title'] as string
    }
    // 组件即将出现时初始化时间
    this.updateTime();
    // 每秒更新一次时间
    setInterval(() => {
      this.updateTime();
    }, 1000);
  }

  updateTime() {
    const now = new Date();
    // 24小时制
    this.currentTime = now.toLocaleTimeString('zh-CN', { hour12: false });
  }

  build() {
    Navigation() {
      Column({ space: 16 }) {
        // 基础文本显示
        Text('基础文本内容')
          .fontSize(16)
          .fontColor(Color.Black)
          .fontWeight(FontWeight.Normal)
          .fontFamily('Arial')

        // 样式丰富的文本
        Text('重要通知信息')
          .fontSize(20)
          .fontColor(Color.Red)
          .fontWeight(FontWeight.Bold)
          .fontStyle(FontStyle.Italic)
          .decoration({
            type: TextDecorationType.Underline,
            color: Color.Red
          })

        // 多行文本处理
        Text('这是一段很长很长很长的文本内容，用于演示文本的换行和对齐功能。在实际应用中，我们经常需要处理这种长文本的显示。')
          .fontSize(14)
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .textAlign(TextAlign.Start)
          .lineHeight(20)

        Text('左对齐文本')
          .width('100%')
          .textAlign(TextAlign.Start)
          .backgroundColor(Color.Gray)
          .padding(10)

        Text('居中对齐文本')
          .width('100%')
          .textAlign(TextAlign.Center)
          .backgroundColor(Color.Gray)
          .padding(10)

        Text('右对齐文本')
          .width('100%')
          .textAlign(TextAlign.End)
          .backgroundColor(Color.Gray)
          .padding(10)

        Text('两端对齐的长文本内容，这种对齐方式在段落文本中比较常用')
          .width('100%')
          .textAlign(TextAlign.JUSTIFY)
          .backgroundColor(Color.Gray)
          .padding(10)

        // 动态时间显示
        Text(`当前时间：${this.currentTime}`)
          .fontSize(18)
          .fontColor(Color.Blue)

        // 计数器显示
        Text(`点击次数：${this.clickCount}`)
          .fontSize(16)
          .fontColor(this.clickCount > 5 ? Color.Red : Color.Black)

        Button('点击计数')
          .onClick(() => {
            this.clickCount++;
          })

        // 条件文本显示
        if (this.clickCount > 0) {
          Text(this.clickCount > 5 ? '点击次数较多' : '点击次数正常')
            .fontSize(14)
            .fontColor(Color.Orange)
        }

        // 使用Span组件创建富文本
        Text() {
          Span('普通文本 ')
          Span('粗体文本 ')
            .fontWeight(FontWeight.Bold)
          Span('红色文本 ')
            .fontColor(Color.Red)
          Span('大号文本')
            .fontSize(20)
        }
        .width('100%')

        // 文本选择功能
        Text('这段文本可以被选择和复制')
          .copyOption(CopyOptions.InApp)
          .fontSize(16)

      }
      .width('100%')
      .padding(16)
    }
    .title(this.title)
    .titleMode(NavigationTitleMode.Mini)
    .hideBackButton(false)
    .navBarWidth('100%')
    .navBarPosition(NavBarPosition.Start)
  }
}
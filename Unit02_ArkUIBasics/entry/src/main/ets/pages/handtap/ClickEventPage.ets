@Entry
@Component
struct ClickEventPage {
  @State title: string = ''

  aboutToAppear() {
    let params = this.getUIContext().getRouter().getParams() as Record<string, Object>
    if (params) {
      this.title = params['title'] as string
    }
  }

  @State clickCount: number = 0; // 点击次数
  @State lastClickTime: string = ''; // 最后点击时间
  @State message: string = '等待点击...'; // 当前提示信息
  @State buttonState: string = 'normal'; // 按钮状态（normal / pressed）

  // 格式化当前时间（时:分:秒）
  private formatTime(): string {
    const now = new Date();
    return `${now.getHours().toString().padStart(2, '0')}:${now.getMinutes()
      .toString()
      .padStart(2, '0')}:${now.getSeconds().toString().padStart(2, '0')}`;
  }

  build() {
    Navigation() {
      Scroll() {
        Column({ space: 20 }) {
          // 页面标题
          Text('点击事件演示')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)

          // 提示信息
          Text(this.message)
            .fontSize(16)
            .fontColor(Color.Blue)

          // 点击次数
          Text(`点击次数：${this.clickCount}`)
            .fontSize(14)

          // 最后点击时间
          Text(`最后点击时间：${this.lastClickTime}`)
            .fontSize(12)
            .fontColor(Color.Gray)

          // 按钮状态
          Text(`按钮状态：${this.buttonState}`)
            .fontSize(12)
            .fontColor(Color.Orange)

          // 单击事件
          Button('单击按钮')
            .onClick(() => {
              this.clickCount++;
              this.lastClickTime = this.formatTime();
              this.message = '执行了单击事件';
            })

          // 长按事件（2秒）
          Button('长按按钮（按住2秒）')
            .backgroundColor(Color.Orange)
            .gesture(
              LongPressGesture({ repeat: false, duration: 2000 })
                .onAction((event: GestureEvent) => {
                  this.message = '执行了长按事件';
                  this.lastClickTime = this.formatTime();
                })
            )

          // 双击事件
          Button('双击按钮')
            .backgroundColor(Color.Green)
            .gesture(
              TapGesture({ count: 2 })
                .onAction(() => {
                  this.message = '执行了双击事件';
                  this.lastClickTime = this.formatTime();
                })
            )

          // 状态感知按钮（按下/释放）
          Button('状态感知按钮')
            .backgroundColor(this.buttonState === 'pressed' ? Color.Red : Color.Blue)
            .onTouch((event: TouchEvent) => {
              switch (event.type) {
                case TouchType.Down:
                  this.buttonState = 'pressed';
                  this.message = '按钮被按下';
                  break;
                case TouchType.Up:
                  this.buttonState = 'normal';
                  this.message = '按钮被释放';
                  break;
              }
            })

          // 重置按钮
          Button('重置')
            .backgroundColor(Color.Gray)
            .onClick(() => {
              this.clickCount = 0;
              this.lastClickTime = '';
              this.message = '已重置';
              this.buttonState = 'normal';
            })
        }
        .width('100%')
        .padding(20)
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
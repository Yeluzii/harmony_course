// 位置接口定义
interface TouchPosition {
  x: number;
  y: number;
}

@Entry
@Component
struct TouchEventPage {
  @State title: string = ''

  aboutToAppear() {
    let params = this.getUIContext().getRouter().getParams() as Record<string, Object>
    if (params) {
      this.title = params['title'] as string
    }
  }

  @State touchInfo: string = '等待触摸...'; // 当前触摸状态
  @State touchPosition: TouchPosition = { x: 0, y: 0 }; // 触摸位置
  @State touchCount: number = 0; // 触摸次数
  @State circlePosition: TouchPosition = { x: 100, y: 100 }; // 圆圈位置

  // 触摸事件处理逻辑
  private handleTouch(event: TouchEvent) {
    this.touchPosition = { x: event.touches[0].x, y: event.touches[0].y } as TouchPosition;

    switch (event.type) {
      case TouchType.Down:
        this.touchInfo = '触摸开始';
        this.touchCount++;
        break;
      case TouchType.Move:
        this.touchInfo = '触摸移动';
        // 移动圆圈跟随触摸位置
        this.circlePosition = { x: event.touches[0].x, y: event.touches[0].y } as TouchPosition;
        break;
      case TouchType.Up:
        this.touchInfo = '触摸结束';
        break;
      case TouchType.Cancel:
        this.touchInfo = '触摸取消';
        break;
    }
  }

  build() {
    Navigation() {
      Scroll() {
        Column({ space: 16 }) {
          // 页面标题
          Text('触摸事件演示')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)

          // 当前触摸状态提示
          Text(this.touchInfo)
            .fontSize(16)
            .fontColor(Color.Blue)

          // 触摸次数
          Text(`触摸次数：${this.touchCount}`)
            .fontSize(14)

          // 触摸位置
          Text(`触摸位置：(${this.touchPosition.x.toFixed(0)}, ${this.touchPosition.y.toFixed(0)})`)
            .fontSize(14)
            .fontColor(Color.Gray)

          // 触摸响应区域
          Stack() {
            // 背景区域
            Column()
              .width('100%')
              .height(300)
              .backgroundColor('#F0F8FF')
              .borderRadius(12)
              .border({ width: 2, color: Color.Blue, style: BorderStyle.Dashed })

            // 跟随触摸的圆圈
            Circle({ width: 30, height: 30 })
              .fill(Color.Red)
              .position({ x: this.circlePosition.x - 15, y: this.circlePosition.y - 15 })

            // 提示文字
            Text('在此区域内触摸和拖动')
              .fontSize(16)
              .fontColor('#666666')
              .position({ x: 50, y: 20 })
          }
          .width('100%')
          .height(300)
          .onTouch((event: TouchEvent) => {
            this.handleTouch(event);
          })

          // 重置按钮
          Button('重置')
            .backgroundColor(Color.Gray)
            .onClick(() => {
              this.touchInfo = '等待触摸...';
              this.touchCount = 0;
              this.touchPosition = { x: 0, y: 0 } as TouchPosition;
              this.circlePosition = { x: 100, y: 100 } as TouchPosition;
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
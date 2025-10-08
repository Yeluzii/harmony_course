@Entry
@Component
struct HeartContentPage02 {
  @State title: string = ''

  aboutToAppear() {
    let params = this.getUIContext().getRouter().getParams() as Record<string, Object>
    if (params) {
      this.title = params['title'] as string
    }
  }

  @State isLoading: boolean = false;
  @State isEnabled: boolean = true;
  @State buttonText: string = '点击我';
  @State likeCount: number = 0;
  @State isLiked: boolean = false;
  @State pressTime: number = 0;

  simulateAsyncOperation() {
    this.isLoading = true;
    this.buttonText = '处理中...';

    // 模拟异步操作
    setTimeout(() => {
      this.isLoading = false;
      this.buttonText = '操作完成';

      // 2秒后恢复初始状态
      setTimeout(() => {
        this.buttonText = '点击我';
      }, 2000);
    }, 3000);
  }

  build() {
    Navigation() {
      Column({ space: 16 }) {
        // 基础按钮
        Button('基础按钮')
          .fontSize(16)
          .fontColor(Color.White)
          .backgroundColor(Color.Blue)
          .borderRadius(8)

        // 不同类型的按钮
        Button('胶囊按钮', { type: ButtonType.Capsule })
          .backgroundColor(Color.Green)
          .fontColor(Color.White)

        Button('圆形按钮', { type: ButtonType.Circle })
          .backgroundColor(Color.Red)
          .width(50)
          .height(50)

        // 自定义样式按钮
        Button('自定义按钮')
          .width(200)
          .height(40)
          .backgroundColor(Color.Orange)
          .borderRadius(20)
          .border({
            width: 2,
            color: Color.Black,
            style: BorderStyle.Solid
          })
          .shadow({
            radius: 5,
            color: Color.Gray,
            offsetX: 2,
            offsetY: 2
          })

        // 状态控制按钮
        Button(this.buttonText)
          .enabled(this.isEnabled && !this.isLoading)
          .backgroundColor(this.isLoading ? Color.Gray : Color.Blue)
          .fontColor(Color.White)
          .onClick(() => {
            this.simulateAsyncOperation();
          })

        // 启用/禁用控制
        Row({ space: 10 }) {
          Button('启用')
            .backgroundColor(Color.Green)
            .onClick(() => {
              this.isEnabled = true;
            })

          Button('禁用')
            .backgroundColor(Color.Red)
            .onClick(() => {
              this.isEnabled = false;
            })
        }

        // 状态指示
        Text(`按钮状态：${this.isEnabled ? '启用' : '禁用'}`)
          .fontSize(14)
          .fontColor(this.isEnabled ? Color.Green : Color.Red)

        // 点赞按钮
        Button() {
          Row({ space: 5 }) {
            Text(this.isLiked ? '❤️' : '🤍')
              .fontSize(20)
            Text(`${this.likeCount}`)
              .fontSize(16)
              .fontColor(Color.White)
          }
        }
        .backgroundColor(this.isLiked ? Color.Red : Color.Gray)
        .borderRadius(25)
        .padding({
          left: 15,
          right: 15,
          top: 8,
          bottom: 8
        })
        .onClick(() => {
          if (this.isLiked) {
            this.likeCount--;
            this.isLiked = false;
          } else {
            this.likeCount++;
            this.isLiked = true;
          }
        })

        // 长按按钮
        Button('长按我试试')
          .backgroundColor(Color.Orange)
          .gesture(
            LongPressGesture({ repeat: true })
              .onAction((event: GestureEvent) => {
                this.pressTime++;
              })
          )
          .onTouch((event: TouchEvent) => {
            if (event.type === TouchType.Up) {
              this.pressTime = 0;
            }
          })

        Text(`长按时间：${this.pressTime}`)
          .fontSize(14)

        // 多功能按钮组
        Row({ space: 10 }) {
          Button('分享')
            .backgroundColor(Color.Blue)
            .flexGrow(1)
            .onClick(() => {
              console.log('分享功能');
            })

          Button('收藏')
            .backgroundColor(Color.Green)
            .flexGrow(1)
            .onClick(() => {
              console.log('收藏功能');
            })

          Button('评论')
            .backgroundColor(Color.Pink)
            .flexGrow(1)
            .onClick(() => {
              console.log('评论功能');
            })
        }
        .width('100%')

      }
      .padding(16)
    }
    .title(this.title)
    .titleMode(NavigationTitleMode.Mini)
    .hideBackButton(false)
    .navBarWidth('100%')
    .navBarPosition(NavBarPosition.Start)
  }
}
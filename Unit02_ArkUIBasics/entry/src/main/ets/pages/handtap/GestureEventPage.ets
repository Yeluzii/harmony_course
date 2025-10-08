interface PanOffset {
  x: number;
  y: number;
}

@Entry
@Component
struct GestureEventPage {
  @State title: string = ''

  aboutToAppear() {
    let params = this.getUIContext().getRouter().getParams() as Record<string, Object>
    if (params) {
      this.title = params['title'] as string
    }
  }

  @State gestureInfo: string = '等待手势...'; // 当前手势信息
  @State panOffset: PanOffset = { x: 0, y: 0 }; // 拖拽偏移
  @State _scale: number = 1; // 缩放比例
  @State rotation: number = 0; // 旋转角度

  build() {
    Navigation() {
      Scroll() {
        Column({ space: 20 }) {
          // 页面标题
          Text('手势事件演示')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)

          // 当前手势状态提示
          Text(this.gestureInfo)
            .fontSize(16)
            .fontColor(Color.Blue)

          // 偏移信息
          Text(`偏移：(${this.panOffset.x.toFixed(0)}, ${this.panOffset.y.toFixed(0)})`)
            .fontSize(14)

          // 缩放信息
          Text(`缩放：${this._scale.toFixed(2)}倍`)
            .fontSize(14)

          // 旋转信息
          Text(`旋转：${this.rotation.toFixed(0)}度`)
            .fontSize(14)

          // 手势响应区域
          Stack() {
            // 背景区域
            Column()
              .width('100%')
              .height(300)
              .backgroundColor('#F0F8FF')
              .borderRadius(12)
              .border({ width: 2, color: Color.Green, style: BorderStyle.Dashed })

            // 可操作的方块
            Column() {
              Text('拖我')
                .fontSize(16)
                .fontColor(Color.White)
            }
            .width(80)
            .height(80)
            .backgroundColor(Color.Orange)
            .borderRadius(8)
            .justifyContent(FlexAlign.Center)
            // 应用拖拽/缩放/旋转的状态
            .translate({ x: this.panOffset.x, y: this.panOffset.y })
            .scale({ x: this._scale, y: this._scale })
            .rotate({ angle: this.rotation })
            .gesture(
              // 拖拽手势
              PanGesture()
                .onActionStart(() => {
                  this.gestureInfo = '开始拖拽';
                })
                .onActionUpdate((event: GestureEvent) => {
                  this.panOffset.x = event.offsetX;
                  this.panOffset.y = event.offsetY;
                  this.gestureInfo = '拖拽中...';
                })
                .onActionEnd(() => {
                  this.gestureInfo = '拖拽结束';
                })
            )
          }
          .width('100%')
          .height(300)
          // 缩放手势
          .gesture(
            PinchGesture()
              .onActionStart(() => {
                this.gestureInfo = '开始缩放';
              })
              .onActionUpdate((event: GestureEvent) => {
                this._scale = event.scale;
                this.gestureInfo = `缩放中：${event.scale.toFixed(2)}倍`;
              })
              .onActionEnd(() => {
                this.gestureInfo = '缩放结束';
              })
          )
          // 旋转手势
          .gesture(
            RotationGesture()
              .onActionStart(() => {
                this.gestureInfo = '开始旋转';
              })
              .onActionUpdate((event: GestureEvent) => {
                this.rotation = event.angle;
                this.gestureInfo = `旋转中：${event.angle.toFixed(0)}度`;
              })
              .onActionEnd(() => {
                this.gestureInfo = '旋转结束';
              })
          )

          // 操作按钮区
          Row({ space: 10 }) {
            Button('重置位置')
              .onClick(() => {
                this.panOffset = { x: 0, y: 0 } as PanOffset;
              })

            Button('重置缩放')
              .onClick(() => {
                this._scale = 1;
              })

            Button('重置旋转')
              .onClick(() => {
                this.rotation = 0;
              })
          }
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
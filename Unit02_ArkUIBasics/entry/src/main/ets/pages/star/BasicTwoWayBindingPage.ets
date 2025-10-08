@Entry
@Component
struct BasicTwoWayBindingPage {
  @State title: string = ''

  aboutToAppear() {
    let params = this.getUIContext().getRouter().getParams() as Record<string, Object>
    if (params) {
      this.title = params['title'] as string
    }
  }

  @State inputText: string = ''; // 文本输入绑定
  @State sliderValue: number = 50; // 滑块绑定
  @State switchValue: boolean = false; // 开关绑定
  @State checkboxValue: boolean = false; // 复选框绑定

  build() {
    Navigation() {
      Scroll() {
        Column({ space: 20 }) {
          // 页面标题
          Text('基础双向绑定演示')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)

          // 文本输入双向绑定
          Column({ space: 8 }) {
            Text('文本输入绑定：')
              .fontSize(16)
              .alignSelf(ItemAlign.Start)

            TextInput({ placeholder: '请输入文本', text: $$this.inputText })
              .width('100%')
              .height(44)
              .borderRadius(6)
              .backgroundColor('#F7F7F7')

            Text(`输入内容：${this.inputText}`)
              .fontSize(14)
              .fontColor(Color.Blue)
              .alignSelf(ItemAlign.Start)

            Text(`字符长度：${this.inputText.length}`)
              .fontSize(12)
              .fontColor(Color.Gray)
              .alignSelf(ItemAlign.Start)
          }
          .alignItems(HorizontalAlign.Start)
          .width('100%')

          // 滑块双向绑定
          Column({ space: 8 }) {
            Text('滑块数值绑定：')
              .fontSize(16)
              .alignSelf(ItemAlign.Start)

            Slider({
              value: $$this.sliderValue,
              min: 0,
              max: 100,
              step: 1
            })
              .width('100%')
              .trackColor('#E0E0E0')
              .selectedColor(Color.Blue)

            Text(`当前数值：${this.sliderValue.toFixed(0)}`)
              .fontSize(14)
              .fontColor(Color.Blue)
              .alignSelf(ItemAlign.Start)

            // 进度条显示
            Progress({ value: this.sliderValue, total: 100, type: ProgressType.Linear })
              .width('100%')
              .color(Color.Green)
          }
          .alignItems(HorizontalAlign.Start)
          .width('100%')

          // 开关双向绑定
          Row({ space: 12 }) {
            Text('开关状态绑定：')
              .fontSize(16)

            Toggle({ type: ToggleType.Switch, isOn: $$this.switchValue })
              .selectedColor(Color.Blue)

            Text(this.switchValue ? '开启' : '关闭')
              .fontSize(14)
              .fontColor(this.switchValue ? Color.Green : Color.Red)
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)

          // 复选框双向绑定
          Row({ space: 12 }) {
            Text('复选框绑定：')
              .fontSize(16)

            Checkbox({ name: 'agreement', group: 'checkboxGroup' })
              .select($$this.checkboxValue)
              .selectedColor(Color.Blue)

            Text(this.checkboxValue ? '已选中' : '未选中')
              .fontSize(14)
              .fontColor(this.checkboxValue ? Color.Green : Color.Gray)
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)

          // 重置按钮
          Button('重置所有状态')
            .width('100%')
            .height(44)
            .backgroundColor(Color.Gray)
            .onClick(() => {
              this.inputText = '';
              this.sliderValue = 50;
              this.switchValue = false;
              this.checkboxValue = false;
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
interface FormData {
  name: string;
  email: string;
  phone: string;
  comment: string;
}

@Entry
@Component
struct FocusEventPage {
  @State title: string = ''

  aboutToAppear() {
    let params = this.getUIContext().getRouter().getParams() as Record<string, Object>
    if (params) {
      this.title = params['title'] as string
    }
  }

  @State focusInfo: string = '等待焦点事件...'; // 当前焦点提示信息
  @State currentFocus: string = ''; // 当前获得焦点的字段名
  @State _tabIndex: number = 0; // 备用索引（演示时可扩展 Tab 切换）
  @State formData: FormData = {
    name: '',
    email: '',
    phone: '',
    comment: ''
  };

  // 获得焦点时更新状态
  private handleFocus(fieldName: string) {
    this.currentFocus = fieldName;
    this.focusInfo = `${fieldName} 获得焦点`;
  }

  // 失去焦点时更新状态
  private handleBlur(fieldName: string) {
    this.focusInfo = `${fieldName} 失去焦点`;
    this.currentFocus = '';
  }

  build() {
    Navigation() {
      Scroll() {
        Column({ space: 16 }) {
          // 页面标题
          Text('焦点事件演示')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)

          // 提示信息
          Text(this.focusInfo)
            .fontSize(16)
            .fontColor(Color.Blue)

          // 当前焦点
          Text(`当前焦点：${this.currentFocus || '无'}`)
            .fontSize(14)
            .fontColor(Color.Gray)

          // 表单字段区
          Column({ space: 12 }) {
            // 姓名
            TextInput({ placeholder: '请输入姓名', text: this.formData.name })
              .width('100%')
              .height(44)
              .borderRadius(6)
              .backgroundColor(this.currentFocus === '姓名' ? '#E3F2FD' : '#F7F7F7')
              .borderWidth(this.currentFocus === '姓名' ? 2 : 1)
              .borderColor(this.currentFocus === '姓名' ? Color.Blue : Color.Gray)
              .onFocus(() => this.handleFocus('姓名'))
              .onBlur(() => this.handleBlur('姓名'))
              .onChange((value: string) => {
                this.formData.name = value;
              })

            // 邮箱
            TextInput({ placeholder: '请输入邮箱', text: this.formData.email })
              .width('100%')
              .height(44)
              .borderRadius(6)
              .backgroundColor(this.currentFocus === '邮箱' ? '#E3F2FD' : '#F7F7F7')
              .borderWidth(this.currentFocus === '邮箱' ? 2 : 1)
              .borderColor(this.currentFocus === '邮箱' ? Color.Blue : Color.Gray)
              .type(InputType.Email)
              .onFocus(() => this.handleFocus('邮箱'))
              .onBlur(() => this.handleBlur('邮箱'))
              .onChange((value: string) => {
                this.formData.email = value;
              })

            // 电话
            TextInput({ placeholder: '请输入电话', text: this.formData.phone })
              .width('100%')
              .height(44)
              .borderRadius(6)
              .backgroundColor(this.currentFocus === '电话' ? '#E3F2FD' : '#F7F7F7')
              .borderWidth(this.currentFocus === '电话' ? 2 : 1)
              .borderColor(this.currentFocus === '电话' ? Color.Blue : Color.Gray)
              .type(InputType.PhoneNumber)
              .onFocus(() => this.handleFocus('电话'))
              .onBlur(() => this.handleBlur('电话'))
              .onChange((value: string) => {
                this.formData.phone = value;
              })

            // 备注
            TextInput({ placeholder: '请输入备注信息', text: this.formData.comment })
              .width('100%')
              .height(80)
              .borderRadius(6)
              .backgroundColor(this.currentFocus === '备注' ? '#E3F2FD' : '#F7F7F7')
              .borderWidth(this.currentFocus === '备注' ? 2 : 1)
              .borderColor(this.currentFocus === '备注' ? Color.Blue : Color.Gray)
              .type(InputType.Normal)
              .onFocus(() => this.handleFocus('备注'))
              .onBlur(() => this.handleBlur('备注'))
              .onChange((value: string) => {
                this.formData.comment = value;
              })
          }

          // 操作按钮区
          Row({ space: 12 }) {
            // 清空按钮
            Button('清空表单')
              .layoutWeight(1)
              .backgroundColor(Color.Gray)
              .onClick(() => {
                this.formData = {
                  name: '',
                  email: '',
                  phone: '',
                  comment: ''
                } as FormData;
                this.focusInfo = '表单已清空';
              })

            // 提交按钮
            Button('提交表单')
              .layoutWeight(1)
              .backgroundColor(Color.Green)
              .onClick(() => {
                this.focusInfo = '表单提交成功';
                AlertDialog.show({
                  message: `姓名：${this.formData.name}\n邮箱：${this.formData.email}\n电话：${this.formData.phone}\n备注：${this.formData.comment}`,
                  primaryButton: {
                    value: '确定', action: () => {
                    }
                  }
                });
              })
          }
          .width('100%')
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
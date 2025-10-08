@Entry
@Component
struct TextInputPage {
  @State title: string = ''

  aboutToAppear() {
    let params = this.getUIContext().getRouter().getParams() as Record<string, Object>
    if (params) {
      this.title = params['title'] as string
    }
  }

  @State username: string = '';
  @State password: string = '';
  @State email: string = '';
  @State studentId: string = '';
  @State studentName: string = '';
  @State phoneNumber: string = '';
  @State studentIdError: string = '';
  @State studentNameError: string = '';
  @State phoneError: string = '';

  // 验证学号（8位数字）
  private validateStudentId(id: string): string {
    if (!id) {
      return '学号不能为空';
    }
    if (!/^\d{8}$/.test(id)) {
      return '学号必须为8位数字';
    }
    return '';
  }

  // 验证姓名
  private validateStudentName(name: string): string {
    if (!name.trim()) {
      return '姓名不能为空';
    }
    if (name.trim().length < 2) {
      return '姓名至少2个字符';
    }
    if (name.trim().length > 10) {
      return '姓名不能超过10个字符';
    }
    return '';
  }

  // 验证手机号
  private validatePhoneNumber(phone: string): string {
    if (!phone) {
      return '手机号不能为空';
    }
    if (!/^1[3-9]\d{9}$/.test(phone)) {
      return '请输入正确的手机号格式';
    }
    return '';
  }

  // 校验整个表单
  private isFormValid(): boolean {
    return !this.studentIdError && !this.studentNameError && !this.phoneError;
  }

  build() {
    Navigation() {
      Scroll() {
        Column({ space: 16 }) {
          Text('用户注册')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)

          // 用户名输入
          TextInput({ placeholder: '请输入用户名', text: $$this.username })
            .width('100%')
            .height(44)
            .borderRadius(6)
            .backgroundColor('#F7F7F7')
            .placeholderColor('#999999')
            .onChange((value: string) => {
              this.username = value;
            })

          // 密码输入
          TextInput({ placeholder: '请输入密码', text: $$this.password })
            .width('100%')
            .height(44)
            .borderRadius(6)
            .backgroundColor('#F7F7F7')
            .placeholderColor('#999999')
            .type(InputType.Password)
            .showPasswordIcon(true)

          // 邮箱输入
          TextInput({ placeholder: '请输入邮箱地址', text: $$this.email })
            .width('100%')
            .height(44)
            .borderRadius(6)
            .backgroundColor('#F7F7F7')
            .placeholderColor('#999999')
            .type(InputType.Email)

          // 显示输入内容
          Column({ space: 8 }) {
            Text(`用户名: ${this.username}`)
              .fontSize(14)
            Text(`密码: ${'*'.repeat(this.password.length)}`)
              .fontSize(14)
            Text(`邮箱: ${this.email}`)
              .fontSize(14)
          }
          .alignItems(HorizontalAlign.Start)
          .width('100%')
          .padding(16)
          .backgroundColor('#F0F0F0')
          .borderRadius(8)

          Text('学生信息录入')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)

          // 学号输入
          Column({ space: 4 }) {
            TextInput({ placeholder: '请输入8位学号', text: $$this.studentId })
              .width('100%')
              .height(44)
              .borderRadius(6)
              .backgroundColor('#F7F7F7')
              .type(InputType.Number)
              .maxLength(8)
              .borderWidth(this.studentIdError ? 1 : 0)
              .borderColor(Color.Red)
              .onChange((value: string) => {
                this.studentId = value;
                this.studentIdError = this.validateStudentId(value);
              })

            if (this.studentIdError) {
              Text(this.studentIdError)
                .fontSize(12)
                .fontColor(Color.Red)
                .alignSelf(ItemAlign.Start)
            }
          }

          // 姓名输入
          Column({ space: 4 }) {
            TextInput({ placeholder: '请输入姓名', text: $$this.studentName })
              .width('100%')
              .height(44)
              .borderRadius(6)
              .backgroundColor('#F7F7F7')
              .borderWidth(this.studentNameError ? 1 : 0)
              .borderColor(Color.Red)
              .onChange((value: string) => {
                this.studentName = value;
                this.studentNameError = this.validateStudentName(value);
              })

            if (this.studentNameError) {
              Text(this.studentNameError)
                .fontSize(12)
                .fontColor(Color.Red)
                .alignSelf(ItemAlign.Start)
            }
          }

          // 手机号输入
          Column({ space: 4 }) {
            TextInput({ placeholder: '请输入手机号', text: $$this.phoneNumber })
              .width('100%')
              .height(44)
              .borderRadius(6)
              .backgroundColor('#F7F7F7')
              .type(InputType.PhoneNumber)
              .maxLength(11)
              .borderWidth(this.phoneError ? 1 : 0)
              .borderColor(Color.Red)
              .onChange((value: string) => {
                this.phoneNumber = value;
                this.phoneError = this.validatePhoneNumber(value);
              })

            if (this.phoneError) {
              Text(this.phoneError)
                .fontSize(12)
                .fontColor(Color.Red)
                .alignSelf(ItemAlign.Start)
            }
          }

          // 提交按钮
          Button('提交')
            .width('100%')
            .height(44)
            .borderRadius(6)
            .backgroundColor(this.isFormValid() ? Color.Blue : Color.Gray)
            .enabled(this.isFormValid())
            .onClick(() => {
              if (this.isFormValid()) {
                AlertDialog.show({
                  message: '信息提交成功！',
                  primaryButton: {
                    value: '确定',
                    action: () => {
                      // 清空表单
                      this.studentId = '';
                      this.studentName = '';
                      this.phoneNumber = '';
                    }
                  }
                });
              }
            })
        }
        .width('100%')
        .padding(16)
      }
    }
    .title(this.title)
    .titleMode(NavigationTitleMode.Mini)
    .hideBackButton(false)
    .navBarWidth('100%')
    .navBarPosition(NavBarPosition.Start)
  }
}
/**
 * @file: EditableUserInfo.ets
 * @author: Yeluzii
 * @date: 2025/10/01
 */

export // 定义用户信息类型
interface UserInfo {
  name: string;
  email: string;
  age: number;
  bio: string;
}

// 子组件：可编辑的用户信息
@Component
export struct EditableUserInfo {
  @Link userInfo: UserInfo; // 双向绑定用户信息
  @Link isEditing: boolean; // 双向绑定编辑状态

  build() {
    Column({ space: 15 }) {
      // 顶部：标题 + 编辑/保存按钮
      Row() {
        Text('个人信息')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .flexGrow(1)

        Button(this.isEditing ? '保存' : '编辑')
          .fontSize(12)
          .backgroundColor(this.isEditing ? Color.Green : Color.Blue)
          .onClick(() => {
            this.isEditing = !this.isEditing;
          })
      }
      .width('100%')

      // 编辑模式：显示输入框
      if (this.isEditing) {
        Column({ space: 12 }) {
          TextInput({ placeholder: '姓名', text: this.userInfo.name })
            .onChange((value: string) => {
              this.userInfo.name = value;
            })

          TextInput({ placeholder: '邮箱', text: this.userInfo.email })
            .type(InputType.Email)
            .onChange((value: string) => {
              this.userInfo.email = value;
            })

          TextInput({ placeholder: '年龄', text: this.userInfo.age.toString() })
            .type(InputType.Number)
            .onChange((value: string) => {
              const age = parseInt(value);
              this.userInfo.age = isNaN(age) ? 0 : age;
            })

          TextArea({ placeholder: '个人简介', text: this.userInfo.bio })
            .height(80)
            .onChange((value: string) => {
              this.userInfo.bio = value;
            })
        }
      } else {
        // 非编辑模式：展示用户信息
        Column({ space: 8 }) {
          Row() {
            Text('姓名：')
              .fontSize(14)
              .fontColor(Color.Gray)
            Text(this.userInfo.name)
              .fontSize(14)
              .fontWeight(FontWeight.Bold)
          }
          .width('100%')

          Row() {
            Text('邮箱：')
              .fontSize(14)
              .fontColor(Color.Gray)
            Text(this.userInfo.email)
              .fontSize(14)
          }
          .width('100%')

          Row() {
            Text('年龄：')
              .fontSize(14)
              .fontColor(Color.Gray)
            Text(`${this.userInfo.age}岁`)
              .fontSize(14)
          }
          .width('100%')

          Text(this.userInfo.bio)
            .fontSize(14)
            .fontColor('#666666')
            .margin({ top: 5 })
        }
        .alignItems(HorizontalAlign.Start)
      }
    }
    .width('100%')
    .padding(15)
    .backgroundColor(Color.White)
    .borderRadius(12)
  }
}
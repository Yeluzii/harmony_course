/**
 * @file: UserSettingsPage.ets
 * @author: Yeluzii
 * @date: 2025/10/01
 */
import { EditableUserInfo, UserInfo } from './comp/EditableUserInfo';

@Entry
@Component
struct UserSettingsPage {
  @State title: string = ''

  aboutToAppear() {
    let params = this.getUIContext().getRouter().getParams() as Record<string, Object>
    if (params) {
      this.title = params['title'] as string
    }
  }

  @State userInfo: UserInfo = {
    name: '张同学',
    email: 'zhang@example.com',
    age: 20,
    bio: '热爱编程的计算机专业学生，专注于移动应用开发。'
  };
  @State isEditing: boolean = false;

  build() {
    Navigation() {
      Scroll() {
        Column({ space: 20 }) {
          Text('用户设置')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)

          // 可编辑用户信息组件
          EditableUserInfo({
            userInfo: $userInfo,
            isEditing: $isEditing
          })

          // 实时状态展示区
          Column({ space: 10 }) {
            Text('实时状态')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .alignSelf(ItemAlign.Start)

            Text(`编辑模式：${this.isEditing ? '开启' : '关闭'}`)
              .fontSize(12)
              .fontColor(Color.Gray)

            Text(`姓名：${this.userInfo.name}`)
              .fontSize(12)
              .fontColor(Color.Gray)

            Text(`邮箱：${this.userInfo.email}`)
              .fontSize(12)
              .fontColor(Color.Gray)
          }
          .width('100%')
          .padding(15)
          .backgroundColor('#F8F9FA')
          .borderRadius(12)
          .alignItems(HorizontalAlign.Start)
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
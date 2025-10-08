import { ComponentItem } from "../model/componentItem"

@Component
export struct StarPage {
  navigate: NavPathStack = new NavPathStack()
  componentList: ComponentItem[] = [
    {
      title: 'Complex State Page',
      description: 'Complex State Page',
      icon: '🌟',
      route: 'pages/star/StarContentPage01'
    },
    {
      title: '@Prop：单向数据传递',
      description: '@Prop：单向数据传递',
      icon: '🌟',
      route: 'pages/star/StarContentPage02'
    },
    {
      title: '@Link：双向数据绑定',
      description: '@Link：双向数据绑定',
      icon: '🌟',
      route: 'pages/star/UserSettingsPage'
    },
    {
      title: '基础双向绑定机制',
      description: '基础双向绑定机制',
      icon: '🌟',
      route: 'pages/star/BasicTwoWayBindingPage'
    },
    {
      title: '表单联动与验证',
      description: '表单联动与验证',
      icon: '🌟',
      route: 'pages/star/FormValidationPage'
    },
    {
      title: '数据驱动UI更新',
      description: '数据驱动UI更新',
      icon: '🌟',
      route: 'pages/star/DataDrivenUIPage'
    }
  ]

  build() {
    Column() {
      Text('Star')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: 20, bottom: 20 })

      List({ space: 15 }) {
        ForEach(this.componentList, (item: ComponentItem, index: number) => {
          ListItem() {
            Row({ space: 15 }) {
              Text(item.icon)
                .fontSize(24)
                .width(40)
                .textAlign(TextAlign.Center)

              Column({ space: 5 }) {
                Text(item.title)
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .alignSelf(ItemAlign.Start)

                Text(item.description)
                  .fontSize(14)
                  .fontColor('#666666')
                  .alignSelf(ItemAlign.Start)
              }
              .alignItems(HorizontalAlign.Start)
              .layoutWeight(1)

              Text('>')
                .fontSize(18)
                .fontColor('#999999')
            }
            .width('100%')
            .padding(20)
            .backgroundColor($r('app.color.bg_white'))
            .borderRadius(12)
            .shadow({
              radius: 4,
              color: $r('app.color.border_shadow'),
              offsetX: 0,
              offsetY: 2
            })
          }
          .onClick(() => {

            this.getUIContext().getRouter().pushUrl({
              url: item.route,
              params: {
                title: item.title
              }
            }).catch((err: Error) => {
              console.error('路由跳转失败:', err.message)
            })

          })
        })
      }
      .layoutWeight(1)
      .padding({ left: 20, right: 20, bottom: 20 })
    }
    .height('100%')
    .backgroundColor($r('app.color.page_bg'))
  }
}
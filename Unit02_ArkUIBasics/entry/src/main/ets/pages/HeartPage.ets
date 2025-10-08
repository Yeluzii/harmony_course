import { ComponentItem } from "../model/componentItem"

@Component
export struct HeartPage {
  navigate: NavPathStack = new NavPathStack()
  componentList: ComponentItem[] = [
    {
      title: '文本显示与样式',
      description: '文本显示与样式',
      icon: '💗',
      route: 'pages/heart/HeartContentPage01'
    },
    {
      title: 'Button 组件： 交互与事件',
      description: 'Button 组件： 交互与事件',
      icon: '💗',
      route: 'pages/heart/HeartContentPage02'
    },
    {
      title: 'Image 组件：图片显示与处理',
      description: 'Image 组件：图片显示与处理',
      icon: '💗',
      route: 'pages/heart/ImageCompPage'
    },
    {
      title: 'TextInput 组件：文本输入与验证',
      description: 'TextInput 组件：文本输入与验证',
      icon: '💗',
      route: 'pages/heart/TextInputPage'
    },
    {
      title: 'List 组件：高效数据展示',
      description: 'List 组件：高效数据展示',
      icon: '💗',
      route: 'pages/heart/ListCompPage'
    },
    {
      title: '可操作列表',
      description: '可操作列表',
      icon: '💗',
      route: 'pages/heart/InteractiveListPage'
    },
    {
      title: 'Scroll 组件：滚动容器',
      description: 'Scroll 组件：滚动容器',
      icon: '💗',
      route: 'pages/heart/ScrollCompPage'
    }
  ]

  build() {
    Column() {
      Text('Heart')
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
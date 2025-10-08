import hilog from '@ohos.hilog'

// 卡片接口
interface CardItem {
  title: string
  description: string
  color: string
}

// 导航项接口
interface NavItem {
  label: string
  icon: Resource
}

@Entry
@Component
struct ResponsiveFlexPage {
  @State title: string = ''
  // 卡片数据
  private readonly cardData: CardItem[] = [
    { title: '课程学习', description: '查看课程内容和进度', color: '#FF5722' },
    { title: '作业提交', description: '完成并提交作业', color: '#FF9800' },
    { title: '成绩查询', description: '查看考试和作业成绩', color: '#FFC107' },
    { title: '通知公告', description: '接收重要通知', color: '#4CAF50' },
    { title: '在线讨论', description: '参与课程讨论', color: '#2196F3' },
    { title: '资源下载', description: '下载课程资料', color: '#9C27B0' }
  ]
  // 导航数据
  private readonly navItems: NavItem[] = [
    { label: '首页', icon: $r('app.media.startIcon') },
    { label: '课程', icon: $r('app.media.startIcon') },
    { label: '作业', icon: $r('app.media.startIcon') },
    { label: '成绩', icon: $r('app.media.startIcon') },
    { label: '我的', icon: $r('app.media.startIcon') }
  ]

  aboutToAppear() {
    let params = this.getUIContext().getRouter().getParams() as Record<string, Object>
    if (params) {
      this.title = params['title'] as string
    }
  }

  // --- 卡片网格 ---
  @Builder
  ResponsiveCardGrid() {
    Column({ space: 12 }) {
      Text('响应式Flex卡片布局')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.SpaceAround }) {
        ForEach(this.cardData, (item: CardItem) => {
          this.ResponsiveCard(item)
        }, (item: CardItem) => item.title) // 用 title 作为唯一 key
      }
      .width('100%')
    }
  }

  // 单个卡片
  @Builder
  ResponsiveCard(item: CardItem) {
    Column({ space: 12 }) {
      Text(item.title)
        .fontSize(16).fontWeight(FontWeight.Bold)
        .fontColor(Color.White).textAlign(TextAlign.Center)

      Text(item.description)
        .fontSize(12)
        .fontColor(Color.White)
        .opacity(0.9)
        .textAlign(TextAlign.Center)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })

      Button('进入')
        .width(80)
        .height(32)
        .fontSize(12)
        .backgroundColor('rgba(255, 255, 255, 0.2)')
        .fontColor(Color.White)
        .borderRadius(16)
    }
    .width(150)
    .height(120)
    .padding(16)
    .backgroundColor(item.color)
    .borderRadius(12)
    .margin(8)
    .flexShrink(1)
    .constraintSize({ minWidth: 120, maxWidth: 200 })
    .shadow({
      radius: 8,
      color: 'rgba(0,0,0,0.15)',
      offsetX: 0,
      offsetY: 4
    })
  }

  // --- 导航栏 ---
  @Builder
  ResponsiveNavigation() {
    Column({ space: 16 }) {
      Text('响应式导航栏')
        .fontSize(18).fontWeight(FontWeight.Bold)

      Flex({ justifyContent: FlexAlign.SpaceEvenly, alignItems: ItemAlign.Center }) {
        ForEach(this.navItems, (nav: NavItem) => {
          Column({ space: 4 }) {
            Image(nav.icon).width(24).height(24).fillColor('#666')
            Text(nav.label).fontSize(12).fontColor('#666')
          }
          .flexGrow(1)
          .alignItems(HorizontalAlign.Center)
          .padding(8)
          .onClick(() => {
            hilog.info(0x0001, 'hilog', 'onClick: ' + nav.label)
          })
        }, (nav: NavItem) => nav.label)
      }
      .width('100%')
      .height(60)
      .backgroundColor(Color.White)
      .borderRadius(8)
      .shadow({
        radius: 4,
        color: 'rgba(0,0,0,0.1)',
        offsetX: 0,
        offsetY: 2
      })
    }
  }

  // --- 表单 ---
  @Builder
  ResponsiveForm() {
    Column({ space: 16 }) {
      Text('响应式表单布局')
        .fontSize(18).fontWeight(FontWeight.Bold)

      Column({ space: 16 }) {
        // 姓名
        Flex({ alignItems: ItemAlign.Center }) {
          Text('姓名').fontSize(14).fontColor('#333').width(60).flexShrink(0)
          TextInput({ placeholder: '请输入姓名' })
            .flexGrow(1)
            .height(40)
            .backgroundColor('#F8F9FA')
            .borderRadius(8)
            .margin({ left: 12 })
        }

        // 学号 + 班级
        Flex({ wrap: FlexWrap.Wrap, alignItems: ItemAlign.Center }) {
          // 学号
          Flex({ alignItems: ItemAlign.Center }) {
            Text('学号').fontSize(14).fontColor('#333').width(60)
            TextInput({ placeholder: '学号' })
              .width(120)
              .height(40)
              .backgroundColor('#F8F9FA')
              .borderRadius(8)
              .margin({ left: 12 })
          }
          .flexBasis('45%')
          .constraintSize({ minWidth: 200 })

          // 班级
          Flex({ wrap: FlexWrap.Wrap, alignItems: ItemAlign.Center, justifyContent: FlexAlign.SpaceBetween }) {
            Text('班级').fontSize(14).fontColor('#333').width(60)
            TextInput({ placeholder: '班级' })
              .width(120)
              .height(40)
              .backgroundColor('#F8F9FA')
              .borderRadius(8)
              .margin({ left: 12 })
          }
          .flexBasis('45%')
          .constraintSize({ minWidth: 200 })
        }

        // 按钮
        Flex({ justifyContent: FlexAlign.Center }) {
          Button('取消')
            .width(100)
            .height(40)
            .backgroundColor('#E0E0E0')
            .fontColor('#666')
            .borderRadius(8)
          Button('提交')
            .width(100)
            .height(40)
            .backgroundColor('#007AFF')
            .fontColor(Color.White)
            .borderRadius(8)
            .margin({ left: 16 })
        }
      }
      .padding(16).backgroundColor(Color.White).borderRadius(8)
      .shadow({
        radius: 4,
        color: 'rgba(0,0,0,0.1)',
        offsetX: 0,
        offsetY: 2
      })
    }
  }

  build() {
    Navigation() {
      Scroll() {
        Column({ space: 24 }) {
          this.ResponsiveCardGrid()
          this.ResponsiveNavigation()
          this.ResponsiveForm()
        }
        .padding(16)
      }
      .scrollable(ScrollDirection.Vertical)
      .scrollBar(BarState.Auto)
    }
    .title(this.title)
    .titleMode(NavigationTitleMode.Mini)
    .hideBackButton(false)
    .navBarWidth('100%')
    .navBarPosition(NavBarPosition.Start)
  }
}
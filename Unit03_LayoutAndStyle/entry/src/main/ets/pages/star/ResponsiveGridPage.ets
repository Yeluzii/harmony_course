import display from '@ohos.display'
import hilog from '@ohos.hilog'

// 课程卡片数据结构
interface CourseCard {
  id: number
  title: string
  description: string
  icon: string
  color: ResourceColor
}

@Entry
@Component
struct ResponsiveGridPage {
  @State title: string = ''
  // 课程数据
  @State cards: CourseCard[] = [
    {
      id: 1,
      title: "课程学习",
      description: "在线课程和视频教程",
      icon: "📚",
      color: '#FBC527'
    },
    {
      id: 2,
      title: "作业提交",
      description: "提交和管理作业",
      icon: "📝",
      color: Color.Green
    },
    {
      id: 3,
      title: "成绩查询",
      description: "查看考试成绩和统计",
      icon: "📊",
      color: Color.Pink
    },
    {
      id: 4,
      title: "通知公告",
      description: "学校通知和公告",
      icon: "📢",
      color: Color.Red
    },
    {
      id: 5,
      title: "在线讨论",
      description: "师生交流讨论区",
      icon: "💬",
      color: Color.Gray
    },
    {
      id: 6,
      title: "资源下载",
      description: "学习资料和资源",
      icon: "📥",
      color: Color.Blue
    },
    {
      id: 7,
      title: "考试安排",
      description: "考试时间和地点",
      icon: "📅",
      color: Color.Grey
    },
    {
      id: 8,
      title: "校园活动",
      description: "课外活动和社团",
      icon: "🎭",
      color: Color.Pink
    }
  ]
  @State columns: number = 2 // 默认列数

  private updateColumns() {
    try {
      const displayInfo = display.getDefaultDisplaySync()
      const screenWidthPx = displayInfo.width
      const screenHeightPx = displayInfo.height
      const density = displayInfo.densityPixels // 获取屏幕密度

      // 转换为虚拟像素 (VP)
      const screenWidthVp = screenWidthPx / density
      const screenHeightVp = screenHeightPx / density

      // console.log(`屏幕信息: ${screenWidthPx}x${screenHeightPx}px, 密度: ${density}, VP: ${screenWidthVp.toFixed(1)}x${screenHeightVp.toFixed(1)}vp`)
      hilog.info(0x0, 'ResponsiveGridExample',
        `屏幕信息: ${screenWidthPx}x${screenHeightPx}px, 密度: ${density}, VP: ${screenWidthVp.toFixed(1)}x${screenHeightVp.toFixed(1)}vp`)

      // 判断是否为横屏
      const isLandscape = screenWidthVp > screenHeightVp

      // 根据屏幕宽度和方向设置列数
      if (screenWidthVp < 400) {
        // 小屏手机：始终1列
        this.columns = 1
      } else if (screenWidthVp < 600) {
        // 普通手机：竖屏2列，横屏3列
        this.columns = isLandscape ? 3 : 2
      } else if (screenWidthVp < 900) {
        // 大屏手机/小平板：竖屏3列，横屏4列
        this.columns = isLandscape ? 4 : 3
      } else {
        // 大平板：竖屏3列，横屏4列
        this.columns = isLandscape ? 4 : 3
      }

      // console.log(`屏幕方向: ${isLandscape ? '横屏' : '竖屏'}, 设置列数: ${this.columns}`)
      hilog.info(0x0, 'ResponsiveGridExample', `屏幕方向: ${isLandscape ? '横屏' : '竖屏'}, 列数: ${this.columns}`)

      // console.log(`设置列数: ${this.columns}`)
      hilog.info(0x0, 'ResponsiveGridExample', `列数: ${this.columns}`)
    } catch (error) {
      // console.error('获取屏幕信息失败:', error)
      hilog.error(0x0, 'ResponsiveGridExample', `获取屏幕信息失败: ${error}`)
      this.columns = 2 // 默认2列
    }
  }

  aboutToAppear() {
    let params = this.getUIContext().getRouter().getParams() as Record<string, Object>
    if (params) {
      this.title = params['title'] as string
    }
    this.updateColumns()
  }

  build() {
    Navigation() {
      Column() {
        Text(`响应式网格布局 - 当前 ${this.columns} 列`)
          .fontSize(20)
          .fontColor(Color.Black)
          .margin({ bottom: 10 })

        Grid() {
          ForEach(this.cards, (card: CourseCard) => {
            GridItem() {
              Column({ space: 10 }) {
                Text(card.icon)
                  .fontSize(50)

                Text(card.title)
                  .fontSize(20)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(Color.Black)

                Text(card.description)
                  .fontSize(16)
                  .fontColor(Color.Black)
                  .opacity(0.9)
                  .maxLines(2)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })

                Button("进入")
                  .padding({
                    left: 5,
                    right: 5
                  })
                  .fontSize(16)
                  .backgroundColor('#fff')
                  .fontColor(card.color)
              }
              .width('100%')
              .height(180)
              .padding(5)
              .backgroundColor(card.color)
              .borderRadius(16)
              .justifyContent(FlexAlign.Center)
              .alignItems(HorizontalAlign.Center)
              .shadow({
                radius: 16,
                color: Color.Yellow,
                offsetX: 0,
                offsetY: 2
              })
            }
          })
        }
        .columnsTemplate(`1fr `.repeat(this.columns).trim())
        .rowsGap(10)
        .columnsGap(10)
        .padding(5)
        .width('100%')
      }
      .width('100%')
      .height('100%')
    }
    .title(this.title)
    .titleMode(NavigationTitleMode.Mini)
    .hideBackButton(false)
    .navBarWidth('100%')
    .navBarPosition(NavBarPosition.Start)
  }
}
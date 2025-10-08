import { GridItemExample } from "./comp/GridItemExample"
import { WaterfallExample } from "./comp/WaterfallExample"

export interface DashboardGridItem {
  id: number
  title: string
  content: string
  backgroundColor: ResourceColor
  height?: number
}

@Entry
@Component
struct IrregularGridPage {
  @State title: string = ''

  @State gridItems: DashboardGridItem[] = [
    {
      id: 1,
      title: "仪表盘",
      content: "实时数据监控",
      backgroundColor: $r('app.color.bg_yellow'),
      height: 200
    },
    {
      id: 2,
      title: "销售趋势",
      content: "月度增长 25%",
      backgroundColor: Color.Green,
      height: 100
    },
    {
      id: 3,
      title: "用户统计",
      content: "活跃用户 1.2K",
      backgroundColor: Color.Blue,
      height: 100
    },
    {
      id: 4,
      title: "任务列表",
      content: "待办事项 8 项",
      backgroundColor: Color.Orange,
      height: 200
    },
    {
      id: 5,
      title: "消息通知",
      content: "新消息 3 条",
      backgroundColor: Color.Red,
      height: 100
    },
    {
      id: 6,
      title: "系统状态",
      content: "运行正常",
      backgroundColor: Color.Pink,
      height: 100
    },
    {
      id: 7,
      title: "快速操作",
      content: "常用功能入口",
      backgroundColor: Color.Green,
      height: 100
    },
    {
      id: 8,
      title: "最新动态",
      content: "实时更新中",
      backgroundColor: Color.Brown,
      height: 100
    }
  ]

  aboutToAppear() {
    let params = this.getUIContext().getRouter().getParams() as Record<string, Object>
    if (params) {
      this.title = params['title'] as string
    }
  }

  build() {
    Navigation() {
      Scroll() {
        Column() {
          // 不规则网格布局示例
          GridItemExample({ gridItems: this.gridItems })

          // Blank().height($r('app.float.spacing_xl'))

          // 瀑布流布局示例
          WaterfallExample()
        }
        .padding(5)
        .width('100%')
      }
      .scrollable(ScrollDirection.Vertical)
      .scrollBar(BarState.Auto)
      .edgeEffect(EdgeEffect.Spring)
    }
    .title(this.title)
    .titleMode(NavigationTitleMode.Mini)
    .hideBackButton(false)
    .navBarWidth('100%')
    .navBarPosition(NavBarPosition.Start)
  }
}
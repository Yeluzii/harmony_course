import { CountProvider } from '../../providers/CountProvider';
import { hilog } from '@kit.PerformanceAnalysisKit';

const TAG: string = 'HeartContentPage01';
const DOMAIN: number = 0x0006;

// 初始化PersistentStorage，确保counter_value属性被持久化
PersistentStorage.persistProp('counter_value', 0);

@Entry
@Component
struct HeartContentPage01 {
  @State count: number = 0
  @State title: string = ''

  private countProvider: CountProvider = CountProvider.getInstance();

  aboutToAppear() {
    let params = this.getUIContext().getRouter().getParams() as Record<string,Object>
    if (params) {
      this.title = params['title'] as string
    }

    // 初始化计数器数据
    this.initCountData();

  }

  // 初始化计数器数据
  private async initCountData(): Promise<void> {
    try {
      await this.countProvider.init();
      // 初始化页面中的计数器值
      this.count = this.countProvider.getCount()
      hilog.info(DOMAIN, TAG, `页面计数器初始化完成，当前值: ${this.count}`);
    } catch (error) {
      hilog.error(DOMAIN, TAG, `页面计数器初始化失败: ${JSON.stringify(error)}`);
    }
  }

  // 增加计数
  private async increment(): Promise<void> {
    await this.countProvider.increment();
    this.count = this.countProvider.getCount()
  }

  // 减少计数
  private async decrement(): Promise<void> {
    await this.countProvider.decrement();
    this.count = this.countProvider.getCount()
  }

  // 重置计数
  private async reset(): Promise<void> {
    await this.countProvider.reset();
    this.count = this.countProvider.getCount()
  }

  build() {
    Navigation() {
      // 计数器区域
      Column({ space: 10 }) {
        Text("计数器")
          .fontSize(24)
          .width('100%')
          .textAlign(TextAlign.Center)

        Text(`${this.count}`)
          .fontSize(48)
          .fontWeight(FontWeight.Bold)
          .width('100%')
          .textAlign(TextAlign.Center)

        Row({ space: 20 }) {
          Button('-')
            .type(ButtonType.Normal)
            .width(45)
            .height(45)
            .fontSize(24)
            .backgroundColor($r('app.color.primary_blue'))
            .fontColor(Color.White)
            .onClick(() => {
              this.decrement();
            })

          Button('重置')
            .type(ButtonType.Normal)
            .width(60)
            .height(40)
            .fontSize(14)
            .backgroundColor($r('app.color.primary_blue'))
            .fontColor(Color.White)
            .onClick(() => {
              this.reset();
            })

          Button('+')
            .type(ButtonType.Normal)
            .width(45)
            .height(45)
            .fontSize(24)
            .backgroundColor($r('app.color.primary_blue'))
            .fontColor(Color.White)
            .onClick(() => {
              this.increment();
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
      }
    }
    .title(this.title)
    .titleMode(NavigationTitleMode.Mini)
    .hideBackButton(false)
    .navBarWidth('100%')
    .navBarPosition(NavBarPosition.Start)
  }
}
/**
 * @file: CountCard.ets
 * @author: Yeluzii
 * @date: 2025/10/15
 */

import { CountProvider } from '../../providers/CountProvider';

let storageX = new LocalStorage()

@Entry(storageX)
@Component
struct CountCard {
  @LocalStorageProp('counter_value') count: number = 0;
  private countProvider: CountProvider = CountProvider.getInstance();

  build() {
    Stack() {
      // 主要内容区域
      Column({ space: 16 }) {
        // 标题
        Text("计数器")
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor($r('app.color.text_primary'))
          .width('100%')
          .textAlign(TextAlign.Center)

        // 计数显示（大字体）
        Text(`${this.count}`)
          .fontSize(72)
          .fontWeight(FontWeight.Bold)
          .fontColor($r('app.color.primary_blue'))
          .width('100%')
          .textAlign(TextAlign.Center)
          .margin({ top: 8 })

        // 操作按钮
        Row({ space: 20 }) {
          Button('-')
            .type(ButtonType.Normal)
            .width(50)
            .height(50)
            .fontSize(28)
            .backgroundColor($r('app.color.primary_blue'))
            .fontColor(Color.White)
            .borderRadius(25)
            .onClick(() => {
              postCardAction(this, {
                action: "message",
                params: {
                  method: 'decrement',
                  counter_value: this.count
                }
              })
            })

          Button('重置')
            .type(ButtonType.Normal)
            .width(70)
            .height(50)
            .fontSize(16)
            .backgroundColor($r('app.color.primary_blue'))
            .fontColor(Color.White)
            .borderRadius(8)
            .onClick(() => {
              postCardAction(this, {
                action: "message",
                params: {
                  method: 'reset',
                  counter_value: this.count
                }
              })
            })

          Button('+')
            .type(ButtonType.Normal)
            .width(50)
            .height(50)
            .fontSize(28)
            .backgroundColor($r('app.color.primary_blue'))
            .fontColor(Color.White)
            .borderRadius(25)
            .onClick(() => {
              postCardAction(this, {
                action: "message",
                params: {
                  method: 'increment',
                  counter_value: this.count
                }
              })
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .margin({ top: 16 })
      }
      .width('100%')
      .height('100%')
      .padding(24)
      .justifyContent(FlexAlign.Center)
      .backgroundColor($r('app.color.card_background'))
      .borderRadius(16)
      .shadow({
        radius: 8,
        color: $r('app.color.shadow'),
        offsetX: 0,
        offsetY: 2
      })
      .onClick(() => {
        // 点击卡片跳转到应用
        postCardAction(this, {
          action: 'router',
          abilityName: 'EntryAbility',
          params: {
            page: 'pages/Index'
          }
        });
      })
    }
    .width('100%')
    .height('100%')
  }
}
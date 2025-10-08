@Entry
@Component
struct ImageCompPage {
  @State title: string = ''

  aboutToAppear() {
    let params = this.getUIContext().getRouter().getParams() as Record<string, Object>
    if (params) {
      this.title = params['title'] as string
    }
  }

  @State isLoading: boolean = true;
  @State loadError: boolean = false;
  @State imageUrl: string = 'http://117.72.93.22:9000/yeluzi-se/ye_space/54c36f38-57c3-45ae-ac06-abd78a1c944d.png';
  @State showImage: boolean = false;
  @State loadingRotation: number = 0;

  build() {
    Navigation() {
      Scroll() {
        Column({ space: 16 }) {
          Text('图片显示示例')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)

          // 本地资源图片
          Image($r('app.media.camera__logo'))
            .width(120)
            .height(120)
            .borderRadius(8)

          // 网络图片
          Image('http://117.72.93.22:9000/yeluzi-se/ye_space/54c36f38-57c3-45ae-ac06-abd78a1c944d.png')
            .width(120)
            .height(120)
            .borderRadius(8)

          Grid() {
            GridItem() {
              Column() {
                Image($r('app.media.1'))
                  .width(100)
                  .height(100)
                  .objectFit(ImageFit.Contain)
                  .border({ width: 1, color: Color.Gray })
                Text('Contain')
                  .fontSize(12)
              }
            }

            GridItem() {
              Column() {
                Image($r('app.media.1'))
                  .width(100)
                  .height(100)
                  .objectFit(ImageFit.Cover)
                  .border({ width: 1, color: Color.Gray })
                Text('Cover')
                  .fontSize(12)
              }
            }

            GridItem() {
              Column() {
                Image($r('app.media.1'))
                  .width(100)
                  .height(100)
                  .objectFit(ImageFit.Fill)
                  .border({ width: 1, color: Color.Gray })
                Text('Fill')
                  .fontSize(12)
              }
            }

            GridItem() {
              Column() {
                Image($r('app.media.1'))
                  .width(100)
                  .height(100)
                  .objectFit(ImageFit.ScaleDown)
                  .border({ width: 1, color: Color.Gray })
                Text('ScaleDown')
                  .fontSize(12)
              }
            }
          }
          .columnsTemplate('1fr 1fr')
          .rowsTemplate('1fr 1fr')
          .columnsGap(10)
          .rowsGap(10)
          .width('100%')
          .height(240)

          Text('图片加载状态管理')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)

          Stack() {
            Image(this.imageUrl)
              .width(200)
              .height(200)
              .objectFit(ImageFit.Cover)
              .borderRadius(8)
              .opacity(this.showImage ? 1 : 0)
              .onComplete(() => {
                // 模拟网络延时，2秒后显示图片
                setTimeout(() => {
                  this.isLoading = false;
                  this.loadError = false;
                  this.showImage = true;
                }, 2000);
              })
              .onError(() => {
                setTimeout(() => {
                  this.isLoading = false;
                  this.loadError = true;
                }, 1000);
              })

            // 加载中遮罩
            if (this.isLoading && !this.loadError) {
              Column({ space: 8 }) {
                Text('⟳')
                  .fontSize(24)
                  .fontColor(Color.Blue)
                  .rotate({ angle: this.loadingRotation })
                  .animation({
                    duration: 1000,
                    iterations: -1,
                    curve: Curve.Linear
                  })
                  .onAppear(() => {
                    // 启动旋转动画
                    const timer = setInterval(() => {
                      this.loadingRotation += 360;
                    }, 1000);

                    // 当加载完成时清理定时器
                    setTimeout(() => {
                      clearInterval(timer);
                    }, 10000);
                  })
                Text('加载中...')
                  .fontSize(14)
                  .fontColor(Color.Gray)
              }
              .width(200)
              .height(200)
              .justifyContent(FlexAlign.Center)
              .backgroundColor('#F5F5F5')
              .borderRadius(8)
            }

            // 错误状态遮罩
            if (this.loadError) {
              Column({ space: 8 }) {
                Text('加载失败')
                  .fontSize(14)
                  .fontColor(Color.Red)
                Button('重试')
                  .fontSize(12)
                  .height(30)
                  .onClick(() => {
                    this.isLoading = true;
                    this.loadError = false;
                    this.showImage = false;
                    // 重新触发图片加载，添加时间戳避免缓存
                    this.imageUrl = this.imageUrl.split('?')[0] + '?retry=' + Date.now();
                  })
              }
              .width(200)
              .height(200)
              .justifyContent(FlexAlign.Center)
              .backgroundColor('#F5F5F5')
              .borderRadius(8)
            }
          }
          .width(200)
          .height(200)

          // 图片信息显示
          Text(`状态：${this.isLoading ? '加载中' : this.loadError ? '加载失败' : '加载成功'}`)
            .fontSize(14)

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
// 定义学生信息接口
interface StudentInfo {
  name: string
  id: string
  major: string
  grade: number
}

@Entry
@Component
struct HeartContentPage01 {
  @State title: string = ''

  // 基础状态
  @State message: string = 'Hello HarmonyOS NEXT'
  @State clickCount: number = 0

  // 学生信息状态
  @State currentStudent: StudentInfo = {
    name: '张三',
    id: '2024001',
    major: '软件工程',
    grade: 95
  }

  // UI控制状态
  @State showStudentInfo: boolean = false
  @State currentTime: string = ''

  // 组件即将出现时调用
  aboutToAppear() {
    let params = this.getUIContext().getRouter().getParams() as Record<string,Object>
    if (params) {
      this.title = params['title'] as string
    }
    this.updateCurrentTime()
    // 每秒更新一次时间
    setInterval(() => {
      this.updateCurrentTime()
    }, 1000)
  }

  // 更新当前时间
  updateCurrentTime() {
    const now = new Date()
    this.currentTime = now.toLocaleString('zh-CN')
  }

  // 构建欢迎卡片
  @Builder buildWelcomeCard() {
    Column() {
      Column({ space: 12 }) {
        Text('🎉 欢迎来到鸿蒙世界！')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FF333333')

        Text(this.message)
          .fontSize(16)
          .fontColor('#FF666666')
          .textAlign(TextAlign.Center)
          .width('100%')
      }
      .padding(20)
    }
    .width('100%')
    .backgroundColor('#FFFFFFFF')
    .borderRadius(12)
  }

  // 构建功能按钮区域
  @Builder buildActionButtons() {
    Row({ space: 16 }) {
      Button('点击体验')
        .fontSize(16)
        .flexGrow(1)
        .height(50)
        .backgroundColor('#FF007DFF')
        .borderRadius(8)
        .onClick(() => {
          this.handleMainButtonClick()
        })

      Button(this.showStudentInfo ? '隐藏信息' : '显示信息')
        .fontSize(16)
        .flexGrow(1)
        .height(50)
        .backgroundColor('#FF00C853')
        .borderRadius(8)
        .onClick(() => {
          this.showStudentInfo = !this.showStudentInfo
        })
    }
    .width('100%')
  }

  // 构建学生信息卡片
  @Builder buildStudentInfoCard() {
    Column() {
      Column({ space: 16 }) {
        Text('📚 学生信息')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FF333333')

        Column({ space: 8 }) {
          this.buildInfoRow('姓名', this.currentStudent.name)
          this.buildInfoRow('学号', this.currentStudent.id)
          this.buildInfoRow('专业', this.currentStudent.major)
          this.buildInfoRow('成绩', `${this.currentStudent.grade}分`)
        }
        .alignItems(HorizontalAlign.Start)
        .width('100%')

        // 成绩等级显示
        Row() {
          Text('等级：')
            .fontSize(16)
            .fontColor('#FF666666')

          Text(this.getGradeLevel(this.currentStudent.grade))
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.getGradeColor(this.currentStudent.grade))
        }
        .width('100%')
      }
      .padding(20)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .backgroundColor('#FFFFFFFF')
    .borderRadius(12)
  }

  // 构建信息行
  @Builder buildInfoRow(label: string, value: string) {
    Row() {
      Text(`${label}：`)
        .fontSize(16)
        .fontColor('#FF666666')
        .width(60)

      Text(value)
        .fontSize(16)
        .fontColor('#FF333333')
        .flexGrow(1)
    }
    .width('100%')
  }

  // 构建统计信息卡片
  @Builder buildStatsCard() {
    Column() {
      Column({ space: 16 }) {
        Text('📊 使用统计')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FF333333')

        Row() {
          Column() {
            Text(`${this.clickCount}`)
              .fontSize(32)
              .fontWeight(FontWeight.Bold)
              .fontColor('#FF007DFF')

            Text('点击次数')
              .fontSize(14)
              .fontColor('#FF666666')
          }
          .flexGrow(1)

          Column() {
            Text(this.getEngagementLevel())
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor('#FF00C853')

            Text('参与度')
              .fontSize(14)
              .fontColor('#FF666666')
          }
          .flexGrow(1)
        }

        if (this.clickCount > 0) {
          Button('重置统计')
            .fontSize(14)
            .width('100%')
            .height(40)
            .backgroundColor('#FFFF9500')
            .borderRadius(8)
            .onClick(() => {
              this.resetAll()
            })
        }
      }
      .padding(20)
    }
    .width('100%')
    .backgroundColor('#FFFFFFFF')
    .borderRadius(12)
  }

  // 处理主按钮点击
  handleMainButtonClick() {
    this.clickCount++

    const messages = [
      '太棒了！你学会了HarmonyOS开发！',
      '继续探索，发现更多可能！',
      '你真是个勤奋的学习者！',
      'HarmonyOS的世界很精彩！',
      '恭喜你！已经是HarmonyOS专家了！'
    ]

    const randomIndex = Math.floor(Math.random() * messages.length)
    this.message = messages[randomIndex]
  }

  // 获取成绩等级
  getGradeLevel(score: number): string {
    if (score >= 90) return '优秀'
    if (score >= 80) return '良好'
    if (score >= 70) return '中等'
    if (score >= 60) return '及格'
    return '不及格'
  }

  // 获取成绩颜色
  getGradeColor(score: number): string {
    if (score >= 90) return '#FF00C853'  // 绿色
    if (score >= 80) return '#FF2196F3'  // 蓝色
    if (score >= 70) return '#FFFF9500'  // 橙色
    if (score >= 60) return '#FFFF5722'  // 深橙色
    return '#FFF44336'                   // 红色
  }

  // 获取参与度等级
  getEngagementLevel(): string {
    if (this.clickCount === 0) return '新手'
    if (this.clickCount < 5) return '入门'
    if (this.clickCount < 10) return '熟练'
    if (this.clickCount < 20) return '专家'
    return '大师'
  }

  // 重置所有状态
  resetAll() {
    this.clickCount = 0
    this.message = 'Hello HarmonyOS NEXT'
    this.showStudentInfo = false
  }

  build() {
    Navigation() {
      // 主要内容区域
      Scroll() {
        Column({ space: 20 }) {
          // 欢迎卡片
          this.buildWelcomeCard()

          // 功能按钮区域
          this.buildActionButtons()

          // 学生信息卡片（条件显示）
          if (this.showStudentInfo) {
            this.buildStudentInfoCard()
          }

          // 统计信息
          this.buildStatsCard()
        }
        .padding(16)
      }
      .flexGrow(1)
    }
    .title(this.title)
    .titleMode(NavigationTitleMode.Mini)
    .hideBackButton(false)
    .navBarWidth('100%')
    .navBarPosition(NavBarPosition.Start)
  }
}
import { Course } from '../../model/Course'

@Entry
@Component
struct HeartContentPage02 {
  @State title: string = ''

  aboutToAppear() {
    let params = this.getUIContext().getRouter().getParams() as Record<string, Object>
    if (params) {
      this.title = params['title'] as string
    }
  }

  @State currentDay: number = 1; // 当前选中的星期，默认周一
  @State courses: Course[] = [
    {
      name: 'HarmonyOS开发基础',
      teacher: '张教授',
      time: '08:00-09:40',
      location: '计算机楼301',
      type: '理论课',
      day: 1
    },
    {
      name: '移动应用开发实践',
      teacher: '李老师',
      time: '10:00-11:40',
      location: '实验楼5',
      type: '实践课',
      day: 1
    },
    {
      name: '数据库原理',
      teacher: '王老师',
      time: '14:00-15:40',
      location: '教学楼205',
      type: '理论课',
      day: 2
    }
    // 可根据需要添加更多课程数据
  ];

  @Builder
  buildCourseCard(course: Course) {
    Column({ space: 2 }) {
      Text(course.name)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
      Row({ space: 5 }) {
        Text(`教师: `)
          .fontColor('#C1C1C1')
          .fontSize(16)
        Text(course.teacher)
          .fontSize(16)
      }

      Row({ space: 5 }) {
        Text(`时间: `)
          .fontColor('#C1C1C1')
          .fontSize(16)
        Text(course.time)
          .fontSize(16)
      }

      Row({ space: 5 }) {
        Text(`地点: `)
          .fontColor('#C1C1C1')
          .fontSize(16)
        Text(course.location)
          .fontSize(16)
      }

      Row({ space: 5 }) {
        Text(`类型: `)
          .fontColor('#C1C1C1')
          .fontSize(16)
        Text(course.type)
          .fontSize(16)
      }
    }
    .shadow(ShadowStyle.OUTER_DEFAULT_SM)
    .border({
      radius: 16
    })
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .padding(10)
    .backgroundColor('#FFFFFF')
    .margin(5)
  }

  // 构建星期切换标签
  @Builder
  buildDayTab(day: number, dayText: string) {
    Text(dayText)
      .fontSize(16)
      .padding(5)
      .backgroundColor(this.currentDay === day ? '#007DFF' : '#FFFFFF')
      .fontColor(this.currentDay === day ? '#FFFFFF' : '#000000')
      .borderRadius(5)
      .onClick(() => {
        this.currentDay = day;
      });
  }

  // 获取星期的文字表示
  getDayText(day: number): string {
    const days = ['', '周一', '周二', '周三', '周四', '周五', '周六', '周日'];
    return days[day];
  }

  // 获取今日课程数量
  getTodayCourseCount(): number {
    return this.courses.filter(course => course.day === this.currentDay).length;
  }

  // 简化版：计算当前日期所有课程的总时长（分钟）
  getTotalDuration(): number {
    let total = 0;
    this.courses.forEach(course => {
      if (course.day === this.currentDay) {
        // 分割时间字符串 "08:00-09:40"
        const GeneratedDestructArray_1 = course.time.split('-');
        const start = GeneratedDestructArray_1[0];
        const end = GeneratedDestructArray_1[1];
        // 转换为分钟数
        const startMin = parseInt(start.split(':')[0]) * 60 + parseInt(start.split(':')[1]);
        const endMin = parseInt(end.split(':')[0]) * 60 + parseInt(end.split(':')[1]);
        // 累加时长
        total += endMin - startMin;
      }
    });
    return total;
  }

  build() {
    Column() {
      // 顶部标题栏
      Row() {
        Text('我的课程表')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
        Blank()
        Text(this.getDayText(this.currentDay))
          .fontSize(18)
      }
      .padding(10)
      .backgroundColor('#007DFF')
      .width('100%')

      // 星期切换栏
      Row() {
        this.buildDayTab(1, '周一')
        this.buildDayTab(2, '周二')
        this.buildDayTab(3, '周三')
        this.buildDayTab(4, '周四')
        this.buildDayTab(5, '周五')
        this.buildDayTab(6, '周六')
        this.buildDayTab(7, '周日')
      }
      .padding(5)
      .width('100%')

      // 课程统计信息
      Row() {
        Column() {
          Text(this.getTodayCourseCount().toString())
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
          Text('今日课程')
            .fontSize(14)
        }
        .flexGrow(1)

        Column() {
          Text('1') // 这里收藏课程数可根据实际情况动态获取
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
          Text('收藏课程')
            .fontSize(14)
        }
        .flexGrow(1)

        Column() {
          Text(this.getTotalDuration().toString()) // 总时长可根据实际情况动态计算
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor('#00CC00')
          Text('总时长')
            .fontSize(14)
        }
        .flexGrow(1)
      }
      .padding(10)
      .width('100%')

      // 课程列表
      List() {
        ForEach(
          this.courses.filter(course => course.day === this.currentDay),
          (course: Course) => {
            ListItem() {
              this.buildCourseCard(course)
            }
          }
        )
      }
      .width('100%')
      .padding(10)
    }
    .width('100%')
    .height('100%')
  }
}
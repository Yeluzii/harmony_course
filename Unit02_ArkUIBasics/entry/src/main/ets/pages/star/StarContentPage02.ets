import { ListStudentInfo, StudentCard } from './comp/StudentCard';

// 父组件：学生列表
@Entry
@Component
struct StarContentPage02 {
  @State title: string = ''

  aboutToAppear() {
    let params = this.getUIContext().getRouter().getParams() as Record<string, Object>
    if (params) {
      this.title = params['title'] as string
    }
  }

  @State students: ListStudentInfo[] = [
    {
      id: 'CS001',
      name: '张三',
      major: '计算机科学与技术',
      grade: '大二',
      gpa: 3.8
    },
    {
      id: 'CS002',
      name: '李四',
      major: '软件工程',
      grade: '大三',
      gpa: 3.6
    },
    {
      id: 'CS003',
      name: '王五',
      major: '大数据技术',
      grade: '大一',
      gpa: 3.9
    },
    {
      id: 'CS004',
      name: '赵六',
      major: '人工智能',
      grade: '大四',
      gpa: 3.4
    }
  ];
  @State selectedStudentId: string = '';

  build() {
    Navigation() {
      Column({ space: 20 }) {
        Text('班级学生管理')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)

        Text(`选中学生：${this.selectedStudentId || '无'}`)
          .fontSize(14)
          .fontColor(Color.Gray)

        Grid() {
          ForEach(this.students, (student: ListStudentInfo) => {
            GridItem() {
              StudentCard({
                student: student,
                isSelected: this.selectedStudentId === student.id
              })
            }
            .onClick(() => {
              this.selectedStudentId = this.selectedStudentId === student.id ? '' : student.id;
            })
          })
        }
        .columnsTemplate('1fr 1fr')
        .rowsGap(15)
        .columnsGap(15)
        .width('100%')

        if (this.selectedStudentId) {
          Row({ space: 15 }) {
            Button('查看详情')
              .flexGrow(1)
              .backgroundColor('#2196F3')
              .onClick(() => {
                console.log(`查看学生详情：${this.selectedStudentId}`);
              })

            Button('编辑信息')
              .flexGrow(1)
              .backgroundColor('#4CAF50')
              .onClick(() => {
                console.log(`编辑学生信息：${this.selectedStudentId}`);
              })
          }
          .width('100%')
        }
      }
      .padding(16)
    }
    .title(this.title)
    .titleMode(NavigationTitleMode.Mini)
    .hideBackButton(false)
    .navBarWidth('100%')
    .navBarPosition(NavBarPosition.Start)
  }
}
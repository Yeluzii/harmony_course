interface Student {
  id: string;
  name: string;
  major: string;
  grade: string;
  avatar: string;
}

@Entry
@Component
struct ListCompPage {
  @State title: string = ''

  aboutToAppear() {
    let params = this.getUIContext().getRouter().getParams() as Record<string, Object>
    if (params) {
      this.title = params['title'] as string
    }
  }

  @State students: Student[] = [
    {
      id: 'A001',
      name: '张三',
      major: '计算机科学',
      grade: '大二',
      avatar: '👨‍💻'
    },
    {
      id: 'A002',
      name: '李四',
      major: '软件工程',
      grade: '大三',
      avatar: '👩‍💻'
    },
    {
      id: 'A003',
      name: '王五',
      major: '数据科学',
      grade: '大一',
      avatar: '👨‍🎓'
    },
    {
      id: 'A004',
      name: '赵六',
      major: '人工智能',
      grade: '大四',
      avatar: '👩‍🎓'
    },
    {
      id: 'A005',
      name: '钱七',
      major: '计算机科学',
      grade: '大二',
      avatar: '👨‍💻'
    },
    {
      id: 'A006',
      name: '孙八',
      major: '软件工程',
      grade: '大一',
      avatar: '👩‍💻'
    }
  ];

  @Builder
  StudentItem(student: Student) {
    Row({ space: 15 }) {
      Text(student.avatar)
        .fontSize(32)
        .width(50)
        .height(50)
        .backgroundColor('#E3F2FD')
        .borderRadius(25)
        .textAlign(TextAlign.Center)

      Column({ space: 5 }) {
        Row() {
          Text(student.name)
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333')

          Blank()

          Text(student.grade)
            .fontSize(14)
            .fontColor('#666666')
            .backgroundColor('#F0F0F0')
            .padding({
              left: 8,
              right: 8,
              top: 2,
              bottom: 2
            })
            .borderRadius(10)
        }
        .width('100%')

        Text(student.major)
          .fontSize(14)
          .fontColor('#999999')
          .alignSelf(ItemAlign.Start)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .padding({
      left: 16,
      right: 16,
      top: 12,
      bottom: 12
    })
    .backgroundColor('#FFFFFF')
    .borderRadius(8)
  }

  build() {
    Navigation() {
      Column() {
        Text('学生名单')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .padding(16)

        List({ space: 8 }) {
          ForEach(this.students, (student: Student) => {
            ListItem() {
              this.StudentItem(student)
            }
            .onClick(() => {
              AlertDialog.show({
                message: `学生信息：\n姓名：${student.name}\n专业：${student.major}\n年级：${student.grade}`,
                primaryButton: {
                  value: '确定', action: () => {
                  }
                }
              });
            })
          }, (student: Student) => student.id)
        }
        .layoutWeight(1)
        .padding({ left: 16, right: 16 })
        .cachedCount(3)
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F5F5F5')
    }
    .title(this.title)
    .titleMode(NavigationTitleMode.Mini)
    .hideBackButton(false)
    .navBarWidth('100%')
    .navBarPosition(NavBarPosition.Start)
  }
}
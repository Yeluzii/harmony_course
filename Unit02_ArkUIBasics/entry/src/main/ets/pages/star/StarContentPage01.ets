interface ComplexGrade {
  subject: string;
  score: number;
}

interface ComplexStudent {
  name: string;
  age: number;
  grades: Array<ComplexGrade>;
}

@Entry
@Component
struct StarContentPage01 {
  @State title: string = ''

  aboutToAppear() {
    let params = this.getUIContext().getRouter().getParams() as Record<string, Object>
    if (params) {
      this.title = params['title'] as string
    }
  }

  @State student: ComplexStudent = {
    name: '张同学',
    age: 20,
    grades: [
      { subject: 'HarmonyOS开发', score: 85 },
      { subject: '数据结构', score: 92 },
      { subject: '计算机网络', score: 78 }
    ]
  };
  @State newSubject: string = '';
  @State newScore: number = 0;

  // 计算平均分
  getAverageScore(): number {
    if (this.student.grades.length === 0) {
      return 0;
    }
    const total = this.student.grades.reduce((sum: number, grade: ComplexGrade) => sum + grade.score, 0);
    return Math.round(total / this.student.grades.length);
  }

  // 添加成绩
  addGrade() {
    if (this.newSubject && this.newScore > 0 && this.newScore <= 100) {
      // 创建新的grades数组
      const newGrades: Array<ComplexGrade> = [];
      for (let i = 0; i < this.student.grades.length; i++) {
        newGrades.push(this.student.grades[i]);
      }
      newGrades.push({
        subject: this.newSubject,
        score: this.newScore
      });

      // 创建新的student对象来触发状态更新
      this.student = {
        name: this.student.name,
        age: this.student.age,
        grades: newGrades
      };
      this.newSubject = '';
      this.newScore = 0;
    }
  }

  // 删除成绩
  removeGrade(index: number) {
    // 创建新的grades数组
    const newGrades: Array<ComplexGrade> = [];
    for (let i = 0; i < this.student.grades.length; i++) {
      if (i !== index) {
        newGrades.push(this.student.grades[i]);
      }
    }

    // 创建新的student对象来触发状态更新
    this.student = {
      name: this.student.name,
      age: this.student.age,
      grades: newGrades
    };
  }

  build() {
    Navigation() {
      Column({ space: 16 }) {
        // 学生信息
        Row({ space: 15 }) {
          Text('👨‍🎓')
            .fontSize(32)

          Column({ space: 5 }) {
            Text(this.student.name)
              .fontSize(20)
              .fontWeight(FontWeight.Bold)

            Text(`年龄：${this.student.age}岁`)
              .fontSize(14)
              .fontColor(Color.Gray)

            Text(`平均分：${this.getAverageScore()}分`)
              .fontSize(16)
              .fontColor(this.getAverageScore() >= 85 ? Color.Green : Color.Orange)
              .fontWeight(FontWeight.Bold)
          }
          .alignItems(HorizontalAlign.Start)
          .flexGrow(1)
        }
        .width('100%')
        .padding(15)
        .backgroundColor(Color.White)
        .borderRadius(12)

        // 成绩列表
        Text('课程成绩')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .alignSelf(ItemAlign.Start)

        Column({ space: 10 }) {
          ForEach(this.student.grades, (grade: ComplexGrade, index) => {
            Row({ space: 15 }) {
              Text(grade.subject)
                .fontSize(14)
                .flexGrow(1)

              Text(`${grade.score}分`)
                .fontSize(14)
                .fontWeight(FontWeight.Bold)
                .fontColor(grade.score >= 85 ? Color.Green : grade.score >= 70 ? Color.Orange : Color.Red)

              Button('删除')
                .fontSize(12)
                .backgroundColor(Color.Red)
                .fontColor(Color.White)
                .height(30)
                .onClick(() => {
                  this.removeGrade(index);
                })
            }
            .width('100%')
            .padding(10)
            .backgroundColor('#F8F9FA')
            .borderRadius(8)
          })
        }

        // 添加成绩
        Text('添加成绩')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .alignSelf(ItemAlign.Start)

        Column({ space: 15 }) {
          Row({ space: 10 }) {
            Text('课程：')
              .fontSize(14)

            TextInput({ placeholder: '课程名称', text: this.newSubject })
              .height(40)
              .layoutWeight(1)
              .onChange((value: string) => {
                this.newSubject = value;
              })
          }

          Row({ space: 10 }) {
            Text('分数：')
              .fontSize(14)

            TextInput({ placeholder: '0-100', text: this.newScore === 0 ? '' : this.newScore.toString() })
              .type(InputType.Number)
              .height(40)
              .layoutWeight(1)
              .onChange((value: string) => {
                const score = parseInt(value);
                this.newScore = isNaN(score) ? 0 : score;
              })
          }

          Button('添加')
            .backgroundColor(Color.Blue)
            .padding({
              left: 20,
              right: 20,
              top: 10,
              bottom: 10
            })
            .enabled(this.newSubject !== '' && this.newScore > 0 && this.newScore <= 100)
            .onClick(() => {
              this.addGrade();
            })
        }
        .width('100%')
        .padding(10)
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
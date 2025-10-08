/**
 * @file: StudentCard.ets
 * @author: Yeluzii
 * @date: 2025/09/30
 */

// 定义学生信息类型
export interface ListStudentInfo {
  id: string;
  name: string;
  major: string;
  grade: string;
  gpa: number;
}

// 子组件：学生信息卡片
@Component
export struct StudentCard {
  @Prop student: ListStudentInfo;
  @Prop isSelected: boolean;

  build() {
    Column({ space: 10 }) {
      Row() {
        Text(this.student.name)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.isSelected ? Color.White : '#333333')
          .flexGrow(1)

        Text(this.student.grade)
          .fontSize(12)
          .fontColor(this.isSelected ? Color.White : Color.Blue)
          .backgroundColor(this.isSelected ? 'rgba(255,255,255,0.3)' : '#E3F2FD')
          .padding({
            left: 8,
            right: 8,
            top: 4,
            bottom: 4
          })
          .borderRadius(10)
      }
      .width('100%')

      Text(`学号：${this.student.id}`)
        .fontSize(12)
        .fontColor(this.isSelected ? 'rgba(255,255,255,0.8)' : '#666666')

      Text(this.student.major)
        .fontSize(14)
        .fontColor(this.isSelected ? 'rgba(255,255,255,0.9)' : '#999999')

      Text(`GPA：${this.student.gpa.toFixed(2)}`)
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.isSelected ? Color.White : (this.student.gpa >= 3.5 ? Color.Green : Color.Orange))
    }
    .width('100%')
    .padding(15)
    .backgroundColor(this.isSelected ? '#1976D2' : Color.White)
    .borderRadius(12)
    .border({
      width: this.isSelected ? 2 : 1,
      color: this.isSelected ? '#1976D2' : '#E0E0E0'
    })
    .shadow({
      radius: this.isSelected ? 8 : 4,
      color: this.isSelected ? 'rgba(25,118,210,0.3)' : '#E0E0E0',
      offsetX: 0,
      offsetY: 2
    })
  }
}
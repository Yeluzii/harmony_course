interface PersonalInfo {
  name: string;
  studentId: string;
  email: string;
  phone: string;
}

interface Academic {
  major: string;
  grade: string;
  gpa: number;
  credits: number;
}

interface Preferences {
  theme: 'light' | 'dark';
  language: 'zh' | 'en';
  notifications: boolean;
}

interface StudentForm {
  personalInfo: PersonalInfo;
  academic: Academic;
  preferences: Preferences;
}

class CreditRequirements {
  private requirements: Map<string, number> = new Map([
    ['大一', 30],
    ['大二', 60],
    ['大三', 90],
    ['大四', 120]
  ]);

  get(grade: string): number {
    return this.requirements.get(grade) || 30;
  }
}

interface CreditStatus {
  percentage: number;
  status: string;
}

@Entry
@Component
struct FormValidationPage {
  @State title: string = ''

  aboutToAppear() {
    let params = this.getUIContext().getRouter().getParams() as Record<string, Object>
    if (params) {
      this.title = params['title'] as string
    }
  }

  @State formData: StudentForm = {
    personalInfo: {
      name: '',
      studentId: '',
      email: '',
      phone: ''
    },
    academic: {
      major: '计算机科学',
      grade: '大一',
      gpa: 3.0,
      credits: 0
    },
    preferences: {
      theme: 'light',
      language: 'zh',
      notifications: true
    }
  };
  @State errors: Map<string, string> = new Map();
  @State isSubmitting: boolean = false;
  private creditRequirements: CreditRequirements = new CreditRequirements();

  // 学分要求映射（联动逻辑）
  private getRequiredCredits(): number {
    return this.creditRequirements.get(this.formData.academic.grade);
  }

  // 实时验证函数
  private validateField(field: string, value: string | number): string {
    switch (field) {
      case 'name':
        if (typeof value === 'string') {
          if (!value.trim()) {
            return '姓名不能为空';
          }
          if (value.trim().length < 2) {
            return '姓名至少2个字符';
          }
          if (value.trim().length > 20) {
            return '姓名不能超过20个字符';
          }
        }
        break;
      case 'studentId':
        if (typeof value === 'string') {
          if (!value.trim()) {
            return '学号不能为空';
          }
          if (!/^\d{8}$/.test(value)) {
            return '学号必须为8位数字';
          }
        }
        break;
      case 'email':
        if (typeof value === 'string') {
          if (!value.trim()) {
            return '邮箱不能为空';
          }
          if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(value)) {
            return '邮箱格式不正确';
          }
        }
        break;
      case 'phone':
        if (typeof value === 'string') {
          if (!value.trim()) {
            return '手机号不能为空';
          }
          if (!/^1[3-9]\d{9}$/.test(value)) {
            return '手机号格式不正确';
          }
        }
        break;
      case 'gpa':
        if (typeof value === 'number') {
          if (value < 0 || value > 4.0) {
            return 'GPA必须在0-4.0之间';
          }
        }
        break;
      case 'credits':
        if (typeof value === 'number') {
          const required = this.getRequiredCredits();
          if (value < 0) {
            return '学分不能为负数';
          }
          if (value > required + 30) {
            return `学分不能超过${required + 30}`;
          }
        }
        break;
    }
    return '';
  }

  // 处理字段变化
  private handleFieldChange(field: string, value: string | number) {
    const error = this.validateField(field, value);
    if (error) {
      this.errors.set(field, error);
    } else {
      this.errors.delete(field);
    }
  }

  // 获取学分完成状态
  private getCreditStatus(): CreditStatus {
    const required = this.getRequiredCredits();
    const current = this.formData.academic.credits;
    const percentage = Math.min((current / required) * 100, 100);

    let status = '';
    if (percentage >= 100) {
      status = '已完成';
    } else if (percentage >= 80) {
      status = '接近完成';
    } else if (percentage >=
      50) {
      status = '进展良好';
    } else {
      status = '需要努力';
    }

    return { percentage, status } as CreditStatus;
  }

  build() {
    Navigation() {
      Scroll() {
        Column({ space: 16 }) {
          Text('学生信息管理表单')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)

          // 个人信息部分
          Column({ space: 12 }) {
            Text('个人信息')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .alignSelf(ItemAlign.Start)

            // 姓名输入
            Column({ space: 2 }) {
              TextInput({
                placeholder: '请输入姓名',
                text: this.formData.personalInfo.name
              })
                .width('100%')
                .height(36)
                .borderRadius(6)
                .backgroundColor('#F7F7F7')
                .borderWidth(this.errors.has('name') ? 1 : 0)
                .borderColor(Color.Red)
                .onChange((value: string) => {
                  this.formData.personalInfo.name = value;
                  this.handleFieldChange('name', value);
                })

              if (this.errors.has('name')) {
                Text(this.errors.get('name') || '')
                  .fontSize(11)
                  .fontColor(Color.Red)
                  .alignSelf(ItemAlign.Start)
                  .margin({ top: 2 })
              }
            }

            // 学号输入
            Column({ space: 2 }) {
              TextInput({
                placeholder: '请输入8位学号',
                text: this.formData.personalInfo.studentId
              })
                .width('100%')
                .height(36)
                .borderRadius(6)
                .backgroundColor('#F7F7F7')
                .type(InputType.Number)
                .maxLength(8)
                .borderWidth(this.errors.has('studentId') ? 1 : 0)
                .borderColor(Color.Red)
                .onChange((value: string) => {
                  this.formData.personalInfo.studentId = value;
                  this.handleFieldChange('studentId', value);
                })

              if (this.errors.has('studentId')) {
                Text(this.errors.get('studentId') || '')
                  .fontSize(11)
                  .fontColor(Color.Red)
                  .alignSelf(ItemAlign.Start)
                  .margin({ top: 2 })
              }
            }

            // 邮箱和手机号
            Row({ space: 8 }) {
              // 邮箱
              Column({ space: 2 }) {
                TextInput({
                  placeholder: '邮箱',
                  text: this.formData.personalInfo.email
                })
                  .width('100%')
                  .height(36)
                  .borderRadius(6)
                  .backgroundColor('#F7F7F7')
                  .type(InputType.Email)
                  .borderWidth(this.errors.has('email') ? 1 : 0)
                  .borderColor(Color.Red)
                  .onChange((value: string) => {
                    this.formData.personalInfo.email = value;
                    this.handleFieldChange('email', value);
                  })

                if (this.errors.has('email')) {
                  Text(this.errors.get('email') || '')
                    .fontSize(10)
                    .fontColor(Color.Red)
                    .margin({ top: 2 })
                }
              }
              .layoutWeight(1)

              // 手机号
              Column({ space: 2 }) {
                TextInput({
                  placeholder: '手机号',
                  text: this.formData.personalInfo.phone
                })
                  .width('100%')
                  .height(36)
                  .borderRadius(6)
                  .backgroundColor('#F7F7F7')
                  .type(InputType.PhoneNumber)
                  .maxLength(11)
                  .borderWidth(this.errors.has('phone') ? 1 : 0)
                  .borderColor(Color.Red)
                  .onChange((value: string) => {
                    this.formData.personalInfo.phone = value;
                    this.handleFieldChange('phone', value);
                  })

                if (this.errors.has('phone')) {
                  Text(this.errors.get('phone') || '')
                    .fontSize(10)
                    .fontColor(Color.Red)
                    .margin({ top: 2 })
                }
              }
              .layoutWeight(1)
            }
            .width('100%')
          }
          .width('100%')
          .padding(12)
          .backgroundColor('#F8F9FA')
          .borderRadius(8)

          // 学术信息部分
          Column({ space: 12 }) {
            Text('学术信息')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .alignSelf(ItemAlign.Start)

            // 专业选择
            Row({ space: 12 }) {
              Text('专业：')
                .fontSize(16)
                .width(60)

              Row({ space: 8 }) {
                Radio({ value: '计算机科学', group: 'major' })
                  .checked(this.formData.academic.major === '计算机科学')
                  .onChange((checked: boolean) => {
                    if (checked) {
                      this.formData.academic.major = '计算机科学';
                    }
                  })
                Text('计算机科学').fontSize(14)

                Radio({ value: '软件工程', group: 'major' })
                  .checked(this.formData.academic.major === '软件工程')
                  .onChange((checked: boolean) => {
                    if (checked) {
                      this.formData.academic.major = '软件工程';
                    }
                  })
                Text('软件工程').fontSize(14)
              }
            }
            .width('100%')
            .alignItems(VerticalAlign.Center)

            // 年级选择
            Row({ space: 12 }) {
              Text('年级：')
                .fontSize(16)
                .width(60)

              Row({ space: 8 }) {
                ForEach(['大一', '大二', '大三', '大四'], (grade: string) => {
                  Row({ space: 4 }) {
                    Radio({ value: grade, group: 'grade' })
                      .checked(this.formData.academic.grade === grade)
                      .onChange((checked: boolean) => {
                        if (checked) {
                          this.formData.academic.grade = grade;
                        }
                      })
                    Text(grade).fontSize(14)
                  }
                })
              }
            }
            .width('100%')
            .alignItems(VerticalAlign.Center)

            // GPA输入
            Column({ space: 8 }) {
              Row({ space: 12 }) {
                Text('GPA：')
                  .fontSize(16)
                  .width(60)

                Slider({
                  value: this.formData.academic.gpa,
                  min: 0,
                  max: 4.0,
                  step: 0.1
                })
                  .layoutWeight(1)
                  .trackColor('#E0E0E0')
                  .selectedColor(this.formData.academic.gpa >= 3.5 ? Color.Green :
                    this.formData.academic.gpa >= 2.5 ? Color.Orange : Color.Red)
                  .onChange((value: number) => {
                    this.formData.academic.gpa = value;
                    this.handleFieldChange('gpa', value);
                  })

                Text(this.formData.academic.gpa.toFixed(1))
                  .fontSize(16)
                  .fontWeight(FontWeight.Bold)
                  .width(40)
                  .textAlign(TextAlign.End)
              }
              .width('100%')
              .alignItems(VerticalAlign.Center)

              if (this.errors.has('gpa')) {
                Text(this.errors.get('gpa') || '')
                  .fontSize(12)
                  .fontColor(Color.Red)
                  .alignSelf(ItemAlign.Start)
              }
            }

            // 学分进度
            Column({ space: 8 }) {
              Row({ space: 12 }) {
                Text('已修学分：')
                  .fontSize(16)
                  .width(80)

                Slider({
                  value: this.formData.academic.credits,
                  min: 0,
                  max: this.getRequiredCredits() + 30,
                  step: 1
                })
                  .layoutWeight(1)
                  .trackColor('#E0E0E0')
                  .selectedColor(Color.Blue)
                  .onChange((value: number) => {
                    this.formData.academic.credits = value;
                    this.handleFieldChange('credits', value);
                  })

                Text(`${this.formData.academic.credits}`)
                  .fontSize(16)
                  .fontWeight(FontWeight.Bold)
                  .width(30)
                  .textAlign(TextAlign.End)
              }
              .width('100%')
              .alignItems(VerticalAlign.Center)

              // 学分完成状态
              Column({ space: 4 }) {
                Row({ space: 8 }) {
                  Text(`要求学分：${this.getRequiredCredits()}`)
                    .fontSize(12)
                    .fontColor('#666666')

                  Text(`完成度：${this.getCreditStatus().percentage.toFixed(1)}%`)
                    .fontSize(12)
                    .fontColor(Color.Blue)

                  Text(`状态：${this.getCreditStatus().status}`)
                    .fontSize(12)
                    .fontColor(this.getCreditStatus().percentage >= 80 ? Color.Green : Color.Orange)
                }
                .width('100%')
                .justifyContent(FlexAlign.SpaceBetween)

                Progress({
                  value: this.formData.academic.credits,
                  total: this.getRequiredCredits(),
                  type: ProgressType.Linear
                })
                  .width('100%')
                  .color(this.getCreditStatus().percentage >= 80 ? Color.Green : Color.Orange)
              }

              if (this.errors.has('credits')) {
                Text(this.errors.get('credits') || '')
                  .fontSize(12)
                  .fontColor(Color.Red)
                  .alignSelf(ItemAlign.Start)
              }
            }
          }
          .width('100%')
          .padding(12)
          .backgroundColor('#E8F5E8')
          .borderRadius(8)

          // 偏好设置部分
          Column({ space: 12 }) {
            Text('偏好设置')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .alignSelf(ItemAlign.Start)

            // 主题选择
            Row({ space: 12 }) {
              Text('主题：')
                .fontSize(16)
                .width(80)

              Row({ space: 12 }) {
                Radio({ value: 'light', group: 'theme' })
                  .checked(this.formData.preferences.theme === 'light')
                  .onChange((checked: boolean) => {
                    if (checked) {
                      this.formData.preferences.theme = 'light';
                    }
                  })
                Text('浅色').fontSize(14)

                Radio({ value: 'dark', group: 'theme' })
                  .checked(this.formData.preferences.theme === 'dark')
                  .onChange((checked: boolean) => {
                    if (checked) {
                      this.formData.preferences.theme = 'dark';
                    }
                  })
                Text('深色').fontSize(14)
              }
            }
            .width('100%')
            .alignItems(VerticalAlign.Center)

            // 语言选择
            Row({ space: 12 }) {
              Text('语言：')
                .fontSize(16)
                .width(80)

              Row({ space: 12 }) {
                Radio({ value: 'zh', group: 'language' })
                  .checked(this.formData.preferences.language === 'zh')
                  .onChange((checked: boolean) => {
                    if (checked) {
                      this.formData.preferences.language = 'zh';
                    }
                  })
                Text('中文').fontSize(14)

                Radio({ value: 'en', group: 'language' })
                  .checked(this.formData.preferences.language === 'en')
                  .onChange((checked: boolean) => {
                    if (checked) {
                      this.formData.preferences.language = 'en';
                    }
                  })
                Text('English').fontSize(14)
              }
            }
            .width('100%')
            .alignItems(VerticalAlign.Center)

            // 通知开关
            Row({ space: 12 }) {
              Text('推送通知：')
                .fontSize(16)
                .layoutWeight(1)

              Toggle({
                type: ToggleType.Switch,
                isOn: this.formData.preferences.notifications
              })
                .selectedColor(Color.Blue)
                .onChange((isOn: boolean) => {
                  this.formData.preferences.notifications = isOn;
                })
            }
            .width('100%')
            .alignItems(VerticalAlign.Center)
          }
          .width('100%')
          .padding(12)
          .backgroundColor('#FFF3E0')
          .borderRadius(8)

          // 表单操作按钮
          Row({ space: 12 }) {
            Button('重置表单')
              .layoutWeight(1)
              .backgroundColor(Color.Gray)
              .onClick(() => {
                this.formData = {
                  personalInfo: {
                    name: '',
                    studentId: '',
                    email: '',
                    phone: ''
                  } as PersonalInfo,
                  academic: {
                    major: '计算机科学',
                    grade: '大一',
                    gpa: 3.0,
                    credits: 0
                  } as Academic,
                  preferences: { theme: 'light', language: 'zh', notifications: true } as Preferences
                } as StudentForm;
                this.errors = new Map();
              })

            Button(this.isSubmitting ? '提交中...' : '提交表单')
              .layoutWeight(2)
              .backgroundColor(this.errors.size === 0 ? Color.Green : Color.Gray)
              .enabled(this.errors.size === 0 && !this.isSubmitting)
              .onClick(() => {
                this.isSubmitting = true;

                // 模拟提交过程
                setTimeout(() => {
                  this.isSubmitting = false;
                  AlertDialog.show({
                    message: `提交成功！\n姓名：${this.formData.personalInfo.name}\n专业：${this.formData.academic.major}\nGPA：${this.formData.academic.gpa.toFixed(1)}`,
                    primaryButton: {
                      value: '确定', action: () => {
                      }
                    }
                  });
                }, 2000);
              })
          }
          .width('100%')

          // 表单状态显示
          Column({ space: 8 }) {
            Text('表单状态')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .alignSelf(ItemAlign.Start)

            Text(`错误数量：${this.errors.size}`)
              .fontSize(14)
              .fontColor(this.errors.size === 0 ? Color.Green : Color.Red)

            if (this.errors.size > 0) {
              Text(`错误字段：${Array.from(this.errors.keys()).join(', ')}`)
                .fontSize(12)
                .fontColor(Color.Red)
            }
          }
          .width('100%')
          .padding(16)
          .backgroundColor('#F5F5F5')
          .borderRadius(8)
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
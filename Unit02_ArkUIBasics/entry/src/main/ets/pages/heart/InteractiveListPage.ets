interface TodoItem {
  id: string,
  text: string,
  completed: boolean,
  createTime: string
}

@Entry
@Component
struct InteractiveListPage {
  @State title: string = ''

  aboutToAppear() {
    let params = this.getUIContext().getRouter().getParams() as Record<string, Object>
    if (params) {
      this.title = params['title'] as string
    }
  }

  @State todoList: Array<TodoItem> = [
    {
      id: '1',
      text: '完成ArkUI组件学习',
      completed: false,
      createTime: '2025-09-05'
    },
    {
      id: '2',
      text: '提交课程作业',
      completed: true,
      createTime: '2025-09-06'
    },
    {
      id: '3',
      text: '准备参加招聘会',
      completed: false,
      createTime: '2025-09-07'
    },
    {
      id: '4',
      text: '参加技术分享会',
      completed: false,
      createTime: '2025-09-08'
    }
  ];

  // 切换完成状态
  private toggleComplete(id: string) {
    // 直接创建新数组，避免findIndex查找
    const newList: Array<TodoItem> = [];
    for (let i = 0; i < this.todoList.length; i++) {
      const item = this.todoList[i];
      if (item.id === id) {
        newList.push({
          id: item.id,
          text: item.text,
          completed: !item.completed,
          createTime: item.createTime
        });
      } else {
        newList.push({
          id: item.id,
          text: item.text,
          completed: item.completed,
          createTime: item.createTime
        });
      }
    }
    this.todoList = newList;
  }

  // 删除待办事项
  private deleteItem(id: string) {
    this.todoList = this.todoList.filter(item => item.id !== id);
  }

  @Builder
  buildTodoItem(item: TodoItem) {
    Row({ space: 12 }) {
      // 完成状态按钮
      Button(item.completed ? '√' : '×')
        .width(48)
        .height(48)
        .borderRadius(24)
        .backgroundColor(item.completed ? Color.Green : Color.Gray)
        .fontColor(Color.White)
        .fontSize(16)
        .onClick(() => {
          this.toggleComplete(item.id);
        })

      // 内容区域
      Column({ space: 4 }) {
        Text(item.text)
          .fontSize(16)
          .fontColor(item.completed ? Color.Gray : Color.Black)
          .decoration({
            type: item.completed ? TextDecorationType.LineThrough : TextDecorationType.None
          })
          .alignSelf(ItemAlign.Start)

        Text(item.createTime)
          .fontSize(12)
          .fontColor('#999999')
          .alignSelf(ItemAlign.Start)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      // 删除按钮
      Button('删除')
        .fontSize(12)
        .width(70)
        .height(28)
        .backgroundColor(Color.Red)
        .fontColor(Color.White)
        .onClick(() => {
          AlertDialog.show({
            title: '确认删除',
            message: '确定要删除这个待办事项吗？',
            primaryButton: {
              value: '删除',
              fontColor: Color.Red,
              action: () => {
                this.deleteItem(item.id);
              }
            },
            secondaryButton: {
              value: '取消',
              action: () => {
              }
            }
          });
        })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(8)
  }

  build() {
    Navigation() {
      Column({ space: 16 }) {
        Text('待办事项')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .padding(16)

        // 统计信息
        Row({ space: 20 }) {
          Text(`总计：${this.todoList.length}`)
            .fontSize(14)
          Text(`已完成：${this.todoList.filter(item => item.completed).length}`)
            .fontSize(14)
            .fontColor(Color.Green)
          Text(`未完成：${this.todoList.filter(item => !item.completed).length}`)
            .fontSize(14)
            .fontColor(Color.Orange)
        }
        .padding({ left: 16, right: 16, bottom: 8 })
        .alignSelf(ItemAlign.Start)

        List({ space: 8 }) {
          ForEach(this.todoList, (item: TodoItem, index: number) => {
            ListItem() {
              this.buildTodoItem(item)
            }
          }, (item: TodoItem, index: number) => `${item.id}-${item.completed}-${index}`)
        }
        .layoutWeight(1)
        .padding({ left: 16, right: 16 })
        .cachedCount(5)
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
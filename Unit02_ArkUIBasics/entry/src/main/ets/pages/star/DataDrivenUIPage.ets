interface Todo {
  id: number;
  title: string;
  completed: boolean;
  priority: 'low' | 'medium' | 'high';
}

interface TodoStats {
  total: number;
  completed: number;
  active: number;
}

@Entry
@Component
struct DataDrivenUIPage {
  @State title: string = ''

  aboutToAppear() {
    let params = this.getUIContext().getRouter().getParams() as Record<string, Object>
    if (params) {
      this.title = params['title'] as string
    }
  }

  @State todoList: Todo[] = [
    {
      id: 1,
      title: '完成HarmonyOS作业',
      completed: false,
      priority: 'high'
    },
    {
      id: 2,
      title: '准备期末考试',
      completed: false,
      priority: 'medium'
    },
    {
      id: 3,
      title: '参加社团活动',
      completed: true,
      priority: 'low'
    }
  ];
  @State newTodoTitle: string = '';
  @State filter: 'all' | 'active' | 'completed' = 'all';

  // 获取过滤后的待办事项
  getFilteredTodos(): Todo[] {
    switch (this.filter) {
      case 'active':
        return this.todoList.filter((todo: Todo) => !todo.completed);
      case 'completed':
        return this.todoList.filter((todo: Todo) => todo.completed);
      default:
        return this.todoList;
    }
  }

  // 获取统计信息
  getStats(): TodoStats {
    return {
      total: this.todoList.length,
      completed: this.todoList.filter((todo: Todo) => todo.completed).length,
      active: this.todoList.filter((todo: Todo) => !todo.completed).length
    } as TodoStats;
  }

  // 添加待办事项
  addTodo() {
    if (this.newTodoTitle.trim()) {
      const newId = Math.max(...this.todoList.map((todo: Todo) => todo.id), 0) + 1;
      this.todoList.push({
        id: newId,
        title: this.newTodoTitle.trim(),
        completed: false,
        priority: 'medium'
      });
      this.newTodoTitle = '';
    }
  }

  // 切换完成状态
  toggleTodo(id: number) {
    const index = this.todoList.findIndex(todo => todo.id === id);
    if (index !== -1) {
      this.todoList[index].completed = !this.todoList[index].completed;
    }
  }

  // 删除待办事项
  deleteTodo(id: number) {
    const index = this.todoList.findIndex(todo => todo.id === id);
    if (index !== -1) {
      this.todoList.splice(index, 1);
    }
  }

  build() {
    Navigation() {
      Column({ space: 20 }) {
        Text('智能待办清单')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)

        // 统计信息
        Row({ space: 20 }) {
          Text(`总计：${this.getStats().total}`)
            .fontSize(14)
            .fontColor('#666666')

          Text(`已完成：${this.getStats().completed}`)
            .fontSize(14)
            .fontColor(Color.Green)

          Text(`进行中：${this.getStats().active}`)
            .fontSize(14)
            .fontColor(Color.Orange)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceAround)
        .padding(15)
        .backgroundColor('#F8F9FA')
        .borderRadius(8)

        // 添加新待办
        Row({ space: 10 }) {
          TextInput({ placeholder: '添加新的待办事项...', text: this.newTodoTitle })
            .layoutWeight(3)
            .onChange((value: string) => {
              this.newTodoTitle = value;
            })
            .onSubmit(() => {
              this.addTodo();
            })

          Button('添加')
            .layoutWeight(1)
            .backgroundColor(Color.Blue)
            .enabled(this.newTodoTitle.trim() !== '')
            .onClick(() => {
              this.addTodo();
            })
        }
        .width('100%')

        // 过滤器
        Row({ space: 10 }) {
          Button('全部')
            .fontSize(12)
            .backgroundColor(this.filter === 'all' ? Color.Blue : Color.Gray)
            .onClick(() => {
              this.filter = 'all';
            })

          Button('进行中')
            .fontSize(12)
            .backgroundColor(this.filter === 'active' ? Color.Orange : Color.Gray)
            .onClick(() => {
              this.filter = 'active';
            })

          Button('已完成')
            .fontSize(12)
            .backgroundColor(this.filter === 'completed' ? Color.Green : Color.Gray)
            .onClick(() => {
              this.filter = 'completed';
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceAround)

        // 待办事项列表
        List({ space: 8 }) {
          ForEach(this.getFilteredTodos(), (todo: Todo) => {
            ListItem() {
              Row({ space: 15 }) {
                Button() {
                  Text(todo.completed ? '✓' : '')
                    .fontSize(12)
                    .fontColor(Color.White)
                }
                .width(30)
                .height(30)
                .backgroundColor(todo.completed ? Color.Green : Color.Gray)
                .borderRadius(15)
                .onClick(() => {
                  this.toggleTodo(todo.id);
                })

                Column({ space: 5 }) {
                  Text(todo.title)
                    .fontSize(16)
                    .fontColor(todo.completed ? '#999999' : '#333333')
                    .decoration({
                      type: todo.completed ? TextDecorationType.LineThrough : TextDecorationType.None
                    })

                  Text(`优先级：${todo.priority}`)
                    .fontSize(12)
                    .fontColor(
                      todo.priority === 'high' ? Color.Red :
                        todo.priority === 'medium' ? Color.Orange : Color.Green
                    )
                }
                .flexGrow(1)
                .alignItems(HorizontalAlign.Start)

                Button('删除')
                  .fontSize(12)
                  .backgroundColor(Color.Red)
                  .fontColor(Color.White)
                  .height(30)
                  .onClick(() => {
                    this.deleteTodo(todo.id);
                  })
              }
              .width('100%')
              .padding(15)
              .backgroundColor(Color.White)
              .borderRadius(8)
              .opacity(todo.completed ? 0.7 : 1.0)
            }
          })
        }
        .width('100%')
        .layoutWeight(1)

        // 空状态显示
        if (this.getFilteredTodos().length === 0) {
          Column({ space: 10 }) {
            Text('📝')
              .fontSize(48)
              .opacity(0.5)

            Text(
              this.filter === 'all' ? '暂无待办事项' :
                this.filter === 'active' ? '暂无进行中的事项' :
                  '暂无已完成的事项'
            )
              .fontSize(16)
              .fontColor('#999999')
          }
          .width('100%')
          .height(200)
          .justifyContent(FlexAlign.Center)
        }
      }
      .width('100%')
      .height('100%')
      .padding(20)
      .backgroundColor('#F5F5F5')
    }
    .title(this.title)
    .titleMode(NavigationTitleMode.Mini)
    .hideBackButton(false)
    .navBarWidth('100%')
    .navBarPosition(NavBarPosition.Start)
  }
}
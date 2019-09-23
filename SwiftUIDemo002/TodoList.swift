//
//  TodoList.swift
//  SwiftUIDemo002
//
//  Created by Wei on 2019/9/23.
//  Copyright © 2019 Wei. All rights reserved.
//

import SwiftUI

var exampleTodos: [Todo] = [
    Todo(title: "擦地", dueDate: Date()),
    Todo(title: "洗锅", dueDate: Date()),
    Todo(title: "看中国", dueDate: Date()),
    Todo(title: "做APP", dueDate: Date()),
    Todo(title: "作业", dueDate: Date()),
]


struct TodoList: View {
    
    @ObservedObject var main:Main
    
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(main.todos){ todo in
                    VStack(alignment: .leading) {
                        if todo.i == 0 || formatter.string(from: todo.dueDate) != formatter.string(from: self.main.todos[todo.i - 1].dueDate) {
                            HStack {
                                Spacer().frame(width: 30)
                                Text(formatter.string(from: todo.dueDate))
                                Spacer().frame(width: 30)
                            }
                        }
                        HStack {
                            Spacer().frame(width: 20)
                            TodoItem(main: self.main, todoIndex: .constant(todo.i))
                            .cornerRadius(10)
                            .clipped()
                                .shadow(color: Color("todoItemShadow"),radius: 5)
                            Spacer()
                        }
                        Spacer().frame(height: 20)
                    }
                }
            }
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarTitle(Text("待办事项"))
                .onAppear{
                    if let data = UserDefaults.standard.object(forKey: "todos") as? Data {
                        let todoList = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [Todo] ?? []
                        for todo in todoList {
                            if !todo.checked {
                                self.main.todos.append(todo)
                            }
                        }
                    } else {
                        self.main.todos = exampleTodos
                        self.main.sort()
                    }
            }
        }
    }
}

struct TodoList_Previews: PreviewProvider {
    static var previews: some View {
        TodoList(main: Main())
    }
}

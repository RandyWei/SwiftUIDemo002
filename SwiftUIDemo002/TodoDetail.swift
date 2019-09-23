//
//  TodoDetail.swift
//  SwiftUIDemo002
//
//  Created by Wei on 2019/9/23.
//  Copyright © 2019 Wei. All rights reserved.
//

import SwiftUI

struct TodoDetail: View {
    
    @ObservedObject var main: Main
    
    var body: some View {
        VStack {
            HStack {
                Button(action:{
                    //UIApplication.shared.keyWindow?.endEditing(true)
                }) {
                    Text("取消").padding()
                }
                Spacer()
                Button(action:{
                    //UIApplication.shared.keyWindow?.endEditing(true)
                    if editingMode {
                        self.main.todos[editingIndex].title = self.main.detailsTitle
                        self.main.todos[editingIndex].dueDate = self.main.detailDueDate
                    }else {
                        let newTodo = Todo(title: self.main.detailsTitle, dueDate: self.main.detailDueDate)
                        self.main.todos.append(newTodo)
                    }
                    self.main.sort()
                    do {
                        let archivedData = try NSKeyedArchiver.archivedData(withRootObject: self.main.todos, requiringSecureCoding: false)
                        UserDefaults.standard.set(archivedData, forKey: "todos")
                    } catch {
                        print("error")
                    }
                    self.main.detailsShowing = false
                }){
                    Text(editingMode ? "完成" : "添加").padding()
                }.disabled(main.detailsTitle == "")
            }
        }
    }
}

struct TodoDetail_Previews: PreviewProvider {
    static var previews: some View {
        TodoDetail(main: Main())
    }
}

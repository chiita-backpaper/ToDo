//
//  File.swift
//  ToDo
//
//  Created by Taichi Uragami on R 3/04/03.
//

import Foundation
import SwiftUI

/// タスク追加View
struct AddTaskView: View {
    @Environment(\.managedObjectContext) private var context
    @Environment(\.presentationMode) var presentationMode
    @State private var title = ""
    @State private var detail = ""
    
    var body: some View {
        VStack{
            Form {
                Section() {
                    TextField("タスクを入力", text: $title)
                }
            }
            TextEditor(text: $detail)
                       .padding()
                       .font(.subheadline)
            
        }
        .navigationTitle("タスク追加")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("保存") {
                    /// タスク新規登録処理
                    let newTask = Task(context: context)
                    newTask.timestamp = Date()
                    newTask.checked = false
                    newTask.title = title
                    newTask.detail = detail
                    
                    try? context.save()
 
                    /// 現在のViewを閉じる
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
}

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
    @State private var title: String = ""
    @State private var detail: String = ""
    
    
    var body: some View {
        VStack{
            Form {
                Section(header: Text("タスク")) {
                    ZStack(alignment: .topLeading) {
                        if (title == "") {
                            Text("タスクを入力").foregroundColor(Color.gray)
                        }
                        TextField("", text: $title)
                        }
                }
                Section(header: Text("詳細")){
                ZStack(alignment: .topLeading) {
                        if (detail == "") {
                            Text("詳細を入力").foregroundColor(Color.gray)
                        }
                        TextEditor(text: $detail)
        //                    .foregroundColor(Color.gray)
        //                    .font(.custom("HelveticaNeue", size: 13))
        //                    .lineSpacing(
        //
        //                    .padding()
        //                    .foregroundColor(Color.gray)
        //                    .font(.subheadline)
                    }
                }
            }
            
//            Spacer()
            
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

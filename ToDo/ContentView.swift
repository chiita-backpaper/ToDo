//
//  ContentView.swift
//  ToDo
//
//  Created by Taichi Uragami on R 3/04/01.
//

import SwiftUI
import CoreData


struct ContentView: View {
    /// 被管理オブジェクトコンテキスト（ManagedObjectContext）の取得
    @Environment(\.managedObjectContext) private var context
    @FetchRequest(
        entity: Task.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Task.timestamp, ascending: true)],
        predicate: nil
    ) private var tasks: FetchedResults<Task>
    
//    @State var castedTask: FetchedResults<Task>.Element
    
//  知識不足で余計なことをしているかも
//    @State var title: String = ""
//    @State var detail: String = ""
//    @State var task?: FetchedResults<Task>.Element = nil
   
    var body: some View {
        NavigationView {
            /// 取得したデータをリスト表示
            List {
                ForEach(tasks) { task in
                    
//                    title = task.title!
//                    detail = task.detail!
                    
                    /// タスクの表示
                        HStack {
                        Image(systemName: task.checked ? "checkmark.circle.fill" : "circle")
                            .onTapGesture {
                                task.checked.toggle()
                                try? context.save()
                            }
                        
                        NavigationLink(destination: DetailView(
//                            title: title, detail: detail
                                        task: task
                        )){
                            Text("\(task.title!)")
                            
                        }
//                            Spacer()
                    }
                    
                    /// タスクをタップでcheckedフラグを変更する
                    .contentShape(Rectangle())
                }
                .onDelete(perform: deleteTasks)
            }
            .navigationTitle("Todoリスト")
            
            /// ツールバーの設定
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: AddTaskView()) {
                        Image(systemName: "plus")
                    }
                }
            }
            
        }
    }
    
    /// タスクの削除
    /// - Parameter offsets: 要素番号のコレクション
    func deleteTasks(offsets: IndexSet) {
        for index in offsets {
            context.delete(tasks[index])
        }
        try? context.save()
    }
}
 
 
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().preferredColorScheme(.dark).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

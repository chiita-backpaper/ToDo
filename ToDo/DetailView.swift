//
//  DetailView.swift
//  ToDo
//
//  Created by Taichi Uragami on R 3/04/03.
//

import Foundation
import SwiftUI

struct DetailView: View {
    @Environment(\.managedObjectContext) private var context
    @ObservedObject var task: Task
    
    var body: some View {
        Text("\(task.title ?? "")")
        Text("\(task.detail ?? "")")
                
        .navigationBarTitle("詳細")
    }
}

//
//  ListView.swift
//  TodoList
//
//  Created by Shahma on 14/10/25.
//

import SwiftUI

struct ListView: View {
    
    @EnvironmentObject var listViewModel: ListViewModel
    
    var body: some View {
        List {
            ForEach(listViewModel.items) { item in
                ListRowView(item: item)
                    .onTapGesture {
                        listViewModel.updateItem(item: item)
                    }
            }
            .onDelete(perform: listViewModel.removeItem)
            .onMove(perform: listViewModel.moveItem)

        }
        .navigationTitle("Todo List 📝")
        .navigationBarItems(
            leading: EditButton()
            ,trailing: NavigationLink("Add", destination: AddView())
        )
    }
    
}

#Preview {
    NavigationView {
        ListView()
    }
    .environmentObject(ListViewModel())
}

//
//  ListRowView.swift
//  TodoList
//
//  Created by Shahma on 14/10/25.
//

import SwiftUI

struct ListRowView: View {
    
    var item: ItemModel
    
    var body: some View {
        HStack {
            Image(systemName: item.isCompleted ? "checkmark.circle" : "circle")
                .foregroundColor(item.isCompleted ? .green : .red)
            Text(item.title)
            Spacer()
        }
        .font(.title2)
        .padding(.vertical, 8)
    }
}


struct ListRowView_Previews: PreviewProvider {
    static var previews: some View {
        let item1 = ItemModel(title: "First", isCompleted: false)
        let item2 = ItemModel(title: "Second", isCompleted: true)
        Group {
            ListRowView(item: item1)
            ListRowView(item: item2)
        }
        .previewLayout(.sizeThatFits)
    }
}



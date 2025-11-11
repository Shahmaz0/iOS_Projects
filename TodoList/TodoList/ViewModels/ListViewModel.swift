//
//  ListViewModel.swift
//  TodoList
//
//  Created by Shahma on 14/10/25.
//

import Foundation

class ListViewModel: ObservableObject {
    
    @Published var items: [ItemModel] = [] {
        didSet {
            saveItems()
        }
    }
    let itemsKey: String = "items_list"
    
    init() {
        addItem()
    }
    
    func addItem() {
//        let newItems = [
//            ItemModel(title: "This is the first item!", isCompleted: true),
//            ItemModel(title: "This is the Second item!", isCompleted: false),
//            ItemModel(title: "Third", isCompleted: false)]
//        
//        items.append(contentsOf: newItems)
        
        guard
            let data = UserDefaults.standard.data(forKey: itemsKey),
            let savedItems = try? JSONDecoder().decode([ItemModel].self, from: data)
        else { return }
        
        self.items = savedItems
    }
    
    
    func removeItem(indexSet: IndexSet) {
        items.remove(atOffsets: indexSet)
    }
    
    func moveItem(indexSet: IndexSet, to: Int) {
        items.move(fromOffsets: indexSet, toOffset: to)
        saveItems()
    }
    
    func addItem(title: String) {
        let newItem = ItemModel(title: title, isCompleted: false)
        items.append(newItem)
    }
    
    func updateItem(item: ItemModel) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index] = item.updateCompletion()
        }
    }
    
    func saveItems() {
        if let encodedData = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
        }
    }
}

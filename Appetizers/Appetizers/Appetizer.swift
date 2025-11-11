//
//  Appetizer.swift
//  Appetizers
//
//  Created by Shahma on 27/10/25.
//

import Foundation


struct Appetizer: Decodable, Identifiable {
    let id: Int
    let name: String
    let description: String
    let price: Double
    let imageUrl: String
    let calories: Int
    let protein: Int
    let carbs: Int
}

struct AppetizerResponse {
    let request: [Appetizer]
}

struct MockData {
    static let sampleAppetizers = Appetizer(id: 0001,
                                    name: "Test Appetizer",
                                    description: "This is the description for my appetizer, It's yummy ",
                                    price: 9.99,
                                    imageUrl: "",
                                    calories: 99,
                                    protein: 99,
                                    carbs: 99)
    
    static let appetizers = [sampleAppetizers, sampleAppetizers, sampleAppetizers, sampleAppetizers]
}

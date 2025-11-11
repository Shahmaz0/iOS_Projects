//
//  Film.swift
//  GhibliSwiftUIApp
//
//  Created by Shahma on 23/10/25.
//


import Foundation
import SwiftUI
import Playgrounds


struct Film: Codable, Identifiable, Equatable {
    let id: String
    let title: String
    let description: String
    let director: String
    let producer: String
    let releaseYear: String
    let score: String
    let duration: String
    let image: String
    let bannerImage: String
    let people: [String]

    enum CodingKeys: String, CodingKey {
        case id, title, image, description, director, producer
        case bannerImage = "movie_banner"
        case releaseYear = "release_date"
        case score = "rt_score"
        case duration = "running_time"
        case people
    }
}


#Playground {
    
    let url = URL(string: "https://ghibliapi.vercel.app/films")!
    
    do {
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        try JSONDecoder().decode([Film].self, from: data)
    }catch{
        print(error)
    }
}

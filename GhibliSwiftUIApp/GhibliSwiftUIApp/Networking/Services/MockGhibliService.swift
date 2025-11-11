//
//  MockGhibliService.swift
//  GhibliSwiftUIApp
//
//  Created by Shahma on 23/10/25.
//

import Foundation

struct MockGhibliService: GhibliService {
    
    func fetchFilms() async throws -> [Film] {
        guard let url = Bundle.main.url(forResource: "SampleData", withExtension: "json") else {
            throw ApiError.invalidURL
        }
        
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode([Film].self, from: data)
        } catch let error as DecodingError {
            throw ApiError.decoding(error)
        } catch {
            throw ApiError.networkError(error)
        }
    }
}

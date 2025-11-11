//
//  DefaultGhibliService.swift
//  GhibliSwiftUIApp
//
//  Created by Shahma on 23/10/25.
//

import Foundation

struct DefaultGhibliService: GhibliService {
    func fetchFilms() async throws -> [Film] {
        
        guard let url = URL(string: "https://ghibliapi.vercel.app/films") else {
            throw ApiError.invalidURL
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                throw ApiError.invalidResponse
            }
            
            return try JSONDecoder().decode([Film].self, from: data)
            
        }catch let error as DecodingError {
            throw ApiError.decoding(error)
        } catch let error as URLError {
            throw ApiError.networkError(error)
        }
        
    }
}

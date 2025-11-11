//
//  FilmsViewModel.swift
//  GhibliSwiftUIApp
//
//  Created by Shahma on 23/10/25.
//

import Foundation
import Observation


enum ApiError: Error {
    case invalidURL
    case invalidResponse
    case networkError(Error)
    case decoding(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The url is invalid!"
        case .invalidResponse:
            return "Invalid response from the server!"
        case .networkError(let error):
            return "Network Error \(error.localizedDescription)"
        case .decoding(let error):
            return "Failed to decode the error \(error.localizedDescription)"
        }
    }
}

@Observable
class FilmsViewModel {
    
    enum State: Equatable {
        case idle
        case loading
        case loaded([Film])
        case error(String)
    }
    
    var state: State = .idle
    var films: [Film] = []
    
    private let service: GhibliService
    init(service: GhibliService = DefaultGhibliService()) {
        self.service = service
    }
    
    func fetch() async {
        
        guard state == .idle else { return }
        
        state = .loading
        
        do {
            let films = try await service.fetchFilms()
            self.state = .loaded(films)
        }catch let error as ApiError{
            self.state = .error(error.errorDescription ?? "Unknown Error")
        }catch {
            self.state = .error("Unknown Error")
        }
    }
}

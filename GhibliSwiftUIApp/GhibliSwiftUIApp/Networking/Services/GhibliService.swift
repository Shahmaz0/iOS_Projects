//
//  GhibliService.swift
//  GhibliSwiftUIApp
//
//  Created by Shahma on 23/10/25.
//

import Foundation

protocol GhibliService {
    func fetchFilms() async throws -> [Film]
}

//
//  FilmListView.swift
//  GhibliSwiftUIApp
//
//  Created by Shahma on 23/10/25.
//

import SwiftUI

struct FilmListView: View {
    
    var filmsViewModel: FilmsViewModel
    
    var body: some View {
        NavigationStack {
            
            switch filmsViewModel.state {
            case .idle:
                Text("No films yet!")
            case .loading:
                ProgressView {
                    Text("Loading ...")
                }
            case .loaded(let films):
                List(films) {
                    Text($0.title)
                }
                .navigationTitle("Ghibli Films")
            case .error(let error):
                Text(error)
                    .foregroundStyle(.pink)
            }
        }
        .task {
            await filmsViewModel.fetch()
        }
    }
}

#Preview {
    
    @State @Previewable var vm = FilmsViewModel(service: MockGhibliService())
    FilmListView(filmsViewModel: vm)
}

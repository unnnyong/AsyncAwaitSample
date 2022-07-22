//
//  StarwarsPeopleListViewModel.swift
//  AsyncAwaitSample
//
//  Created by Eunyeong Kim on 2022/07/21.
//

import Combine

final class StarwarsPeopleListViewModel: ObservableObject {
    @Published var people: [Person] = []

    init() {
        fetchStarwarsPeople()
    }

    func viewDidLoad() {
        fetchStarwarsPeople()
    }
}

private extension StarwarsPeopleListViewModel {
    func fetchStarwarsPeople() {
        Task {
            do {
                people = try await APIClient().getPeople()
            } catch NetworkError.invalidURL {
                print("Invalid URL ERROR!")
            }
        }
    }
}

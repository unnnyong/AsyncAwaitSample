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

    func fetchStarwarsPeople() {
        // TODO: request get method
        people = [
            Person(name: "Anna"),
            Person(name: "Banana")
        ]
    }
}

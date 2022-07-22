//
//  APIClient.swift
//  AsyncAwaitSample
//
//  Created by Eunyeong Kim on 2022/07/21.
//

import Combine
import Foundation

enum NetworkError: Error {
    case invalidURL
}

struct APIClient {
    private let baseURL = "https://swapi.dev/api/"

    func getPeople() async throws -> [Person] {
        let path = "people"

        guard let url = URL(string: "\(baseURL)\(path)") else { throw NetworkError.invalidURL }

        let request = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: request)

        return try JSONDecoder().decode(People.self, from: data).results
    }
}

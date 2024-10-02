//
//  NetworkingService.swift
//  SimpleCoreData
//
//  Created by Kasper Spychala on 02/10/2024.
//

import Foundation

protocol NetworkingServiceProtocol {
    func fetchCheckInDateTime() async throws -> Date?
}

class NetworkingService: NetworkingServiceProtocol {
    private let session: URLSession

    init() {
        let config = URLSessionConfiguration.default
        config.protocolClasses = [MockURLProtocol.self]
        session = URLSession(configuration: config)
    }

    func fetchCheckInDateTime() async throws -> Date? {
        guard let url = URL(string: "https://example.com/mock/api/check_in_date_time") else {
            throw URLError(.badURL)
        }

        let (data, _) = try await session.data(from: url)

        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: String]
        if let dateString = json?["dateTime"] {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
            return dateFormatter.date(from: dateString)
        }
        return nil
    }
}

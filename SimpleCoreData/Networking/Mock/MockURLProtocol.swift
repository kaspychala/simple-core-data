//
//  MockURLProtocol.swift
//  SimpleCoreData
//
//  Created by Kasper Spychala on 02/10/2024.
//

import Foundation

class MockURLProtocol: URLProtocol {
    override class func canInit(with request: URLRequest) -> Bool {
        return request.url?.path == "/mock/api/check_in_date_time"
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        Task {
            try? await Task.sleep(nanoseconds: 3_000_000_000)
            if let url = request.url, url.path == "/mock/api/check_in_date_time" {
                let mockJSON = """
                {
                    "dateTime": "\(mockedDateString())"
                }
                """
                guard let data = mockJSON.data(using: .utf8) else {
                    LoggingManager.shared.error("Failed to create mock data")
                    return
                }

                let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
                client?.urlProtocol(self, didReceive: response!, cacheStoragePolicy: .notAllowed)
                client?.urlProtocol(self, didLoad: data)
                client?.urlProtocolDidFinishLoading(self)
            }
        }
    }

    override func stopLoading() {}

    private func mockedDateString() -> String {
        let calendar = Calendar.current
        let now = Date()

        // Set time to 06:30 of the current day
        var components = calendar.dateComponents([.year, .month, .day], from: now)
        components.hour = 6
        components.minute = 30

        let mockDate = calendar.date(from: components) ?? now
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        return dateFormatter.string(from: mockDate)
    }
}


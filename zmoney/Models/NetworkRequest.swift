//
//  NetworkRequest.swift
//  zmoney
//
//  Created by Pavel Romanishkin on 12.04.21.
//

import Foundation
// swiftlint:disable line_length
protocol NetworkRequestType {
    func sendRequest(to urlString: String, withData data: Data?, withHeaders headers: [String: String]?, using method: String, withCompletion completion: @escaping (Result<Data, Error>) -> Void)
}

struct NetworkRequest: NetworkRequestType {
    func sendRequest(to urlString: String, withData data: Data?, withHeaders headers: [String: String]?, using method: String, withCompletion completion: @escaping (Result<Data, Error>) -> Void) {
        let urlStringEncoded = urlString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!
        guard let url = URL(string: urlStringEncoded) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = method
        if let headers = headers, !headers.isEmpty {
            for header in headers {
                request.setValue(header.value, forHTTPHeaderField: header.key)
            }
        }
        request.httpBody = data

        let session = URLSession.shared
        session.dataTask(with: request) { (data, _, error) in
            if let data = data {
                completion(.success(data))

            } else {
                completion(.failure(error!))
            }
        }.resume()
    }
}

//
//  ZService.swift
//  zmoney
//
//  Created by Pavel Romanishkin on 12.04.21.
//

import Foundation
import UIKit

struct Zservice {
    let apiUrl = "https://api.zenmoney.ru/"
    let clientId = "gcd083e97524bce251e4d6d5e9cd71"
    let clienSecret = "955b0c91d2"
    let redirectUri = "zmoney://oauthcallback"
    let authUrl = "https://api.zenmoney.ru/oauth2/authorize/"
    let requestTokenUrl = "https://api.zenmoney.ru/oauth2/token/"
    let networkService = NetworkRequest()

    func auth() {
        guard let url = URL(
                string: authUrl + "?response_type=code&client_id=\(clientId)&redirect_uri=\(redirectUri)"
        ) else { return }
        UIApplication.shared.open(url)
    }

    func getDiff(withCompletion completion: @escaping (Result<DiffResponseModel, Error>) -> Void) {
        let urlString = apiUrl + "v8/diff/"

        let defaults = UserDefaults.standard
        let lastSyncTimeStamp = defaults.integer(forKey: "lastSyncTimeStamp")

        let currentTimestamp = Int(Date().timeIntervalSince1970)
        let diff = DiffRequestModel(currentClientTimestamp: currentTimestamp, serverTimestamp: lastSyncTimeStamp)
        do {
            let encoder = JSONEncoder()
            let diffData = try encoder.encode(diff)
            networkService.sendRequest(
                to: urlString,
                withData: diffData,
                withHeaders: ["Content-Type": "application/json"],
                using: "GET") { (result) in
                switch result {
                case .failure(let error):
                    completion(.failure(error))
                case .success(let data):
                    let decoder = JSONDecoder()
                    do {
                        let decodedData = try decoder.decode(DiffResponseModel.self, from: data)
                        completion(.success(decodedData))
                    } catch let error {
                        completion(.failure(error))
                    }
                }
            }
        } catch {
            return
        }

    }

    func handleOauthRedirect(url: URL, withCompletion completion: @escaping (Result<AuthResponse, Error>) -> Void) {
        let urlString = "\(url)"
        if let regex = try? NSRegularExpression(pattern: "[a-zA-Z0-9]{30}") {
            let results = regex.matches(in: urlString, range: NSRange(urlString.startIndex..., in: urlString))
            let token = results.map { String(urlString[Range($0.range, in: urlString)!]) }.first!
            let dataString = """
            grant_type=authorization_code&\
            client_id=\(clientId)&\
            client_secret=\(clienSecret)&\
            code=\(token)&\
            redirect_uri=\(redirectUri)
            """
            let dataStringEncoded = dataString.data(using: .utf8)

            networkService.sendRequest(
                to: requestTokenUrl,
                withData: dataStringEncoded,
                withHeaders: ["Content-Type": "application/x-www-form-urlencoded"],
                using: "POST"
            ) { (result) in
                switch result {
                case .failure(let error):
                    completion(.failure(error))
                case .success(let data):
                    let decoder = JSONDecoder()
                    do {
                        let decodedData = try decoder.decode(AuthResponse.self, from: data)
                        completion(.success(decodedData))
                    } catch {
                        completion(.failure(error))
                    }
                }
            }
        }
    }
}

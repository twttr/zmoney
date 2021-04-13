//
//  ZService.swift
//  zmoney
//
//  Created by Pavel Romanishkin on 12.04.21.
//

import Foundation
import UIKit

struct Zservice {
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

    func handleOauthRedirect(url: URL) {
        let urlString = "\(url)"
        if let regex = try? NSRegularExpression(pattern: "[a-zA-Z0-9]{30}") {
            let results = regex.matches(in: urlString, range: NSRange(urlString.startIndex..., in: urlString))
            let token = results.map { String(urlString[Range($0.range, in: urlString)!]) }.first!
            let dataString = """
                grant_type=authorization_code&
                client_id=\(clientId)&
                client_secret=\(clienSecret)&
                code=\(token)&
                redirect_uri=\(redirectUri)
            """.data(using: .utf8)

            networkService.sendRequest(
                to: requestTokenUrl,
                withData: dataString,
                withHeaders: ["Content-Type": "application/x-www-form-urlencoded"],
                using: "POST"
            ) { (result) in
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let data):
                    let decoder = JSONDecoder()
                    do {
                        let decodedData = try decoder.decode(AuthResponse.self, from: data)
                        print(decodedData.accessToken)
                    } catch {
                        print(error)
                    }
                }
            }
        }
    }
}

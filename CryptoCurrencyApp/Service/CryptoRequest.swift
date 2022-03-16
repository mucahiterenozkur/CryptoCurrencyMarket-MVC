//
//  CryptoRequest.swift
//  CryptoCurrencyApp
//
//  Created by Mücahit Eren Özkur on 15.03.2022.
//

import Foundation

class CryptoRequest {
    
    static let shared = CryptoRequest()
    
    struct Constants {
        static let topHeadLinesURL = URL(string: "https://psp-merchantpanel-service-sandbox.ozanodeme.com.tr/api/v1/dummy/coins")
    }
    
    //private init() {}
    
    public func getAllData(completion: @escaping (Result<[Coin], Error>) -> Void) {
        guard let url = Constants.topHeadLinesURL else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            else if let data = data {
                do {
                    let result = try JSONDecoder().decode(Crypto.self, from: data)
                    //print(result.coins.count)
                    //print(result)
                    completion(.success(result.data.coins))
                } catch  {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
    
}

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)



// MARK: - Welcome
struct Crypto: Codable {
    let status: String
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let stats: Stats
    let coins: [Coin]

}

// MARK: - Coin
struct Coin: Codable {
    let uuid, symbol, name: String
    let color: String?
    let iconURL: String
    let marketCap, price: String
    let listedAt, tier: Int
    let change: String
    let rank: Int
    let sparkline: [String]
    let lowVolume: Bool
    let coinrankingURL: String
    let the24HVolume, btcPrice: String

    enum CodingKeys: String, CodingKey {
        case uuid, symbol, name, color
        case iconURL = "iconUrl"
        case marketCap, price, listedAt, tier, change, rank, sparkline, lowVolume
        case coinrankingURL = "coinrankingUrl"
        case the24HVolume = "24hVolume"
        case btcPrice
    }
}

// MARK: - Stats
struct Stats: Codable {
    let total, totalCoins, totalMarkets, totalExchanges: Int
    let totalMarketCap, total24HVolume: String

    enum CodingKeys: String, CodingKey {
        case total, totalCoins, totalMarkets, totalExchanges, totalMarketCap
        case total24HVolume = "total24hVolume"
    }
}




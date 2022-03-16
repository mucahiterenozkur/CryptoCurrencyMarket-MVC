//
//  CryptoModel.swift
//  CryptoCurrencyApp
//
//  Created by Mücahit Eren Özkur on 16.03.2022.
//

import Foundation

struct CryptoModel {
    let symbol: String
    let name: String
    var iconURL: URL?
    var imageData: Data?
    let price: String
    let change: String
    var sparkLines: [String]?
}

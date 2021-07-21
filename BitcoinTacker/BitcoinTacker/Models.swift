//
//  Models.swift
//  BitcoinTacker
//
//  Created by VITALIY SVIRIDOV on 21.07.2021.
//

import Foundation

struct Crypto: Codable {
    let asset_id: String
    let name: String?
    let price_usd: Float?
    let id_icon: String?
}

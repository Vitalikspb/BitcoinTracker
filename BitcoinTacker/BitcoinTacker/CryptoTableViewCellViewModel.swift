//
//  CryptoTableViewCellViewModel.swift
//  BitcoinTacker
//
//  Created by VITALIY SVIRIDOV on 22.07.2021.
//

import Foundation

class CryptoTableViewCellViewModel {
    
    // MARK: - Properties
    
    let name: String
    let symbol: String
    let price: String
    let iconUrl: URL?
    var iconData: Data?
    
    // MARK: - Init
    
    init(name: String, symbol: String, price: String, iconUrl: URL?) {
        self.name = name
        self.symbol = symbol
        self.price = price
        self.iconUrl = iconUrl
    }
}

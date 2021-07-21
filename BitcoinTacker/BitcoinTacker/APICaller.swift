//
//  APICaller.swift
//  BitcoinTacker
//
//  Created by VITALIY SVIRIDOV on 21.07.2021.
//

import Foundation

final class APICaller {
    static let shared = APICaller()
    
    private struct Constant {
        static let apiKey = "4C74AA8B-6370-4A53-9AB7-884766D4E1CE"
        static let assentsEndPoint = "http://rest-sandbox.coinapi.io/v1/assets/"
    }
    
    private init() { }
    
    // MARK: - public
    
    public func getAllCryptoData( complection: @escaping (Result<[Crypto], Error>) -> Void) {
        guard let url = URL(string: Constant.assentsEndPoint + "?apikey=" + Constant.apiKey) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let cryptos = try JSONDecoder().decode([Crypto].self, from: data)
                complection(.success(cryptos))
            }
            catch {
                print("\(error.localizedDescription)")
                complection(.failure(error))
            }
        }
        task.resume()
    }
}

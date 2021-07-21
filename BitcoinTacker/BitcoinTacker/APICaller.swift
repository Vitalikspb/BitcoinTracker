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
        static let assentsIcons = "http://rest-sandbox.coinapi.io/v1/assets/icons/55/"
        static let questionApiKey = "?apikey="
    }
    public var icons: [Icon] = []
    private var whenReadyBLock: ((Result<[Crypto], Error>) -> Void)?
    
    private init() { }
    
    // MARK: - public
    
    public func getAllCryptoData( complection: @escaping (Result<[Crypto], Error>) -> Void) {
        guard let url = URL(string: Constant.assentsEndPoint + Constant.questionApiKey + Constant.apiKey) else { return }
        guard !icons.isEmpty else {
            whenReadyBLock = complection
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let cryptos = try JSONDecoder().decode([Crypto].self, from: data)
                complection(.success(cryptos.sorted { first, second -> Bool in
                    return first.price_usd ?? 0 > second.price_usd ?? 0
                }))
            }
            catch {
                print("\(error.localizedDescription)")
                complection(.failure(error))
            }
        }
        task.resume()
    }
    
    public func getAllIcons() {
        guard let url = URL(string: Constant.assentsIcons + Constant.questionApiKey + Constant.apiKey) else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else { return }
            do {
                self?.icons = try JSONDecoder().decode([Icon].self, from: data)
                if let completion = self?.whenReadyBLock {
                    self?.getAllCryptoData(complection: completion)
                }
            }
            catch {
             print(error)
            }
        }
        task.resume()
    }
}

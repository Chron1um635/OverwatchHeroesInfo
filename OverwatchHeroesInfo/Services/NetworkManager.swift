//
//  NetworkManager.swift
//  OverwatchHeroesInfo
//
//  Created by Максим Назаров on 07.11.2024.
//

import Foundation
import Alamofire

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchData(completion: @escaping (Result<[HeroDataTableObject], AFError>) -> Void) {
        AF.request("https://overfast-api.tekrop.fr/heroes")
            .validate()
            .responseDecodable(of: [HeroDataTableObject].self) { dataResponse in
                switch dataResponse.result {
                case .success(let heroes):
                    completion(.success(heroes))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    
    func fetchDetailsData(heroKey: String, completion: @escaping (Result<HeroDescription, AFError>) -> Void) {
        AF.request("https://overfast-api.tekrop.fr/heroes/\(heroKey)")
            .validate()
            .responseDecodable(of: HeroDescription.self) { dataResponse in
                switch dataResponse.result {
                case .success(let heroDescription):
                    completion(.success(heroDescription))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func fetchImageData(with url: String, completion: @escaping(Data) -> Void) {
        AF.request(url)
            .validate()
            .responseData { dataResponse in
                switch dataResponse.result {
                case .success(let data):
                    completion(data)
                case .failure(let error):
                    print(error)
                }
            }
    }
}

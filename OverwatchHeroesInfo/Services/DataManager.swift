//
//  DataManager.swift
//  OverwatchHeroesInfo
//
//  Created by Максим Назаров on 03.01.2025.
//

import Foundation

final class DataManager {
    
    static let shared = DataManager()
    
    private let userDefaults = UserDefaults()
    
    private init() {}
    
    func setFavoriteStatus(for heroKey: String, with status: Bool) {
        userDefaults.set(status, forKey: heroKey)
    }
    
    func getFavoriteStatus(for heroKey: String) -> Bool {
        userDefaults.bool(forKey: heroKey)
    }
}

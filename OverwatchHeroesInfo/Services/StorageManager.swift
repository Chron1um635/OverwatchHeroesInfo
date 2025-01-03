//
//  StorageManager.swift
//  OverwatchHeroesInfo
//
//  Created by Максим Назаров on 07.11.2024.
//

import Foundation
import RealmSwift

final class StorageManager {
    
    static let shared = StorageManager()
    
    let realm: Realm
    
    private init() {
        do {
            realm = try Realm()
        } catch {
            fatalError("Failed to initialize Realm: \(error)")
        }
    }
    
    func save(hero: Hero) {
        write {
            realm.add(hero)
        }
    }
    
    func delete(hero: Hero) {
        write {
            if let heroForDelete = realm.objects(Hero.self).first(where: { heroDB in
                hero.key == heroDB.key
            }) {
                realm.delete(heroForDelete)
            }
        }
    }
    
    func receiveHeroStatus(for hero: Hero) -> Bool {
        realm.objects(Hero.self).contains(hero)
    }
    
    private func write(completion: () -> Void) {
        do {
            try realm.write {
                completion()
            }
        } catch {
            print(error)
        }
    }
}

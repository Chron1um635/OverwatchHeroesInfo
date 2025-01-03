//
//  LikedHeroListInteractor.swift
//  OverwatchHeroesInfo
//
//  Created by Максим Назаров on 12.11.2024.
//

import Foundation
import RealmSwift

protocol LikedHeroesListInteractorInputProtocol {
    init(presenter: LikedHeroesListInteractorOutputProtocol)
    func fetchHeroes()
}

protocol LikedHeroesListInteractorOutputProtocol: AnyObject {
    func heroesDidReceive(with dataStore: HeroLikedListDataStore)
}

final class LikedHeroesListInteractor: LikedHeroesListInteractorInputProtocol {
    
    private let presenter: LikedHeroesListInteractorOutputProtocol
    
    private var heroes: Results<Hero>
    
    init(presenter: any LikedHeroesListInteractorOutputProtocol) {
        self.presenter = presenter
        heroes = StorageManager.shared.realm.objects(Hero.self)
    }
    
    func fetchHeroes() {
        let dataStore = HeroLikedListDataStore(likedHeroes: heroes)
        presenter.heroesDidReceive(with: dataStore)
    }
    
    
}

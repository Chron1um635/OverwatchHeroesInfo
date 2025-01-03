//
//  LikedHeroListPresenter.swift
//  OverwatchHeroesInfo
//
//  Created by Максим Назаров on 12.11.2024.
//

import Foundation
import RealmSwift

struct HeroLikedListDataStore {
    let likedHeroes: Results<Hero>
}

final class LikedHeroesListPresenter: LikedHeroesListViewOutputProtocol {
    
    var interactor: LikedHeroesListInteractorInputProtocol!
    
    var numberOfRows: Int {
        guard let count = dataStore?.likedHeroes.count else { return 0 }
        return count
    }
    
    private unowned let view: LikedHeroesListViewInputProtocol
    
    private var dataStore: HeroLikedListDataStore?
    
    
    init(view: any LikedHeroesListViewInputProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        interactor.fetchHeroes()
    }
    
//    func didTapCell(at indexPath: IndexPath) {
//        <#code#>
//    }
}

// MARK: - LikedHeroesListInteractorOutputProtocol
extension LikedHeroesListPresenter: LikedHeroesListInteractorOutputProtocol {
    func heroesDidReceive(with dataStore: HeroLikedListDataStore) {
        self.dataStore = dataStore
        view.reloadData()
    }
}

// MARK: - HeroCellPresenterInputProtocol
extension LikedHeroesListPresenter: HeroCellPresenterInputProtocol {
    func getHero(for index: Int) -> HeroDataTableObject {
        guard let hero = dataStore?.likedHeroes[index] else { return HeroDataTableObject() }
        let dataTableHero = HeroDataTableObject()
        dataTableHero.key = hero.key
        dataTableHero.name = hero.name
        dataTableHero.portrait = hero.portrait
        return dataTableHero
    }
}

//
//  HeroesListPresenter.swift
//  OverwatchHeroesInfo
//
//  Created by Максим Назаров on 07.11.2024.
//

import Foundation

struct HeroesListDataStore {
    let heroes: [HeroDataTableObject]
}

protocol HeroCellPresenterInputProtocol: AnyObject {
    func getHero(for index: Int) -> HeroDataTableObject
}

protocol HeroDetailsPresenterInputProtocol: AnyObject {
    func getHero(for heroKey: String) -> Hero
    func setStatus(for hero: Hero, with status: Bool)
}


final class HeroesListPresenter: HeroesListViewOutputProtocol {
    
    var interactor: HeroesListInteractorInputProtocol!
    var router: HeroesListRouterInputProtocol!
    
    private unowned let view: HeroesListViewInputProtocol
    private var dataStore: HeroesListDataStore?
    
    var numberOfRows: Int {
        guard let count = dataStore?.heroes.count else { return 0 }
        return count
    }
    
    init(view: any HeroesListViewInputProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        interactor.fetchHeroes()
    }
    
    func didTapCell(at indexPath: IndexPath) {
        guard let heroKey = dataStore?.heroes[indexPath.row].key else { return }
        router.openHeroDetailsViewController(with: heroKey)
    }
    
    
}

// MARK: - HeroesListInteractorOutputProtocol
extension HeroesListPresenter: HeroesListInteractorOutputProtocol {
    func heroesDidReceive(with dataStore: HeroesListDataStore) {
        self.dataStore = dataStore
        view.reloadData()
    }
}

// MARK: - HeroCellPresenterInputProtocol
extension HeroesListPresenter: HeroCellPresenterInputProtocol {
    func getHero(for index: Int) -> HeroDataTableObject {
        guard let hero = dataStore?.heroes[index] else { return HeroDataTableObject() }
        return hero
    }
}

// MARK: - HeroDetailsPresenterInputProtocol
extension HeroesListPresenter: HeroDetailsPresenterInputProtocol {
    func getHero(for heroKey: String) -> Hero {
        guard let hero = dataStore?.heroes.first(where: { hero in
            hero.key == heroKey
        }) else { return Hero() }
        let heroDB = Hero()
        heroDB.key = hero.key
        heroDB.name = hero.name
        heroDB.portrait = hero.portrait
        heroDB.liked = hero.liked
        return heroDB
    }
    
    func setStatus(for hero: Hero, with status: Bool) {
        dataStore?.heroes.first(where: { dataStoreHero in
            dataStoreHero.key == hero.key
        })?.liked = status
    }
}

//
//  HeroesListInteractor.swift
//  OverwatchHeroesInfo
//
//  Created by Максим Назаров on 07.11.2024.
//

import Foundation

protocol HeroesListInteractorInputProtocol {
    init(presenter: HeroesListInteractorOutputProtocol)
    func fetchHeroes()
}

protocol HeroesListInteractorOutputProtocol: AnyObject {
    func heroesDidReceive(with dataStore: HeroesListDataStore)
}

final class HeroesListInteractor: HeroesListInteractorInputProtocol {
    
    private unowned let presenter: HeroesListInteractorOutputProtocol
    
    init(presenter: any HeroesListInteractorOutputProtocol) {
        self.presenter = presenter
    }
    
    func fetchHeroes() {
        NetworkManager.shared.fetchData { [unowned self] result in
            switch result {
            case .success(let data):
                let dataStore = HeroesListDataStore(heroes: data)
                presenter.heroesDidReceive(with: dataStore)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
}

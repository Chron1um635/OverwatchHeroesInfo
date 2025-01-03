//
//  HeroDetailsPresenter.swift
//  OverwatchHeroesInfo
//
//  Created by Максим Назаров on 07.11.2024.
//

import Foundation

struct HeroDetailsDataStore {
    let heroName: String
    let heroImageData: Data
    let heroDescription: String
}


final class HeroDetailsPresenter: HeroDetailsViewOutputProtocol {
    
    var interactor: HeroDetailsInteractorInputProtocol!
    
    private unowned let view: HeroDetailsViewInputProtocol
    private unowned let presenter: HeroDetailsPresenterInputProtocol
    private var dataStore: HeroDetailsDataStore!
    
    init(view: HeroDetailsViewInputProtocol, presenter: HeroDetailsPresenterInputProtocol) {
        self.view = view
        self.presenter = presenter
    }
    
    func showHero(with key: String) {
        interactor.fetchHeroDetails(with: key)
    }
    
    func favoriteButtonPressed(for heroKey: String) {
        let hero = presenter.getHero(for: heroKey)
        interactor.toggleFavoritStatus(for: hero)
    }
}

// MARK: - HeroDetailsInteractorOutputProtocol
extension HeroDetailsPresenter: HeroDetailsInteractorOutputProtocol {
    func provideHeroDetails(with dataStore: HeroDetailsDataStore) {
        self.dataStore = dataStore
        view.displayHeroImage(with: dataStore.heroImageData)
        view.displayHeroName(with: dataStore.heroName)
        view.displayHeroDescription(with: dataStore.heroDescription)
    }
    
    func receiveFavoriteStatus(with status: Bool) {
        view.displayImageForFavoriteButton(with: status)
    }
}

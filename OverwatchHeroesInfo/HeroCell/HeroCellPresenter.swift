//
//  HeroCellPresenter.swift
//  OverwatchHeroesInfo
//
//  Created by Максим Назаров on 07.11.2024.
//

import Foundation

struct HeroCellDataStore {
    let heroName: String
    let heroImageData: Data
}

final class HeroCellPresenter: HeroCellViewOutputProtocol {

    var interactor: HeroCellInteractorInputProtocol!
    
    private unowned let view: HeroCellViewInputProtocol
    private unowned let presenter: HeroCellPresenterInputProtocol
    private var dataStore: HeroCellDataStore!
    private var hero: HeroDataTableObject!
    
    init(view: any HeroCellViewInputProtocol, presenter: HeroCellPresenterInputProtocol) {
        self.view = view
        self.presenter = presenter
    }
    
    func showHero(for index: Int) {
        hero = presenter.getHero(for: index)
        interactor.fetchHeroImage(with: hero.portrait)
    }
}

// MARK: - HeroCellInteractorOutputProtocol
extension HeroCellPresenter: HeroCellInteractorOutputProtocol {
    func heroImageDidReceive(with data: Data) {
        dataStore = HeroCellDataStore(heroName: hero.name, heroImageData: data)
        view.displayHeroName(with: dataStore.heroName)
        view.displayHeroImage(with: dataStore.heroImageData)
    }
}

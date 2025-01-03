//
//  HeroDetailsInteractor.swift
//  OverwatchHeroesInfo
//
//  Created by Максим Назаров on 07.11.2024.
//

import Foundation

protocol HeroDetailsInteractorInputProtocol {
    init(presenter: HeroDetailsInteractorOutputProtocol)
    func fetchHeroDetails(with key: String)
    func toggleFavoritStatus(for hero: Hero)
}

protocol HeroDetailsInteractorOutputProtocol: AnyObject  {
    func provideHeroDetails(with dataStore: HeroDetailsDataStore)
    func receiveFavoriteStatus(with status: Bool)
}

final class HeroDetailsInteractor: HeroDetailsInteractorInputProtocol {
    
    private unowned var presenter: HeroDetailsInteractorOutputProtocol
    
    init(presenter: HeroDetailsInteractorOutputProtocol) {
        self.presenter = presenter
    }
    
    func fetchHeroDetails(with key: String) {
        NetworkManager.shared.fetchDetailsData(heroKey: key) { result in
            switch result {
            case .success(let data):
                NetworkManager.shared.fetchImageData(with: data.portrait) { [unowned self] imageData in
                    presenter.provideHeroDetails(
                        with: HeroDetailsDataStore(
                            heroName: data.name,
                            heroImageData: imageData,
                            heroDescription: data.heroDescription ?? ""
                        )
                    )
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func toggleFavoritStatus(for hero: Hero) {
        var isFavorite: Bool {
            get {
                DataManager.shared.getFavoriteStatus(for: hero.key)
            } set {
                DataManager.shared.setFavoriteStatus(for: hero.key, with: newValue)
            }
        }
        if isFavorite {
            StorageManager.shared.delete(hero: hero)
            isFavorite.toggle()
            presenter.receiveFavoriteStatus(with: isFavorite)
        } else {
            StorageManager.shared.save(hero: hero)
            isFavorite.toggle()
            presenter.receiveFavoriteStatus(with: isFavorite)
        }
    }
}

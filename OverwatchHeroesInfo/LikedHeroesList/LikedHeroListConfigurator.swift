//
//  LikedHeroListConfigurator.swift
//  OverwatchHeroesInfo
//
//  Created by Максим Назаров on 12.11.2024.
//

import Foundation

protocol LikedHeroListConfiguratorInputProtocol {
    func configure(with view: LikedHeroesListViewController)
}

final class LikedHeroListConfigurator: LikedHeroListConfiguratorInputProtocol {
    func configure(with view: LikedHeroesListViewController) {
        let presenter = LikedHeroesListPresenter(view: view)
        let interactor = LikedHeroesListInteractor(presenter: presenter)
        let router = LikedHeroesListRouter(view: view)
        
        view.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}

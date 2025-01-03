//
//  HeroesListConfigurator.swift
//  OverwatchHeroesInfo
//
//  Created by Максим Назаров on 07.11.2024.
//

import Foundation

protocol HeroListConfiguratorInputProtocol {
    func configure(with view: HeroesListViewController)
}

final class HeroesListConfigurator: HeroListConfiguratorInputProtocol {
    func configure(with view: HeroesListViewController) {
        let presenter = HeroesListPresenter(view: view)
        let interactor = HeroesListInteractor(presenter: presenter)
        let router = HeroesListRouter(view: view)
        
        view.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}

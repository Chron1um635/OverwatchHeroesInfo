//
//  HeroDetailsConfigurator.swift
//  OverwatchHeroesInfo
//
//  Created by Максим Назаров on 07.11.2024.
//

import Foundation

protocol HeroDetailsConfiguratorInputProtocol {
    func configure(with view: HeroDetailsViewController, and heroKey: String, and presenter: HeroDetailsPresenterInputProtocol)
}

final class HeroDetailsConfigurator: HeroDetailsConfiguratorInputProtocol {
    func configure(with view: HeroDetailsViewController, and heroKey: String, and presenter: HeroDetailsPresenterInputProtocol) {
        let presenter = HeroDetailsPresenter(view: view, presenter: presenter)
        let interactor = HeroDetailsInteractor(presenter: presenter)
        
        view.presenter = presenter
        view.heroKey = heroKey
        presenter.interactor = interactor
    }
}

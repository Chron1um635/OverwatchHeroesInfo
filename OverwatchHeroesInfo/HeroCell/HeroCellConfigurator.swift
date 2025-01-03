//
//  HeroCellConfigurator.swift
//  OverwatchHeroesInfo
//
//  Created by Максим Назаров on 07.11.2024.
//

import Foundation

protocol HeroCellConfiguratorInputProtocol {
    func configure(with view: HeroCell, and presenter: HeroCellPresenterInputProtocol)
}

final class HeroCellConfigurator: HeroCellConfiguratorInputProtocol {
    func configure(with view: HeroCell, and presenter: HeroCellPresenterInputProtocol) {
        let presenter = HeroCellPresenter(view: view, presenter: presenter)
        let interactor = HeroCellInteractor(presenter: presenter)
        
        view.presenter = presenter
        presenter.interactor = interactor
    }
}

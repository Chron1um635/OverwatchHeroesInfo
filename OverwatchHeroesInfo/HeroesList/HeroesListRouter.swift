//
//  HeroesListRouter.swift
//  OverwatchHeroesInfo
//
//  Created by Максим Назаров on 07.11.2024.
//

import Foundation

protocol HeroesListRouterInputProtocol {
    init(view: HeroesListViewController)
    func openHeroDetailsViewController(with heroKey: String)
}

final class HeroesListRouter: HeroesListRouterInputProtocol {
    
    private unowned let view: HeroesListViewController
    
    init(view: HeroesListViewController) {
        self.view = view
    }
    
    func openHeroDetailsViewController(with heroKey: String) {
        view.performSegue(withIdentifier: "showDetails", sender: heroKey)
    }
    
}

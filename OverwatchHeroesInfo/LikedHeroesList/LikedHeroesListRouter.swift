//
//  LikedHeroesListRouter.swift
//  OverwatchHeroesInfo
//
//  Created by Максим Назаров on 12.11.2024.
//

import Foundation

protocol LikedHeroesListRouterInputProtocol {
    init(view: LikedHeroesListViewController)
    func openHeroDetailsViewController(with heroKey: String)
}

final class LikedHeroesListRouter: LikedHeroesListRouterInputProtocol {
    
    private unowned let view: LikedHeroesListViewController
    
    init(view: LikedHeroesListViewController) {
        self.view = view
    }
    
    func openHeroDetailsViewController(with heroKey: String) {
        view.performSegue(withIdentifier: "showDetails", sender: heroKey)
    }
    
}

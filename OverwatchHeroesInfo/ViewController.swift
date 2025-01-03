//
//  ViewController.swift
//  OverwatchHeroesInfo
//
//  Created by Максим Назаров on 07.11.2024.
//

import UIKit

class ViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.viewControllers?.forEach{ viewController in
            if let heroListVC = viewController as? HeroesListViewController {
                let heroListConfigurator = HeroesListConfigurator()
                heroListConfigurator.configure(with: heroListVC)
            }
        }
    }


}


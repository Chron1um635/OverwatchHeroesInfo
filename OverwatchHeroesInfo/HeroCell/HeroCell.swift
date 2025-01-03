//
//  HeroCell.swift
//  OverwatchHeroesInfo
//
//  Created by Максим Назаров on 07.11.2024.
//

import UIKit

protocol HeroCellViewInputProtocol: AnyObject {
    func displayHeroName(with name: String)
    func displayHeroImage(with data: Data)
}

protocol HeroCellViewOutputProtocol {
    init(view: HeroCellViewInputProtocol, presenter: HeroCellPresenterInputProtocol)
    func showHero(for index: Int)
}

final class HeroCell: UITableViewCell {
    
    @IBOutlet private var heroNameLabel: UILabel!
    
    @IBOutlet private var heroImageView: UIImageView!
    
    var presenter: HeroCellViewOutputProtocol!
    
    func updateView(for indexPath: IndexPath) {
        presenter.showHero(for: indexPath.row)
    }
}

// MARK: - HeroCellViewInputProtocol
extension HeroCell: HeroCellViewInputProtocol {
    func displayHeroName(with name: String) {
        heroNameLabel.text = name
    }
    
    func displayHeroImage(with data: Data) {
        heroImageView.image = UIImage(data: data)
        heroImageView.layer.cornerRadius = heroImageView.frame.height / 2
    }
}

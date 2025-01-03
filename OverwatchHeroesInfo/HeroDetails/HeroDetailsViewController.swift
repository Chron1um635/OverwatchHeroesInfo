//
//  HeroDetailsViewController.swift
//  OverwatchHeroesInfo
//
//  Created by Максим Назаров on 07.11.2024.
//

import UIKit

protocol HeroDetailsViewInputProtocol: AnyObject {
    func displayHeroImage(with data: Data)
    func displayHeroName(with name: String)
    func displayHeroDescription(with desc: String)
    func displayImageForFavoriteButton(with status: Bool)
}

protocol HeroDetailsViewOutputProtocol {
    init(view: HeroDetailsViewInputProtocol, presenter: HeroDetailsPresenterInputProtocol)
    func showHero(with key: String)
    func favoriteButtonPressed(for heroKey: String)
}

final class HeroDetailsViewController: UIViewController {
    
    @IBOutlet private var heroImageView: UIImageView!
    
    @IBOutlet private var heroNameLabel: UILabel!
    @IBOutlet private var heroDescriptionLabel: UILabel!
    
    @IBOutlet private var favoriteButton: UIBarButtonItem!

    var presenter: HeroDetailsViewOutputProtocol!
    var heroKey: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.showHero(with: heroKey)
    }
    
    @IBAction private func toggleFavorite() {
        presenter.favoriteButtonPressed(for: heroKey)
    }
}

// MARK: - HeroDetailsViewInputProtocol
extension HeroDetailsViewController: HeroDetailsViewInputProtocol {
    func displayHeroImage(with data: Data) {
        heroImageView.image = UIImage(data: data)
    }
    
    func displayHeroName(with name: String) {
        heroNameLabel.text = name
    }
    
    func displayHeroDescription(with desc: String) {
        heroDescriptionLabel.text = desc
    }
    
    func displayImageForFavoriteButton(with status: Bool) {
        favoriteButton.tintColor = status ? .red : .gray
    }
}

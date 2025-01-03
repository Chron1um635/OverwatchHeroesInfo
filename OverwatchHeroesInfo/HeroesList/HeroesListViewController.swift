//
//  HeroesListViewController.swift
//  OverwatchHeroesInfo
//
//  Created by Максим Назаров on 07.11.2024.
//

import UIKit

protocol HeroesListViewInputProtocol: AnyObject {
    func reloadData()
}

protocol HeroesListViewOutputProtocol {
    var numberOfRows: Int { get }
    init(view: HeroesListViewInputProtocol)
    func viewDidLoad()
    func didTapCell(at indexPath: IndexPath)
}

final class HeroesListViewController: UITableViewController {
    
    var presenter: HeroesListViewOutputProtocol!
    private let configurator: HeroListConfiguratorInputProtocol = HeroesListConfigurator()

    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.viewDidLoad()
    }

// MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailsVC = segue.destination as? HeroDetailsViewController else { return }
        
        guard let heroKey = sender as? String else { return }
        
        guard let presenter = presenter as? HeroDetailsPresenterInputProtocol else { return }
        let detailsConfigurator = HeroDetailsConfigurator()
        detailsConfigurator.configure(with: detailsVC, and: heroKey, and: presenter)
    }
}

// MARK: - UITableViewDataSource
extension HeroesListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfRows
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "heroCell", for: indexPath)
        guard let heroCell = cell as? HeroCell else { return cell }
        let cellConfigurator = HeroCellConfigurator()
        if let presenter = presenter as? HeroCellPresenterInputProtocol {
            cellConfigurator.configure(with: heroCell, and: presenter)
        }
        heroCell.updateView(for: indexPath)
        return heroCell
    }
}

// MARK: - UITableViewDelegate
extension HeroesListViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.didTapCell(at: indexPath)
    }
}

// MARK: - HeroesListViewInputProtocol
extension HeroesListViewController: HeroesListViewInputProtocol {
    func reloadData() {
        tableView.reloadData()
    }
}

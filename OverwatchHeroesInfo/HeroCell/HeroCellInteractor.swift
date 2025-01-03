//
//  HeroCellInteractor.swift
//  OverwatchHeroesInfo
//
//  Created by Максим Назаров on 07.11.2024.
//

import Foundation

protocol HeroCellInteractorInputProtocol {
    init(presenter: HeroCellInteractorOutputProtocol)
    func fetchHeroImage(with url: String)
}

protocol HeroCellInteractorOutputProtocol: AnyObject {
    func heroImageDidReceive(with data: Data)
}

final class HeroCellInteractor: HeroCellInteractorInputProtocol {
    
    private unowned let presenter: HeroCellInteractorOutputProtocol
    
    init(presenter: any HeroCellInteractorOutputProtocol) {
        self.presenter = presenter
    }
    
    func fetchHeroImage(with url: String) {
        NetworkManager.shared.fetchImageData(with: url) { [unowned self] data in
            presenter.heroImageDidReceive(with: data)
        }
    }
    
}

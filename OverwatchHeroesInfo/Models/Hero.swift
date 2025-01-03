//
//  Hero.swift
//  OverwatchHeroesInfo
//
//  Created by Максим Назаров on 07.11.2024.
//

import Foundation
import RealmSwift

final class Hero: Object {
    @Persisted var key: String = ""
    @Persisted var name: String = ""
    @Persisted var portrait: String = ""
    @Persisted var liked: Bool? = false
}

final class HeroDataTableObject: Decodable {
    var key: String = ""
    var name: String = ""
    var portrait: String = ""
    var liked: Bool? = false
}

struct HeroDescription: Decodable {
    let name: String
    let description: String
    let portrait: String
    let role: String
    let location: String
    let age: Int
    let birthday: String
    
    var heroDescription: String? {
        """
        Description: \(description)
        
        Role: \(role)
        
        Location: \(location)
        
        Age: \(age)
        
        Birthday: \(birthday)
        """
    }
    var liked: Bool? = false
}

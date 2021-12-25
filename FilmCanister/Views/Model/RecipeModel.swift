//
//  RecipeModel.swift
//  FilmCanister
//
//  Created by dwKang on 2021/12/26.
//

import Foundation
import RealmSwift

class RecipeModel: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    
    convenience init(id: Int, name: String) {
        self.init()
        self.id = id
        self.name = name
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

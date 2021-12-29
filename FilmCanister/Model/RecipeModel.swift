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
    @objc dynamic var simulName: String = ""
    @objc dynamic var imageCount: Int = 0
    
    convenience init(id: Int, name: String, simulName: String, imageCount: Int) {
        self.init()
        self.id = id
        self.name = name
        self.simulName = simulName
        self.imageCount = imageCount
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

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
    @objc dynamic var film_simulation: String = ""
    @objc dynamic var image_count: Int = 0
    @objc dynamic var dynamic_range: String = ""
    @objc dynamic var highlight: String = ""
    @objc dynamic var shadow: String = ""
    @objc dynamic var color: String = ""
    @objc dynamic var noise_reduction: String = ""
    @objc dynamic var sharpening: String = ""
    @objc dynamic var clarity: String = ""
    @objc dynamic var grain_effect: String = ""
    @objc dynamic var color_chrome_effect: String = ""
    @objc dynamic var color_chrome_effect_blue: String = ""
    @objc dynamic var white_balance: String = ""
    @objc dynamic var red: String = ""
    @objc dynamic var blue: String = ""
    @objc dynamic var exposure_compensation_1: String = ""
    @objc dynamic var exposure_compensation_2: String = ""
    @objc dynamic var memo: String = ""
    
    convenience init(id: Int, name: String, film_simulation: String, image_count: Int, dynamic_range: String, highlight: String,
                     shadow: String, color: String, noise_reduction: String, sharpening: String, clarity: String, grain_effect: String,
                     color_chrome_effect: String, color_chrome_effect_blue: String, white_balance: String, red: String, blue: String,
                     exposure_compensation_1: String, exposure_compensation_2: String, memo: String) {
        self.init()
        self.id = id
        self.name = name
        self.film_simulation = film_simulation
        self.image_count = image_count
        self.dynamic_range = dynamic_range
        self.highlight = highlight
        self.shadow = shadow
        self.color = color
        self.noise_reduction = noise_reduction
        self.sharpening = sharpening
        self.clarity = clarity
        self.grain_effect = grain_effect
        self.color_chrome_effect = color_chrome_effect
        self.color_chrome_effect_blue = color_chrome_effect_blue
        self.white_balance = white_balance
        self.red = red
        self.blue = blue
        self.exposure_compensation_1 = exposure_compensation_1
        self.exposure_compensation_2 = exposure_compensation_2
        self.memo = memo
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

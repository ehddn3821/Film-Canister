//
//  CommonConstants.swift
//  FilmCanister
//
//  Created by dwKang on 2021/12/24.
//

import UIKit

struct Constants {
    static let MAIN_FONT_BOLD = "Inter-Bold"
    static let MAIN_FONT_REGULAR = "Inter-Regular"
    static let MAIN_FONT_SEMIBOLD = "Inter-SemiBold"
    
    // Color
    static let COLOR_SECONDARY = "Secondary"
    static let COLOR_SIDE = "Secondary2"
    static let COLOR_MAIN_TEXT = "MainText"
    static let COLOR_MAIN_BACKGROUND = "MainBackground"
    static let COLOR_DIVIDER = "Divider"
    static let COLOR_ENABLE = "Enable"
    static let COLOR_DISABLE = "Disable"
    static let COLOR_MEMO_BORDER = "MemoBorder"
    static let COLOR_DELETE = "Delete"
    
    // Settings
    static let SETTING_LIST = [ "Film Simulation",
                                "Dynamic Range",
                                "Highlight",
                                "Shadow",
                                "Color",
                                "Noise Reduction",
                                "Sharpening",
                                "Clarity",
                                "Grain Effect",
                                "Color Chorme Effect",
                                "Color Chorme Effect Blue",
                                "White Balance",
                                "Red",
                                "Blue",
                                "Exposure Compensation" ]
    
    static let SETTING_IMAGE_LIST = [ "FilmSimulation",
                                      "DynamicRange",
                                      "Highlight",
                                      "Shadow",
                                      "Color",
                                      "NoiseReduction",
                                      "Sharpening",
                                      "Clarity",
                                      "GrainEffect",
                                      "ColorChormeEffect",
                                      "ColorChormeEffectBlue",
                                      "WhiteBalance",
                                      "ExposureCompensation" ]

    static let SIMULATION_LIST = [ "Provia","Velvia","Astia","Classic Chrome","PRO Neg.Hi","Pro Neg. Std",
                                   "Classic Neg.","Eterna","Eterna Bleach Bypass","Nostalgic Neg.",
                                   "Acros STD","Acros Ye","Acros R","Acros G","Monochrome STD","Monochrome Ye",
                                   "Monochrome R","Monochrome G","Sepia" ]
    
    static let DYNAMIC_RANGE_LIST = [ "Auto",
                                      "DR400",
                                      "DR200",
                                      "DR100" ]
    
    static let HIGHLIGHT_SHADOW_LIST = [ "+4",
                                         "+3.5",
                                         "+3",
                                         "+2.5",
                                         "+2",
                                         "+1.5",
                                         "+1",
                                         "+0.5",
                                         "0",
                                         "-0.5",
                                         "-1",
                                         "-1.5",
                                         "-2" ]
    
    static let COLOR_NOISE_SHARP_LIST = [ "+4",
                                          "+3",
                                          "+2",
                                          "+1",
                                          "0",
                                          "-1",
                                          "-2",
                                          "-3",
                                          "-4" ]
    
    static let CLARITY_LIST = [ "+5",
                                "+4",
                                "+3",
                                "+2",
                                "+1",
                                "0",
                                "-1",
                                "-2",
                                "-3",
                                "-4",
                                "+5" ]
    
    static let GRAIN_EFFECT_LIST = [ "Off",
                                     "Weak / Small",
                                     "Weak / Large",
                                     "Strong / Small",
                                     "Strong / Large" ]
    
    static let COLOR_CHROME_EFFECT_LIST = [ "Off",
                                            "Weak",
                                            "Strong" ]
    
    static let WHITE_BALANCE_LIST = [ "Auto",
                                      "Auto White",
                                      "Auto Ambience",
                                      "K",
                                      "Daylight",
                                      "Shade",
                                      "Fluorescent 1",
                                      "Fluorescent 2",
                                      "Fluorescent 3",
                                      "Incandescent",
                                      "Under Water" ]
    
    static let RED_BLUE_LIST = [ "+9",
                                 "+8",
                                 "+7",
                                 "+6",
                                 "+5",
                                 "+4",
                                 "+3",
                                 "+2",
                                 "+1",
                                 "0",
                                 "-1",
                                 "-2",
                                 "-3",
                                 "-4",
                                 "-5",
                                 "-6",
                                 "-7",
                                 "-8",
                                 "-9" ]
    
    static let EXPOSURE_LIST = [ "+3.0",
                                 "+2.6",
                                 "+2.3",
                                 "+2.0",
                                 "+1.6",
                                 "+1.3",
                                 "+1.0",
                                 "+2",
                                 "+0.6",
                                 "+0.3",
                                 "0",
                                 "-0.3",
                                 "-0.6",
                                 "-1",
                                 "-1.3",
                                 "-1.6",
                                 "-2",
                                 "-2.3",
                                 "-2.6",
                                 "-3.0" ]
    
    static let SETTING_DEFAULT_VALUE = [ "Provia", "Auto", "0", "0", "0", "0", "0", "0", "Off", "Off", "Off", "Auto", "0", "0", "0", "0" ]
    
    // 초기 데이터
    static let SAMPLE_IMAGES = [SAMPLE_IMAGE_1, SAMPLE_IMAGE_2, SAMPLE_IMAGE_3]
    static let SAMPLE_IMAGE_1: [UIImage] = [.init(named: "Sample1_1")!, .init(named: "Sample1_2")!, .init(named: "Sample1_3")!]
    static let SAMPLE_IMAGE_2: [UIImage] = [.init(named: "Sample2_1")!, .init(named: "Sample2_2")!]
    static let SAMPLE_IMAGE_3: [UIImage] = [.init(named: "Sample3_1")!, .init(named: "Sample3_2")!, .init(named: "Sample3_3")!]
    
    static let SAMPLE_SIMUL_LIST: [String] = ["Eterna", "Classic Neg.", "Classic Chrome"]
    static let SAMPLE_HIGHLIGHT_LIST: [String] = ["0", "-1", "+2"]
    static let SAMPLE_SHADOW_LIST: [String] = ["+2", "0", "-2"]
    static let SAMPLE_COLOR_LIST: [String] = ["+2", "+4", "+2"]
    static let SAMPLE_NOISE_LIST: [String] = ["-1", "-3", "-3"]
    static let SAMPLE_SHARP_LIST: [String] = ["-3", "0", "0"]
    static let SAMPLE_CLARITY_LIST: [String] = ["+2", "-5", "+2"]
    static let SAMPLE_GRAIN_LIST: [String] = ["Weak / Small", "Weak / Small", "Weak / Large"]
    static let SAMPLE_CHROME_LIST: [String] = ["Off", "Off", "Weak"]
    static let SAMPLE_CHROME_BLUE_LIST: [String] = ["Off", "Strong", "Weak"]
    static let SAMPLE_WHITE_LIST: [String] = ["Fluorescent 2", "Auto", "Auto"]
    static let SAMPLE_RED_LIST: [String] = ["-1", "+3", "+4"]
    static let SAMPLE_BLUE_LIST: [String] = ["+1", "-5", "-4"]
    static let SAMPLE_EXPOSURE_1_LIST: [String] = ["-0.6", "-0.3", "-0.3"]
    static let SAMPLE_IMAGE_COUNT: [Int] = [3, 2, 3]
}

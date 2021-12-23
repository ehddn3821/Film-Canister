//
//  MainViewController.swift
//  FilmCanister
//
//  Created by dwKang on 2021/12/23.
//

import UIKit

class MainViewController: UIViewController {
    
    //MARK: - UI Property
    let filmIV = UIImageView()
    let emptySimulLB = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        Log.info("viewDidLoad")
        setupUI()
    }
}


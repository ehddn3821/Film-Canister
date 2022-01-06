//
//  DetailImageViewController.swift
//  FilmCanister
//
//  Created by dwKang on 2021/12/27.
//

import UIKit

class DetailImageViewController: CustomNavigationBarViewController<UIView> {
    
    var detailImg: UIImage!
    let detailIV = UIImageView()
    
    
    init(detailImg: UIImage) {
        super.init()
        self.detailImg = detailImg
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    func setupUI() {
        customNavigationBar.isEnablePopBtn = true
        
        bodyView.backgroundColor = .black
        
        detailIV.image = detailImg
        detailIV.contentMode = .scaleAspectFit
        bodyView.addSubview(detailIV)
        detailIV.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

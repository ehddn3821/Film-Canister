//
//  DetailImageViewController.swift
//  FilmCanister
//
//  Created by dwKang on 2021/12/27.
//

import UIKit
import ImageScrollView

class DetailImageViewController: CustomNavigationBarViewController<UIView> {
    
    var detailImg: UIImage!
    let scrollView = ImageScrollView()
    
    
    init(detailImg: UIImage) {
        super.init()
        self.detailImg = detailImg
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.setup()
    }
    
    
    func setupUI() {
        customNavigationBar.isEnablePopBtn = true
        
        bodyView.backgroundColor = .black
        
        bodyView.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.leading.top.equalToSuperview()
            make.trailing.equalTo(view)
            make.bottom.equalTo(view).offset(-UI.SAFE_AREA_BOTTOM)
        }
        
        scrollView.display(image: detailImg)
    }
}

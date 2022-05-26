//
//  BaseNavigationBar.swift
//  FilmCanister
//
//  Created by dwKang on 2021/12/24.
//

import UIKit

class BaseNavigationBar: UIView {
    let barTitle: UILabel = {
        let lb = UILabel()
        lb.textColor = .init(named: Constants.COLOR_MAIN_TEXT)
        lb.font = UIFont(name: Constants.MAIN_FONT_BOLD, size: 16)
        return lb
    }()
    let leftBtn = UIButton()
    let rightBtn = UIButton()
    var isEnablePopBtn: Bool = false {
        didSet {
            if isEnablePopBtn {
                self.addSubview(leftBtn)
                leftBtn.setImage(UIImage(named: "back"), for: .normal)
                leftBtn.snp.makeConstraints { make in
                    make.size.equalTo(40)
                    make.leading.equalTo(16)
                    make.centerY.equalToSuperview().offset(UI.SAFE_AREA_TOP/2)
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.addSubview(barTitle)
        barTitle.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(UI.SAFE_AREA_TOP/2)
        }
    }
    
    func setTitle(title: String) {
        barTitle.text = title
    }
}

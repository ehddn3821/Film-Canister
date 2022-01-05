//
//  AddSettingModalTableViewCell.swift
//  FilmCanister
//
//  Created by dwKang on 2021/12/25.
//

import UIKit

class RecipeSettingModalTableViewCell: UITableViewCell {
    let nameLB = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(nameLB)
        nameLB.textColor = .init(named: Constants.COLOR_SECONDARY)
        nameLB.font = .init(name: Constants.MAIN_FONT_SEMIBOLD, size: 14)
        nameLB.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-32)
            make.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

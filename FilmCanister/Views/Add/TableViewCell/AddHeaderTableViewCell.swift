//
//  AddHeaderTableViewCell.swift
//  FilmCanister
//
//  Created by dwKang on 2021/12/24.
//

import UIKit

class AddHeaderTableViewCell: UITableViewCell {
    let titleLB = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .init(named: Constants.COLOR_MAIN_BACKGROUND)
        
        contentView.addSubview(titleLB)
        titleLB.textColor = .init(named: Constants.COLOR_MAIN_TEXT)
        titleLB.font = UIFont(name: Constants.MAIN_FONT_SEMIBOLD, size: 14)
        titleLB.snp.makeConstraints { make in
            make.leading.equalTo(16)
            make.top.equalTo(17)
            make.trailing.equalTo(-16)
            make.bottom.equalTo(-17)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

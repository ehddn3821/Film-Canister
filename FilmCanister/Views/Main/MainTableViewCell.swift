//
//  MainTableViewCell.swift
//  FilmCanister
//
//  Created by dwKang on 2021/12/26.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    let nameLB = UILabel()
    let divideView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .systemBackground
        
        contentView.addSubview(nameLB)
        nameLB.textColor = .init(named: Constants.COLOR_MAIN_TEXT)
        nameLB.font = .init(name: Constants.MAIN_FONT_SEMIBOLD, size: 14)
        nameLB.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(18)
            make.trailing.equalTo(-108)
            make.bottom.equalTo(-40)
        }
        
        contentView.addSubview(divideView)
        divideView.backgroundColor = .init(named: Constants.COLOR_DIVIDER)
        divideView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.leading.equalTo(nameLB)
            make.trailing.equalTo(-16)
            make.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

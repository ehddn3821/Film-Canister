//
//  MainTableViewCell.swift
//  FilmCanister
//
//  Created by dwKang on 2021/12/26.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    let nameLB = UILabel()
    let simulNameLB = UILabel()
    let sampleIV = UIImageView()
    let nextIV = UIImageView()
    let divideView = UIView()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .systemBackground
        
        contentView.addSubview(nameLB)
        nameLB.textColor = .init(named: Constants.COLOR_MAIN_TEXT)
        nameLB.font = .init(name: Constants.MAIN_FONT_SEMIBOLD, size: 14)
        nameLB.snp.makeConstraints { make in
            make.height.equalTo(22)
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(18)
            make.trailing.equalTo(-108)
        }
        
        contentView.addSubview(simulNameLB)
        simulNameLB.textColor = .init(named: Constants.COLOR_SECONDARY)
        simulNameLB.font = .init(name: Constants.MAIN_FONT_REGULAR, size: 11)
        simulNameLB.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.leading.equalToSuperview().offset(17)
            make.top.equalTo(nameLB.snp.bottom).offset(2)
        }
        
        contentView.addSubview(sampleIV)
        sampleIV.contentMode = .scaleAspectFill
        sampleIV.clipsToBounds = true
        sampleIV.layer.cornerRadius = 12
        sampleIV.snp.makeConstraints { make in
            make.size.equalTo(48)
            make.trailing.equalTo(-48)
            make.centerY.equalToSuperview()
        }
        
        contentView.addSubview(nextIV)
        nextIV.image = .init(named: "next")
        nextIV.snp.makeConstraints { make in
            make.size.equalTo(24)
            make.trailing.equalTo(-16)
            make.centerY.equalToSuperview()
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

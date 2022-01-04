//
//  SettingTableViewCell.swift
//  FilmCanister
//
//  Created by 앱지 Appg on 2022/01/04.
//

import UIKit

class SettingTableViewCell: UITableViewCell {
    let iconIV = UIImageView()
    let nameLB = UILabel()
    let valueBtn = UIButton()
    let divider = UIView()
    let exposureValueBtn = UIButton()
    let toLB = UILabel()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(iconIV)
        iconIV.snp.makeConstraints { make in
            make.size.equalTo(24)
            make.leading.equalTo(16)
            make.centerY.equalToSuperview()
        }
        
        contentView.addSubview(nameLB)
        nameLB.font = UIFont(name: Constants.MAIN_FONT_REGULAR, size: 12)
        nameLB.textColor = UIColor(named: Constants.COLOR_MAIN_TEXT)
        nameLB.snp.makeConstraints { make in
            make.leading.equalTo(iconIV.snp.trailing).offset(9)
            make.centerY.equalToSuperview()
        }
        
        contentView.addSubview(valueBtn)
        valueBtn.setTitleColor(.init(named: Constants.COLOR_MAIN_TEXT), for: .normal)
        valueBtn.titleLabel?.font = UIFont(name: Constants.MAIN_FONT_SEMIBOLD, size: 14)
        valueBtn.contentHorizontalAlignment = .right
        valueBtn.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
//            make.leading.equalToSuperview().offset(140)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        contentView.addSubview(exposureValueBtn)
        exposureValueBtn.isHidden = true
        exposureValueBtn.setTitleColor(.init(named: Constants.COLOR_MAIN_TEXT), for: .normal)
        exposureValueBtn.titleLabel?.font = UIFont(name: Constants.MAIN_FONT_SEMIBOLD, size: 14)
        exposureValueBtn.contentHorizontalAlignment = .right
        exposureValueBtn.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.trailing.equalToSuperview().offset(-85)
        }
        
        toLB.text = "to"
        toLB.font = UIFont(name: Constants.MAIN_FONT_REGULAR, size: 12)
        toLB.textColor = UIColor(named: Constants.COLOR_MAIN_TEXT)
        toLB.isHidden = true
        contentView.addSubview(toLB)
        toLB.snp.makeConstraints { make in
            make.leading.equalTo(exposureValueBtn.snp.trailing).offset(8)
            make.centerY.equalToSuperview()
        }
        
        contentView.addSubview(divider)
        divider.backgroundColor = UIColor(named: Constants.COLOR_DIVIDER)
        divider.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16)
        }
    }
}

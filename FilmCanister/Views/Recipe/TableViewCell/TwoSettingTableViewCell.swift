//
//  TwoSettingTableViewCell.swift
//  FilmCanister
//
//  Created by dwKang on 2022/01/04.
//

import UIKit

class TwoSettingTableViewCell: UITableViewCell {
    let firstIconIV = UIImageView()
    let firstNameLB = UILabel()
    let firstValueBtn = UIButton()
    let secondIconIV = UIImageView()
    let secondNameLB = UILabel()
    let secondValueBtn = UIButton()
    let divider1 = UIView()
    let divider2 = UIView()
    
    var firstNameLBLeadingConstraint = NSLayoutConstraint()
    var secondNameLBLeadingConstraint = NSLayoutConstraint()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(firstIconIV)
        firstIconIV.snp.makeConstraints { make in
            make.size.equalTo(24)
            make.leading.equalTo(16)
            make.centerY.equalToSuperview()
        }
        
        contentView.addSubview(firstNameLB)
        firstNameLB.font = UIFont(name: Constants.MAIN_FONT_REGULAR, size: 12)
        firstNameLB.textColor = UIColor(named: Constants.COLOR_MAIN_TEXT)
        firstNameLB.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
        }
        firstNameLBLeadingConstraint = firstNameLB.leadingAnchor.constraint(equalTo: firstIconIV.trailingAnchor, constant: 9)
        
        contentView.addSubview(firstValueBtn)
        firstValueBtn.setTitleColor(.init(named: Constants.COLOR_MAIN_TEXT), for: .normal)
        firstValueBtn.titleLabel?.font = UIFont(name: Constants.MAIN_FONT_SEMIBOLD, size: 14)
        firstValueBtn.contentHorizontalAlignment = .right
        firstValueBtn.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.trailing.equalToSuperview().offset(-(UIScreen.main.bounds.width/2 + 16))
        }
        
        contentView.addSubview(secondIconIV)
        secondIconIV.snp.makeConstraints { make in
            make.size.equalTo(24)
            make.leading.equalToSuperview().offset(UIScreen.main.bounds.width/2 + 16)
            make.centerY.equalToSuperview()
        }
        
        contentView.addSubview(secondNameLB)
        secondNameLB.font = UIFont(name: Constants.MAIN_FONT_REGULAR, size: 12)
        secondNameLB.textColor = UIColor(named: Constants.COLOR_MAIN_TEXT)
        secondNameLB.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
        }
        secondNameLBLeadingConstraint = secondNameLB.leadingAnchor.constraint(equalTo: secondIconIV.trailingAnchor, constant: 9)
        
        contentView.addSubview(secondValueBtn)
        secondValueBtn.setTitleColor(.init(named: Constants.COLOR_MAIN_TEXT), for: .normal)
        secondValueBtn.titleLabel?.font = UIFont(name: Constants.MAIN_FONT_SEMIBOLD, size: 14)
        secondValueBtn.contentHorizontalAlignment = .right
        secondValueBtn.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16)
        }
        
        contentView.addSubview(divider1)
        divider1.backgroundColor = UIColor(named: Constants.COLOR_DIVIDER)
        divider1.snp.makeConstraints { make in
            make.width.equalTo(UIScreen.main.bounds.width / 2 - 32)
            make.height.equalTo(1)
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview()
        }
        
        contentView.addSubview(divider2)
        divider2.backgroundColor = UIColor(named: Constants.COLOR_DIVIDER)
        divider2.snp.makeConstraints { make in
            make.width.equalTo(UIScreen.main.bounds.width / 2 - 32)
            make.height.equalTo(1)
            make.bottom.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16)
        }
    }
}

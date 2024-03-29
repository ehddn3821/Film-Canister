//
//  SettingTableViewCell.swift
//  FilmCanister
//
//  Created by dwKang on 2022/01/04.
//

import UIKit

class SettingTableViewCell: UITableViewCell {
    let iconIV = UIImageView()
    let nameLB = UILabel()
    let valueBtn = UIButton()
    let divider = UIView()
    let exposureValueBtn = UIButton()
    let toLB = UILabel()
    let whiteBalanceValueTF = UITextField()
    let whiteBalanceValueLB = UILabel()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        whiteBalanceValueTF.delegate = self
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
            make.trailing.equalToSuperview().offset(-16)
        }
        
        contentView.addSubview(whiteBalanceValueTF)
        whiteBalanceValueTF.isHidden = true
        whiteBalanceValueTF.font = .init(name: Constants.MAIN_FONT_REGULAR, size: 14)
        whiteBalanceValueTF.layer.cornerRadius = 4
        whiteBalanceValueTF.layer.borderWidth = 1
        whiteBalanceValueTF.layer.borderColor = UIColor.init(named: Constants.COLOR_MEMO_BORDER)?.cgColor
        whiteBalanceValueTF.textColor = .init(named: Constants.COLOR_MAIN_TEXT)
        whiteBalanceValueTF.attributedPlaceholder = NSAttributedString(string: "ex) 6300", attributes: [NSAttributedString.Key.foregroundColor : UIColor.init(named: Constants.COLOR_DISABLE)!])
        whiteBalanceValueTF.keyboardType = .numberPad
        whiteBalanceValueTF.addLeftPadding()
        whiteBalanceValueTF.snp.makeConstraints { make in
            make.width.equalTo(88)
            make.height.equalTo(32)
            make.centerY.equalToSuperview()
            make.trailing.equalTo(valueBtn.snp.leading).offset(8)
        }
        
        contentView.addSubview(whiteBalanceValueLB)
        whiteBalanceValueLB.isHidden = true
        whiteBalanceValueLB.font = .init(name: Constants.MAIN_FONT_SEMIBOLD, size: 14)
        whiteBalanceValueLB.textColor = .init(named: Constants.COLOR_MAIN_TEXT)
        whiteBalanceValueLB.textAlignment = .right
        whiteBalanceValueLB.snp.makeConstraints { make in
            make.width.equalTo(88)
            make.height.equalTo(32)
            make.centerY.equalToSuperview()
            make.trailing.equalTo(valueBtn.snp.leading).offset(8)
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


extension SettingTableViewCell: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let topVC = UIApplication.topViewController() as! RecipeViewController
        if textField.text != "" {
            topVC.kValueText.onNext(textField.text!)
            topVC.customNavigationBar.rightBtn.isEnabled = true
        } else {
            topVC.customNavigationBar.rightBtn.isEnabled = false
        }
    }
}

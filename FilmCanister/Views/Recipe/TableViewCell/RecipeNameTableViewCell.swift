//
//  RecipeNameTableViewCell.swift
//  FilmCanister
//
//  Created by dwKang on 2021/12/24.
//

import UIKit

class RecipeNameTableViewCell: UITableViewCell {
    let nameTextField = UITextField()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemBackground
        
        contentView.addSubview(nameTextField)
        nameTextField.delegate = self
        nameTextField.textColor = .init(named: Constants.COLOR_MAIN_TEXT)
        nameTextField.font = UIFont(name: Constants.MAIN_FONT_REGULAR, size: 14)
        nameTextField.placeholder = "Please enter recipe name"
        nameTextField.layer.cornerRadius = 4
        nameTextField.layer.borderColor = UIColor.init(named: Constants.COLOR_MEMO_BORDER)?.cgColor
        nameTextField.layer.borderWidth = 1
        nameTextField.addLeftPadding()
        nameTextField.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.leading.equalTo(16)
            make.top.equalTo(24)
            make.trailing.equalTo(-16)
            make.bottom.equalTo(-24)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RecipeNameTableViewCell: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let topVC = UIApplication.topViewController() as! RecipeViewController
        if textField.text != "" {
            topVC.customNavigationBar.rightBtn.isEnabled = true
        } else {
            topVC.customNavigationBar.rightBtn.isEnabled = false
        }
    }
}

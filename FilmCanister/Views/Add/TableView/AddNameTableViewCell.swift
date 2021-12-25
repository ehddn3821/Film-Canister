//
//  AddNameTableViewCell.swift
//  FilmCanister
//
//  Created by dwKang on 2021/12/24.
//

import UIKit

class AddNameTableViewCell: UITableViewCell {
    let nameTextField = UITextField()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemBackground
        
        contentView.addSubview(nameTextField)
        nameTextField.textColor = .init(named: Constants.COLOR_MAIN_TEXT)
        nameTextField.font = UIFont(name: Constants.MAIN_FONT_REGULAR, size: 14)
        nameTextField.placeholder = "Please enter recipe name"
        nameTextField.borderStyle = .roundedRect
        nameTextField.snp.makeConstraints { make in
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

//
//  AddTitleTableViewCell.swift
//  FilmCanister
//
//  Created by dwKang on 2021/12/24.
//

import UIKit

class AddTitleTableViewCell: UITableViewCell {
    let titleTextField = UITextField()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        contentView.backgroundColor = .systemBackground
        
        contentView.addSubview(titleTextField)
        titleTextField.textColor = .init(named: Constants.COLOR_MAIN_TEXT)
        titleTextField.font = UIFont(name: Constants.MAIN_FONT_REGULAR, size: 14)
        titleTextField.placeholder = "Write a Name"
        titleTextField.borderStyle = .roundedRect
        titleTextField.snp.makeConstraints { make in
            make.leading.equalTo(16)
            make.top.equalTo(24)
            make.trailing.equalTo(-16)
            make.bottom.equalTo(-24)
        }
    }
}

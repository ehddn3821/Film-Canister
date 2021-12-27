//
//  AddMemoTableViewCell.swift
//  FilmCanister
//
//  Created by dwKang on 2021/12/25.
//

import UIKit

class AddMemoTableViewCell: UITableViewCell {
    let memoView = UIView()
    let memoTextView = UITextView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        memoTextView.delegate = self
        
        contentView.addSubview(memoView)
        memoView.layer.cornerRadius = 4
        memoView.layer.borderColor = UIColor.init(named: Constants.COLOR_MEMO_BORDER)?.cgColor
        memoView.layer.borderWidth = 1
        memoView.snp.makeConstraints { make in
            make.height.equalTo(184)
            make.leading.equalTo(16)
            make.top.equalTo(24)
            make.trailing.equalTo(-16)
            make.bottom.equalTo(-64)
        }
        
        memoView.addSubview(memoTextView)
        memoTextView.font = .init(name: Constants.MAIN_FONT_REGULAR, size: 14)
        memoTextView.text = "Please enter memo"
        memoTextView.textColor = .init(named: Constants.COLOR_DISABLE)
        memoTextView.snp.makeConstraints { make in
            make.leading.equalTo(14)
            make.top.equalTo(10)
            make.trailing.equalTo(-14)
            make.bottom.equalTo(-10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AddMemoTableViewCell: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        placeholderSetup()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            placeholderSetup()
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
        }
        return true
    }
    
    private func placeholderSetup() {
        if memoTextView.text == "Please enter memo" {
            memoTextView.text = ""
            memoTextView.textColor = .init(named: Constants.COLOR_MAIN_TEXT)
        } else if memoTextView.text == "" {
            memoTextView.text = "Please enter memo"
            memoTextView.textColor = .init(named: Constants.COLOR_DISABLE)
        }
    }
}

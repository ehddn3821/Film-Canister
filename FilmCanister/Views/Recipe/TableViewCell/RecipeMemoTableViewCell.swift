//
//  RecipeMemoTableViewCell.swift
//  FilmCanister
//
//  Created by dwKang on 2021/12/25.
//

import UIKit

class RecipeMemoTableViewCell: UITableViewCell {
    let memoView = UIView()
    let memoTextView = UITextView()
    let memoPlaceholder = UILabel()
    var isSaveEnabled = false
    var memoChange = false
    
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
        memoTextView.textColor = .init(named: Constants.COLOR_MAIN_TEXT)
        memoTextView.snp.makeConstraints { make in
            make.leading.equalTo(14)
            make.top.equalTo(10)
            make.trailing.equalTo(-14)
            make.bottom.equalTo(-10)
        }
        
        memoView.addSubview(memoPlaceholder)
        memoPlaceholder.font = .init(name: Constants.MAIN_FONT_REGULAR, size: 14)
        memoPlaceholder.text = "Please enter memo"
        memoPlaceholder.textColor = .init(named: Constants.COLOR_DISABLE)
        memoPlaceholder.snp.makeConstraints { make in
            make.leading.equalTo(16)
            make.top.equalTo(16)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RecipeMemoTableViewCell: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        let topVC = UIApplication.topViewController() as! RecipeViewController
        if topVC.customNavigationBar.rightBtn.isEnabled {
            isSaveEnabled = true
            topVC.customNavigationBar.rightBtn.isEnabled = false
        } else {
            isSaveEnabled = false
            topVC.customNavigationBar.rightBtn.isEnabled = false
        }
        memoPlaceholder.isHidden = true
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        guard let topVC = UIApplication.topViewController() as? RecipeViewController else { return }
        
        if textView.text == "" {
            memoPlaceholder.isHidden = false
        } else {
            topVC.memoText.onNext(textView.text)
        }
        
        if isSaveEnabled {
            topVC.customNavigationBar.rightBtn.isEnabled = true
        }
    }
}

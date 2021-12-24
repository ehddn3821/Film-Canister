//
//  AddViewController+UI.swift
//  FilmCanister
//
//  Created by dwKang on 2021/12/24.
//

import UIKit

extension AddViewController {
    func setupUI() {
        //MARK: - Navigation Bar
        customNavigationBar.isEnablePopBtn = true
        
        customNavigationBar.addSubview(customNavigationBar.rightBtn)
        
        customNavigationBar.rightBtn.setTitle("Save", for: .normal)
        customNavigationBar.rightBtn.titleLabel?.font = UIFont(name: Constants.MAIN_FONT_BOLD, size: 16)
        customNavigationBar.rightBtn.setTitleColor(.init(named: Constants.COLOR_ENABLE), for: .normal)
        customNavigationBar.rightBtn.setTitleColor(.init(named: Constants.COLOR_DISABLE), for: .disabled)
        customNavigationBar.rightBtn.isEnabled = false
        customNavigationBar.rightBtn.snp.makeConstraints { make in
            make.size.centerY.equalTo(customNavigationBar.leftBtn)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        
        //MARK: - TableView
        bodyView.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

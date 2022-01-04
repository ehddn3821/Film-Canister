//
//  RecipeViewController+UI.swift
//  FilmCanister
//
//  Created by dwKang on 2021/12/24.
//

import UIKit

extension RecipeViewController {
    func setupUI() {
        view.backgroundColor = .systemBackground
        
        //MARK: - Navigation Bar
        customNavigationBar.isEnablePopBtn = true
        if viewType == .add {
            customNavigationBar.barTitle.text = ""
            customNavigationBar.rightBtn.setTitle("Save", for: .normal)
            customNavigationBar.rightBtn.titleLabel?.font = UIFont(name: Constants.MAIN_FONT_BOLD, size: 16)
            customNavigationBar.rightBtn.setTitleColor(.init(named: Constants.COLOR_ENABLE), for: .normal)
            customNavigationBar.rightBtn.setTitleColor(.init(named: Constants.COLOR_DISABLE), for: .disabled)
            customNavigationBar.rightBtn.isEnabled = false
        } else {
            customNavigationBar.barTitle.text = realm.object(ofType: RecipeModel.self, forPrimaryKey: recipeID)?.name
        }
        customNavigationBar.addSubview(customNavigationBar.rightBtn)
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

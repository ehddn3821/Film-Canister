//
//  MainViewController+UI.swift
//  FilmCanister
//
//  Created by dwKang on 2021/12/23.
//

import UIKit

extension MainViewController {
    
    func setupUI() {
        view.backgroundColor = .systemBackground
        
        //MARK: - Intro
        view.addSubview(introView)
        introView.backgroundColor = .systemBackground
        introView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        introView.addSubview(introLogo)
        introLogo.image = UIImage(named: "Film")
        introLogo.snp.makeConstraints { make in
            make.size.equalTo(48)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(0.9)
        }
        
        introView.addSubview(introNameLB)
        introNameLB.text = "Film canister"
        introNameLB.font = UIFont(name: Constants.MAIN_FONT_SEMIBOLD, size: 16)
        introNameLB.textColor = .init(named: Constants.COLOR_SECONDARY)
        introNameLB.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(introLogo.snp.bottom).offset(8)
        }
        
        
        //MARK: - Navigation Bar
        customNavigationBar.addSubview(customNavigationBar.leftBtn)
        customNavigationBar.addSubview(customNavigationBar.rightBtn)
        
        customNavigationBar.setTitle(title: "Recipe List")
        
        customNavigationBar.leftBtn.setImage(UIImage(named: "Hamburger"), for: .normal)
        customNavigationBar.leftBtn.snp.makeConstraints { make in
            make.size.equalTo(40)
            make.centerY.equalTo(customNavigationBar).offset(UI.SAFE_AREA_TOP/2)
            make.leading.equalToSuperview().offset(16)
        }
        
        customNavigationBar.rightBtn.setImage(UIImage(named: "Plus"), for: .normal)
        customNavigationBar.rightBtn.snp.makeConstraints { make in
            make.size.centerY.equalTo(customNavigationBar.leftBtn)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        
        //MARK: - Body
        bodyView.addSubview(tableView)
        tableView.backgroundColor = .init(named: Constants.COLOR_MAIN_BACKGROUND)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        bodyView.addSubview(filmIV)
        bodyView.addSubview(emptySimulLB)
        
        // Empty list
        filmIV.image = UIImage(named: "Film")
        filmIV.snp.makeConstraints { make in
            make.size.equalTo(48)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-14)
        }
        
        emptySimulLB.text = "There is no registered film simulation."
        emptySimulLB.textColor = .init(named: Constants.COLOR_SECONDARY)
        emptySimulLB.font = UIFont(name: Constants.MAIN_FONT_REGULAR, size: 12)
        emptySimulLB.snp.makeConstraints { make in
            make.top.equalTo(filmIV.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        
        // sidemenu open 시 dimmedView
        view.addSubview(dimmedView)
        dimmedView.backgroundColor = .init(hexColor: .dimmed)
        dimmedView.alpha = 0.0
        dimmedView.isHidden = true
        dimmedView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}


//#if DEBUG
//import SwiftUI
//@available(iOS 13, *)
//struct Preview: PreviewProvider {
//    static var previews: some View {
//        MainViewController().toPreview()
//    }
//}
//#endif

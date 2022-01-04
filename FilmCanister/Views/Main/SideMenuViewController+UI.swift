//
//  SideMenuViewController+UI.swift
//  FilmCanister
//
//  Created by dwKang on 2022/01/02.
//

import UIKit

extension SideMenuViewController {
    
    func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(settingsView)
        settingsView.addSubview(settingsLB)
        view.addSubview(iCloudLB)
        view.addSubview(iCloudSwitch)
        view.addSubview(darkModeLB)
        view.addSubview(darkModeSwitch)
        view.addSubview(aboutAsView)
        aboutAsView.addSubview(aboutAsLB)
        view.addSubview(designLB)
        view.addSubview(designerNameLB)
        view.addSubview(designInstaBtn)
        view.addSubview(devLB)
        view.addSubview(developerNameLB)
        view.addSubview(devInstaBtn)
        
        settingsView.backgroundColor = .init(named: Constants.COLOR_MAIN_BACKGROUND)
        settingsView.snp.makeConstraints { make in
            make.height.equalTo(56)
            make.bottom.equalTo(view.snp.top).offset(64 + UI.SAFE_AREA_TOP)
            make.leading.trailing.equalToSuperview()
        }
        
        settingsLB.text = "Settings"
        settingsLB.font = .init(name: Constants.MAIN_FONT_SEMIBOLD, size: 14)
        settingsLB.textColor = .init(named: Constants.COLOR_MAIN_TEXT)
        settingsLB.snp.makeConstraints { make in
            make.height.equalTo(22)
            make.leading.equalTo(16)
            make.centerY.equalToSuperview()
        }
        
        iCloudLB.text = "iCloud"
        iCloudLB.font = .init(name: Constants.MAIN_FONT_SEMIBOLD, size: 14)
        iCloudLB.textColor = .init(named: Constants.COLOR_SECONDARY)
        iCloudLB.snp.makeConstraints { make in
            make.height.equalTo(22)
            make.leading.equalTo(16)
            make.top.equalTo(settingsView.snp.bottom).offset(21)
        }
                
        iCloudSwitch.onTintColor = .init(hexColor: "#7C96F5")
        iCloudSwitch.snp.makeConstraints { make in
            make.width.equalTo(60)
            make.height.equalTo(32)
            make.top.equalTo(settingsView.snp.bottom).offset(16)
            make.trailing.equalTo(-16)
        }
        
        let divider1 = UIView()
        view.addSubview(divider1)
        divider1.backgroundColor = .init(named: Constants.COLOR_DIVIDER)
        divider1.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalTo(iCloudSwitch.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview()
        }
        
        darkModeLB.text = "Dark mode"
        darkModeLB.font = .init(name: Constants.MAIN_FONT_SEMIBOLD, size: 14)
        darkModeLB.textColor = .init(named: Constants.COLOR_SECONDARY)
        darkModeLB.snp.makeConstraints { make in
            make.height.equalTo(22)
            make.leading.equalTo(16)
            make.top.equalTo(divider1.snp.bottom).offset(21)
        }

        darkModeSwitch.onTintColor = .init(hexColor: "#7C96F5")
        darkModeSwitch.snp.makeConstraints { make in
            make.width.equalTo(60)
            make.height.equalTo(32)
            make.top.equalTo(divider1.snp.bottom).offset(16)
            make.trailing.equalTo(-16)
        }
        
        let divider2 = UIView()
        view.addSubview(divider2)
        divider2.backgroundColor = .init(named: Constants.COLOR_DIVIDER)
        divider2.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalTo(darkModeSwitch.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview()
        }
        
        aboutAsView.backgroundColor = .init(named: Constants.COLOR_MAIN_BACKGROUND)
        aboutAsView.snp.makeConstraints { make in
            make.height.equalTo(56)
            make.top.equalTo(divider2.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
        
        aboutAsLB.text = "About As"
        aboutAsLB.font = .init(name: Constants.MAIN_FONT_SEMIBOLD, size: 14)
        aboutAsLB.textColor = .init(named: Constants.COLOR_MAIN_TEXT)
        aboutAsLB.snp.makeConstraints { make in
            make.height.equalTo(22)
            make.leading.equalTo(16)
            make.centerY.equalToSuperview()
        }
        
        designLB.text = "Design by "
        designLB.font = .init(name: Constants.MAIN_FONT_REGULAR, size: 12)
        designLB.textColor = .init(named: Constants.COLOR_SECONDARY)
        designLB.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.leading.equalTo(18)
            make.top.equalTo(aboutAsView.snp.bottom).offset(16)
        }
        
        designerNameLB.text = "Roh Juyoung"
        designerNameLB.font = .init(name: Constants.MAIN_FONT_SEMIBOLD, size: 12)
        designerNameLB.textColor = .init(named: Constants.COLOR_SECONDARY)
        designerNameLB.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.leading.equalTo(designLB.snp.trailing)
            make.top.equalTo(designLB)
        }
        
        designInstaBtn.setTitle("@juyoung._.photograph", for: .normal)
        designInstaBtn.setTitleColor(.init(named: Constants.COLOR_ENABLE), for: .normal)
        designInstaBtn.titleLabel?.font = UIFont(name: Constants.MAIN_FONT_REGULAR, size: 11)
        designInstaBtn.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.leading.equalTo(18)
            make.top.equalTo(designerNameLB.snp.bottom).offset(8)
        }
        
        let divider3 = UIView()
        view.addSubview(divider3)
        divider3.backgroundColor = .init(named: Constants.COLOR_DIVIDER)
        divider3.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalTo(designInstaBtn.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview()
        }
        
        devLB.text = "Develop by "
        devLB.font = .init(name: Constants.MAIN_FONT_REGULAR, size: 12)
        devLB.textColor = .init(named: Constants.COLOR_SECONDARY)
        devLB.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.leading.equalTo(18)
            make.top.equalTo(divider3.snp.bottom).offset(16)
        }
        
        developerNameLB.text = "Kang Dongwoo"
        developerNameLB.font = .init(name: Constants.MAIN_FONT_SEMIBOLD, size: 12)
        developerNameLB.textColor = .init(named: Constants.COLOR_SECONDARY)
        developerNameLB.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.leading.equalTo(devLB.snp.trailing)
            make.top.equalTo(devLB)
        }
        
        devInstaBtn.setTitle("@pleasureofphoto", for: .normal)
        devInstaBtn.setTitleColor(.init(named: Constants.COLOR_ENABLE), for: .normal)
        devInstaBtn.titleLabel?.font = UIFont(name: Constants.MAIN_FONT_REGULAR, size: 11)
        devInstaBtn.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.leading.equalTo(18)
            make.top.equalTo(developerNameLB.snp.bottom).offset(8)
        }
        
        let divider4 = UIView()
        view.addSubview(divider4)
        divider4.backgroundColor = .init(named: Constants.COLOR_DIVIDER)
        divider4.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalTo(devInstaBtn.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview()
        }
    }
}

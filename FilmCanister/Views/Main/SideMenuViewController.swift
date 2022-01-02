//
//  SideMenuViewController.swift
//  FilmCanister
//
//  Created by dwKang on 2021/12/30.
//

import UIKit
import RxSwift

class SideMenuViewController: BaseViewController {
    let bag = DisposeBag()
    
    let settingsView = UIView()
    let settingsLB = UILabel()
    let iCloudLB = UILabel()
    let iCloudSwitch = UISwitch()
    let darkModeLB = UILabel()
    let darkModeSwitch = UISwitch()
    let aboutAsView = UIView()
    let aboutAsLB = UILabel()
    let designLB = UILabel()
    let designerNameLB = UILabel()
    let designInstaBtn = UIButton()
    let devLB = UILabel()
    let developerNameLB = UILabel()
    let devInstaBtn = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        darkModeSwitch.isOn = UserDefaults.standard.bool(forKey: "isDarkMode")
        darkModeSwitch.addTarget(self, action: #selector(onClickDarkModeSwitch(sender:)), for: .valueChanged)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let mainVC = MainViewController()
        mainVC.dimmedView.isHidden = true
    }

    
    @objc func onClickDarkModeSwitch(sender: UISwitch) {
        if sender.isOn {
            UserDefaults.standard.set(true, forKey: "isDarkMode")
            view.window?.overrideUserInterfaceStyle = .dark
        } else {
            UserDefaults.standard.set(false, forKey: "isDarkMode")
            view.window?.overrideUserInterfaceStyle = .light
        }
    }
    
    func btnActions() {
        designInstaBtn.rx.tap
            .bind { [weak self] _ in
                guard let this = self else { return }
                this.instagramAction(userName: "juyoung._.photograph")
            }.disposed(by: bag)
        
        devInstaBtn.rx.tap
            .bind { [weak self] _ in
                guard let this = self else { return }
                this.instagramAction(userName: "pleasureofphoto")
            }.disposed(by: bag)
    }
    
    // 인스타 바로가기
    private func instagramAction(userName: String) {
        let appURL = URL(string: "instagram://user?username=\(userName)")!
        let application = UIApplication.shared

        if application.canOpenURL(appURL) {
            application.open(appURL)
        } else {
            let webURL = URL(string: "https://instagram.com/\(userName)")!
            application.open(webURL)
        }
    }
}

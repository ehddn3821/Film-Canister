//
//  CustomNavigationBarViewController.swift
//  FilmCanister
//
//  Created by dwKang on 2021/12/24.
//

import UIKit

protocol NavigationBarable {
    func setNavigationBar()
}

class CustomNavigationBarViewController<T: UIView>: BaseViewController, NavigationBarable {
    let customNavigationBar = BaseNavigationBar()
    var bodyLeading = NSLayoutConstraint()
    var bodyTrailing = NSLayoutConstraint()
    let bodyView = T()
    let dividingLineView = UIView()
    
    override func viewDidLoad() {
        setNavigationBar()
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if customNavigationBar.isEnablePopBtn {
            customNavigationBar.leftBtn.addTarget(self, action: #selector(actionPop(sender:)), for: .touchUpInside)
        }
    }
    
    @objc func actionPop(sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    func setNavigationBar() {
        view.addSubview(customNavigationBar)
        view.addSubview(dividingLineView)
        view.addSubview(bodyView)
        
        customNavigationBar.backgroundColor = .systemBackground
        customNavigationBar.snp.makeConstraints { make in
            make.height.equalTo(64 + UI.SAFE_AREA_TOP)
            make.leading.top.trailing.equalToSuperview()
        }
        
        dividingLineView.backgroundColor = .init(named: Constants.COLOR_DIVIDE)
        dividingLineView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(customNavigationBar.snp.bottom)
        }
        
        bodyView.backgroundColor = .init(named: Constants.COLOR_MAIN_BACKGROUND)
        bodyView.snp.makeConstraints { make in
            make.top.equalTo(dividingLineView.snp.bottom)
            make.bottom.equalToSuperview().offset(-UI.SAFE_AREA_BOTTOM)
        }
        bodyLeading = bodyView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0)
        bodyLeading.isActive = true
        bodyTrailing = bodyView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0)
        bodyTrailing.isActive = true
        
        self.navigationController?.navigationBar.isHidden = true
    }
}

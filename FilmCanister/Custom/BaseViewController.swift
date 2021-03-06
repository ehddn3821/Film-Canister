//
//  BaseViewController.swift
//
//  Created by dwKang on 2021/12/24.
//

import UIKit
import SnapKit
import JGProgressHUD

@objc protocol BaseViewControllerCustomizable {
    @objc optional func setupUI()
    @objc optional func btnActions()
}

class BaseViewController: UIViewController {
    lazy var hud: JGProgressHUD = {
        let loader = JGProgressHUD(style: .dark)
        loader.textLabel.text = "Loading"
        loader.backgroundColor = .init(hexColor: .dimmed, alpha: 0.7)
        return loader
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func loadView() {
        super.loadView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        Log.info("\(type(of: self)): viewDidLoad")
        _setupViews()
        _setupActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Log.info("\(type(of: self)): viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Log.info("\(type(of: self)): viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Log.info("\(type(of: self)): viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        Log.info("\(type(of: self)): viewDidDisappear")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    deinit {
        Log.info("\(type(of: self)): deinit")
    }
    
    func showLoding() {
        DispatchQueue.main.async {
            self.hud.show(in: self.view, animated: true)
        }
    }
    
    func hideLoding() {
        DispatchQueue.main.async {
            self.hud.dismiss(animated: true)
        }
    }
}

extension BaseViewController: BaseViewControllerCustomizable {
    fileprivate func _setupViews() {
        (self as BaseViewControllerCustomizable).setupUI?()
    }
    fileprivate func _setupActions() {
        (self as BaseViewControllerCustomizable).btnActions?()
    }
}

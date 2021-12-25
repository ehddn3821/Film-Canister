//
//  MainViewController.swift
//  FilmCanister
//
//  Created by dwKang on 2021/12/23.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewController: CustomNavigationBarViewController<UIView> {
    let bag = DisposeBag()
    
    //MARK: - UI Propertys
    let introView = UIView()
    let introLogo = UIImageView()
    let introNameLB = UILabel()
    let filmIV = UIImageView()
    let emptySimulLB = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        hideIntro()
    }
    
    private func hideIntro() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            UIView.animate(withDuration: 0.3, animations: {
                self.introView.alpha = 0
            }) { finished in
                self.introView.isHidden = finished
            }
        }
    }
    
    func btnActions() {
        customNavigationBar.rightBtn.rx.tap
            .bind { [weak self] _ in
                guard let this = self else { return }
                this.navigationController?.pushViewController(AddViewController(), animated: true)
            }.disposed(by: bag)
    }
}


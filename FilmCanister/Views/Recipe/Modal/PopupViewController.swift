//
//  PopupViewController.swift
//  FilmCanister
//
//  Created by dwKang on 2022/01/08.
//

import UIKit
import RxSwift
import RxCocoa

class PopupViewController: BaseViewController {
    
    let bag = DisposeBag()
    let tapGesture = UITapGestureRecognizer()
    
    let dimmedView = UIView()
    let modalView = UIView()
    let titleLB = UILabel()
    let contentsLB = UILabel()
    let cancelBtn = UIButton()
    let okBtn = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setupUI() {
        
        view.addSubview(dimmedView)
        dimmedView.backgroundColor = .init(hexColor: .dimmed)
        dimmedView.alpha = 0.0
        dimmedView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(modalView)
        modalView.backgroundColor = .systemBackground
        modalView.layer.cornerRadius = 8
        modalView.snp.makeConstraints { make in
            make.height.equalTo(194)
            make.leading.equalTo(24)
            make.centerY.equalToSuperview()
            make.trailing.equalTo(-24)
        }
        
        modalView.addSubview(titleLB)
        titleLB.text = "Delete"
        titleLB.font = .init(name: Constants.MAIN_FONT_SEMIBOLD, size: 20)
        titleLB.textColor = .init(named: Constants.COLOR_MAIN_TEXT)
        titleLB.snp.makeConstraints { make in
            make.height.equalTo(32)
            make.top.equalTo(26)
            make.leading.equalTo(24)
        }
        
        modalView.addSubview(contentsLB)
        contentsLB.text = "Do you want to delete?"
        contentsLB.font = .init(name: Constants.MAIN_FONT_REGULAR, size: 16)
        contentsLB.textColor = .init(named: Constants.COLOR_MAIN_TEXT)
        contentsLB.snp.makeConstraints { make in
            make.height.equalTo(26)
            make.top.equalTo(titleLB.snp.bottom).offset(22)
            make.leading.equalTo(24)
        }
        
        modalView.addSubview(cancelBtn)
        cancelBtn.setTitleColor(.init(named: Constants.COLOR_SECONDARY), for: .normal)
        cancelBtn.titleLabel?.font = .init(name: Constants.MAIN_FONT_BOLD, size: 16)
        cancelBtn.layer.borderWidth = 2
        cancelBtn.layer.borderColor = UIColor.init(named: Constants.COLOR_SECONDARY)?.cgColor
        cancelBtn.layer.cornerRadius = 4
        cancelBtn.setTitle("Cancel", for: .normal)
        cancelBtn.snp.makeConstraints { make in
            make.width.equalTo(96)
            make.height.equalTo(40)
            make.trailing.equalTo(-132)
            make.bottom.equalTo(-24)
        }
        
        modalView.addSubview(okBtn)
        okBtn.setTitleColor(.white, for: .normal)
        okBtn.titleLabel?.font = .init(name: Constants.MAIN_FONT_BOLD, size: 16)
        okBtn.layer.cornerRadius = 4
        okBtn.backgroundColor = .init(named: Constants.COLOR_DELETE)
        okBtn.setTitle("OK", for: .normal)
        okBtn.snp.makeConstraints { make in
            make.width.equalTo(96)
            make.height.equalTo(40)
            make.trailing.equalTo(-24)
            make.bottom.equalTo(-24)
        }
        
        // dimmed view show animation
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.2, animations: {
                self.dimmedView.alpha = 0.9
            })
        }
    }
    
    func btnActions() {
        dimmedView.addGestureRecognizer(tapGesture)
        tapGesture.rx.event.bind(onNext: { [weak self] recognizer in
            guard let this = self else { return }
            this.dismissView()
        }).disposed(by: bag)
        
        cancelBtn.rx.tap
            .bind { [weak self] _ in
                guard let this = self else { return }
                this.dismissView()
            }.disposed(by: bag)
    }
    
    func dismissView() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.2, animations: {
                self.dimmedView.alpha = 0.0
                self.modalView.alpha = 0.0
            }) { finished in
                self.dismiss(animated: false, completion: nil)
            }
        }
    }
}

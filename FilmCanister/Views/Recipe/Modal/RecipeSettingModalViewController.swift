//
//  RecipeSettingModalViewController.swift
//  FilmCanister
//
//  Created by dwKang on 2021/12/25.
//

import UIKit
import RxCocoa
import RxSwift

class RecipeSettingModalViewController: BaseViewController {
    let bag = DisposeBag()
    let tapGesture = UITapGestureRecognizer()
    
    var selectedItem = PublishSubject<String>()
    var settingList: [String] = []
    
    let dimmedView = UIView()
    let modalView = UIView()
    let tableView = UITableView()
    
    
    init(settingList: [String]) {
        super.init()
        self.settingList = settingList
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RecipeSettingModalTableViewCell.classForCoder(), forCellReuseIdentifier: "modalCell")
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
        modalView.layer.cornerRadius = 16
        modalView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            if settingList.count == 3 {
                make.height.equalTo(272)
            } else if settingList.count == 4 {
                make.height.equalTo(340)
            } else if settingList.count == 2 {
                make.height.equalTo(212)
            } else {
                make.height.equalToSuperview().dividedBy(2)
            }
        }
        
        modalView.addSubview(tableView)
        tableView.separatorStyle = .none
        tableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(40)
        }
        
        // dimmed view show animation
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
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
    }
    
    private func dismissView() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.1, animations: {
                self.dimmedView.alpha = 0.0
            }) { finished in
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}

extension RecipeSettingModalViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "modalCell", for: indexPath) as! RecipeSettingModalTableViewCell
        cell.nameLB.text = settingList[indexPath.row]
        if settingList.count == 2 {
            cell.nameLB.textAlignment = .center
            if indexPath.row == 0 {
                cell.nameLB.textColor = .init(named: Constants.COLOR_ENABLE)
            } else {
                cell.nameLB.textColor = .init(named: Constants.COLOR_DELETE)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedItem.onNext(settingList[indexPath.row])
        if settingList.count == 2 {
//            if indexPath.row == 0 {
//
//            } else {
//                let alert = UIAlertController(title: "삭제하시겠습니까?", message: "", preferredStyle: .alert)
//                let okAction = UIAlertAction(title: "확인", style: .destructive) { _ in
//                    Log.info("삭제 완료")
//                }
//                let cancelAction = UIAlertAction(title: "취소", style: .cancel)
//                alert.addAction(okAction)
//                alert.addAction(cancelAction)
//                self.present(alert, animated: true, completion: nil)
//            }
        } else {
            dismissView()
        }
    }
}

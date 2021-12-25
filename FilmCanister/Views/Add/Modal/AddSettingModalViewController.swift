//
//  AddSettingModalViewController.swift
//  FilmCanister
//
//  Created by dwKang on 2021/12/25.
//

import UIKit
import RxCocoa
import RxSwift

class AddSettingModalViewController: BaseViewController {
    let bag = DisposeBag()
    let tapGesture = UITapGestureRecognizer()
    var isSelectedItem = BehaviorSubject<String>(value: "")
    
    let filmSimulationList = [ "Provia",
                               "Velvia",
                               "Astia",
                               "Classic Chrome",
                               "PRO Neg.Hi",
                               "Pro Neg. Std",
                               "Classic Neg.",
                               "Eterna",
                               "Eterna Blenach Bypass",
                               "Nostalgic Neg.",
                               "Acros STD",
                               "Acros Ye",
                               "Acros R",
                               "Acros G",
                               "Monocrhome STD",
                               "Monocrhome Ye",
                               "Monocrhome R",
                               "Monocrhome G",
                               "Sepia" ]
    
    var selectedItem = PublishSubject<String>()
    
    let dimmedView = UIView()
    let modalView = UIView()
    let tableView = UITableView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AddSettingModalTableViewCell.classForCoder(), forCellReuseIdentifier: "modalCell")
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
            make.height.equalToSuperview().dividedBy(2)
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

extension AddSettingModalViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filmSimulationList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "modalCell", for: indexPath) as! AddSettingModalTableViewCell
        cell.nameLB.text = filmSimulationList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedItem.onNext(filmSimulationList[indexPath.row])
        dismissView()
    }
}

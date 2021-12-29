//
//  MainViewController.swift
//  FilmCanister
//
//  Created by dwKang on 2021/12/23.
//

import UIKit
import RxSwift
import RxCocoa
import RealmSwift

class MainViewController: CustomNavigationBarViewController<UIView> {
    let bag = DisposeBag()
    var realm = try! Realm()
    
    //MARK: - UI Propertys
    let introView = UIView()
    let introLogo = UIImageView()
    let introNameLB = UILabel()
    
    let filmIV = UIImageView()
    let emptySimulLB = UILabel()
    
    let tableView = UITableView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        hideIntro()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(MainTableViewCell.classForCoder(), forCellReuseIdentifier: "mainCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if realm.objects(RecipeModel.self).isEmpty {
            tableView.isHidden = true
            filmIV.isHidden = false
            emptySimulLB.isHidden = false
        } else {
            tableView.isHidden = false
            filmIV.isHidden = true
            emptySimulLB.isHidden = true
            tableView.reloadData()
        }
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

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return realm.objects(RecipeModel.self).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell", for: indexPath) as! MainTableViewCell
        cell.nameLB.text = realm.objects(RecipeModel.self)[indexPath.row].name
        cell.simulNameLB.text = realm.objects(RecipeModel.self)[indexPath.row].simulName
        let imageName = realm.objects(RecipeModel.self)[indexPath.row].id
        cell.sampleIV.image = RealmImageManager.shared.loadImageFromDocumentDirectory(imageName: "\(imageName)_1")
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let recipe = realm.objects(RecipeModel.self)[indexPath.row]
            try! realm.write {
                if recipe.imageCount != 0 {
                    for i in 0..<recipe.imageCount {
                        RealmImageManager.shared.deleteImageFromDocumentDirectory(imageName: "\(recipe.id)_\(i+1).png")
                    }
                }
                Log.info("Recipe [ \(recipe.name) ] 삭제 완료")
                realm.delete(recipe)
                tableView.deleteRows(at: [indexPath], with: .fade)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self.viewWillAppear(false)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}


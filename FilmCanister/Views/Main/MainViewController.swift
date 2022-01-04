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
import SideMenu

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
    let dimmedView = UIView()
    

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
        // 사이드메뉴
        customNavigationBar.leftBtn.rx.tap
            .bind { [weak self] _ in
                guard let this = self else { return }
                let sideMenu = SideMenuNavigationController(rootViewController: SideMenuViewController())
                sideMenu.leftSide = true
                sideMenu.menuWidth = 303
                sideMenu.presentationStyle = .menuSlideIn
                sideMenu.dismissOnPresent = true
                this.present(sideMenu, animated: true)
            }.disposed(by: bag)
        
        // 시뮬레이션 추가 화면
        customNavigationBar.rightBtn.rx.tap
            .bind { [weak self] _ in
                guard let this = self else { return }
                this.navigationController?.pushViewController(RecipeViewController(viewType: .add), animated: true)
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
        cell.simulNameLB.text = realm.objects(RecipeModel.self)[indexPath.row].film_simulation
        let imageName = realm.objects(RecipeModel.self)[indexPath.row].id
        cell.sampleIV.image = RealmImageManager.shared.loadImageFromDocumentDirectory(imageName: "\(imageName)_1")
        
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        
        if indexPath.row == lastRowIndex {
            cell.divideView.isHidden = true
        } else {
            cell.divideView.isHidden = false
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let recipe = realm.objects(RecipeModel.self)[indexPath.row]
            try! realm.write {
                if recipe.image_count != 0 {
                    for i in 0..<recipe.image_count {
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipeID = realm.objects(RecipeModel.self)[indexPath.row].id
        let recipeVC = RecipeViewController(viewType: .main, recipeID: recipeID)
        navigationController?.pushViewController(recipeVC, animated: true)
    }
}


//MARK: - SideMenu delegate
extension MainViewController: SideMenuNavigationControllerDelegate {

    func sideMenuWillAppear(menu: SideMenuNavigationController, animated: Bool) {
        dimmedView.isHidden = false
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.3, animations: {
                self.dimmedView.alpha = 0.9
            })
        }
    }

    func sideMenuWillDisappear(menu: SideMenuNavigationController, animated: Bool) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.3, animations: {
                self.dimmedView.alpha = 0.0
            }) { finished in
                self.dimmedView.isHidden = true
            }
        }
    }
}


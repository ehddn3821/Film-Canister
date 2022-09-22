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
import Toast_Swift

class MainViewController: CustomNavigationBarViewController<UIView> {
    
    let bag = DisposeBag()
    var realm = try! Realm()
    
    let introView = UIView()
    let introLogo = UIImageView()
    let introNameLB = UILabel()
    let filmIV = UIImageView()
    let emptySimulLB = UILabel()
    let tableView = UITableView()
    let dimmedView = UIView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 초기 샘플 데이터 삽입
        if !UserDefaults.standard.bool(forKey: "isFirstRun") {
            for i in 0...2 {
                let id = Int(UInt64((Date().timeIntervalSince1970) * 1000))
                let recipe = RecipeModel(id: id,
                                         name: "Sample\(i+1)",
                                         film_simulation: Constants.SAMPLE_SIMUL_LIST[i],
                                         image_count: Constants.SAMPLE_IMAGE_COUNT[i],
                                         dynamic_range: "DR200",
                                         highlight: Constants.SAMPLE_HIGHLIGHT_LIST[i],
                                         shadow: Constants.SAMPLE_SHADOW_LIST[i],
                                         color: Constants.SAMPLE_COLOR_LIST[i],
                                         noise_reduction: Constants.SAMPLE_NOISE_LIST[i],
                                         sharpening: Constants.SAMPLE_SHARP_LIST[i],
                                         clarity: Constants.SAMPLE_CLARITY_LIST[i],
                                         grain_effect: Constants.SAMPLE_GRAIN_LIST[i],
                                         color_chrome_effect: Constants.SAMPLE_CHROME_LIST[i],
                                         color_chrome_effect_blue: Constants.SAMPLE_CHROME_BLUE_LIST[i],
                                         white_balance: Constants.SAMPLE_WHITE_LIST[i],
                                         red: Constants.SAMPLE_RED_LIST[i],
                                         blue: Constants.SAMPLE_BLUE_LIST[i],
                                         exposure_compensation_1: Constants.SAMPLE_EXPOSURE_1_LIST[i],
                                         exposure_compensation_2: "+1",
                                         memo: "",
                                         kValue: ""
                )
                try! realm.write {
                    for j in 0..<Constants.SAMPLE_IMAGE_COUNT[i] {
                        ImageManager.shared.saveImageToDocumentDirectory(imageName: "\(id)_\(j+1).png", image: Constants.SAMPLE_IMAGES[i][j])
                    }
                    realm.add(recipe)
                }
            }
        }
        
        hideIntro()
        
        UserDefaults.standard.set(true, forKey: "isFirstRun")
        
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
    
    //MARK: - Button Actions
    func btnActions() {
        // 사이드메뉴
        customNavigationBar.leftBtn.rx.tap
            .bind(with: self) { owner, _ in
                let sideMenu = SideMenuNavigationController(rootViewController: SideMenuViewController())
                sideMenu.leftSide = true
                sideMenu.menuWidth = 303
                sideMenu.presentationStyle = .menuSlideIn
                sideMenu.dismissOnPresent = true
                owner.present(sideMenu, animated: true)
            }.disposed(by: bag)
        
        // 시뮬레이션 추가 버튼
        customNavigationBar.rightBtn.rx.tap
            .bind(with: self) { owner, _ in
                owner.navigationController?.pushViewController(RecipeViewController(viewType: .add), animated: true)
            }.disposed(by: bag)
    }
}


//MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return realm.objects(RecipeModel.self).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell", for: indexPath) as! MainTableViewCell
        cell.nameLB.text = realm.objects(RecipeModel.self)[indexPath.row].name
        cell.simulNameLB.text = realm.objects(RecipeModel.self)[indexPath.row].film_simulation
        let imageName = realm.objects(RecipeModel.self)[indexPath.row].id
        cell.sampleIV.image = ImageManager.shared.loadImageFromDocumentDirectory(imageName: "\(imageName)_1")
        
        // 마지막 인덱스 divide line 숨기기
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
        // 스와이프 삭제
        if editingStyle == .delete {
            
            let alertVC = PopupViewController()
            alertVC.modalPresentationStyle = .overFullScreen
            
            // 삭제
            alertVC.okBtn.rx.tap
                .bind { [weak self] _ in
                    guard let this = self else { return }
                    let recipe = this.realm.objects(RecipeModel.self)[indexPath.row]
                    try! this.realm.write {
                        // 이미지 개수 체크해서 지워주기
                        if recipe.image_count != 0 {
                            for i in 0..<recipe.image_count {
                                ImageManager.shared.deleteImageFromDocumentDirectory(imageName: "\(recipe.id)_\(i+1).png")
                            }
                        }
                        Log.info("Recipe [ \(recipe.name) ] 삭제 완료")

                        this.realm.delete(recipe)
                        tableView.deleteRows(at: [indexPath], with: .fade)
                        
                        alertVC.dismissView()

                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            this.viewWillAppear(false)  // 레시피가 하나도 없는 경우 때문에

                            // Toast
                            var toastStyle = ToastStyle()
                            toastStyle.backgroundColor = .init(named: Constants.COLOR_ENABLE)!
                            toastStyle.messageColor = .white
                            toastStyle.imageSize = .init(width: 24, height: 24)
                            this.view.makeToast("Recipe has been deleted.", image: .init(named: "Check"), style: toastStyle)
                        }
                    }
                }.disposed(by: bag)
            
            present(alertVC, animated: false)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 선택한 레시피 상세 화면 이동
        let recipeID = realm.objects(RecipeModel.self)[indexPath.row].id
        let recipeVC = RecipeViewController(viewType: .main, recipeID: recipeID)
        navigationController?.pushViewController(recipeVC, animated: true)
    }
}


//MARK: - SideMenu delegate
extension MainViewController: SideMenuNavigationControllerDelegate {
    // 사이드 메뉴 상태에 따라 메인화면 dim 처리
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


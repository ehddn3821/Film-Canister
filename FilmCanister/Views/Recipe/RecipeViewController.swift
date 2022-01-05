//
//  RecipeViewController.swift
//  FilmCanister
//
//  Created by dwKang on 2021/12/24.
//

import UIKit
import RxSwift
import RxCocoa
import RealmSwift
import Toast_Swift

enum ViewType {
    case add
    case main
    case update
}

class RecipeViewController: CustomNavigationBarViewController<UIView> {
    let bag = DisposeBag()
    var realm = try! Realm()
    var recipeModel: RecipeModel!
    let headerList = ["Name", "Sample", "Setting", "Memo"]
    var viewType: ViewType = .add
    var recipeID = 0
    var nameText = BehaviorSubject<String>(value: "")
    var memoText = BehaviorSubject<String>(value: "")
    
    let tableView = UITableView()
    
    
    init(viewType: ViewType, recipeID: Int = 0) {
        super.init()
        self.viewType = viewType
        self.recipeID = recipeID
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if viewType != .add {
            recipeModel = realm.object(ofType: RecipeModel.self, forPrimaryKey: recipeID)
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RecipeHeaderTableViewCell.classForCoder(), forCellReuseIdentifier: "headerCell")
        tableView.register(RecipeNameTableViewCell.classForCoder(), forCellReuseIdentifier: "nameCell")
        tableView.register(RecipeSampleTableViewCell.classForCoder(), forCellReuseIdentifier: "sampleCell")
        tableView.register(RecipeSettingTableViewCell.classForCoder(), forCellReuseIdentifier: "settingCell")
        tableView.register(RecipeMemoTableViewCell.classForCoder(), forCellReuseIdentifier: "memoCell")
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
    }
    
    
    //MARK: - Button Actions
    func btnActions() {
        customNavigationBar.rightBtn.rx.tap
            .bind { [weak self] _ in
                guard let this = self else { return }
                if this.viewType != .main {
                    Log.info("Save Button Tap")
                    var selectedImageList: [UIImage] = []
                    if let sampleCell = this.tableView.cellForRow(at: IndexPath(row: 1, section: 1)) as? RecipeSampleTableViewCell {
                        selectedImageList = sampleCell.selectedImageList
                    }
                    let settingCell = this.tableView.cellForRow(at: IndexPath(row: 1, section: 2)) as! RecipeSettingTableViewCell
                    
                    let id = UInt64((Date().timeIntervalSince1970) * 1000)
                    
                    let recipe = RecipeModel(id: Int(id),
                                             name: try! this.nameText.value(),
                                             film_simulation: settingCell.selectedSimul,
                                             image_count: selectedImageList.count,
                                             dynamic_range: settingCell.selectedDynamic,
                                             highlight: settingCell.selectedHighlight,
                                             shadow: settingCell.selectedShadow,
                                             color: settingCell.selectedColor,
                                             noise_reduction: settingCell.selectedNoise,
                                             sharpening: settingCell.selectedSharp,
                                             clarity: settingCell.selectedClarity,
                                             grain_effect: settingCell.selectedGrain,
                                             color_chrome_effect: settingCell.selectedColorChrome,
                                             color_chrome_effect_blue: settingCell.selectedColorChromeBlue,
                                             white_balance: settingCell.selectedWhiteBalance,
                                             red: settingCell.selectedRed,
                                             blue: settingCell.selectedBlue,
                                             exposure_compensation_1: settingCell.selectedExposure1,
                                             exposure_compensation_2: settingCell.selectedExposure2,
                                             memo: try! this.memoText.value())
                    try! this.realm.write {
                        if !selectedImageList.isEmpty {
                            for i in 0..<selectedImageList.count {
                                RealmImageManager.shared.saveImageToDocumentDirectory(imageName: "\(id)_\(i+1).png", image: selectedImageList[i])
                            }
                        }
                        this.realm.add(recipe)
                        Log.info("Recipe [ \(try! this.nameText.value()) ] 추가 완료")
                    }
                    
                    this.navigationController?.popViewControllerWithHandler(animated: true, completion: {
                        let mainVC = UIApplication.topViewController() as! MainViewController
                        var toastStyle = ToastStyle()
                        toastStyle.backgroundColor = .init(named: Constants.COLOR_ENABLE)!
                        toastStyle.messageColor = .white
                        toastStyle.imageSize = .init(width: 24, height: 24)
                        mainVC.view.makeToast("Recipe has been deleted.", image: .init(named: "Check"), style: toastStyle)
                    })
                } else {
                    let moreList = ["Edit", "Delete"]
                    let modalVC = RecipeSettingModalViewController(settingList: moreList)
                    modalVC.modalPresentationStyle = .overFullScreen
                    this.present(modalVC, animated: true)
                    modalVC.selectedItem
                        .subscribe(onNext: { itemName in
                            if itemName == "Edit" {  // 수정
                                Log.info("Edit 전환")
                                modalVC.dismiss(animated: true, completion: nil)
                                this.viewType = .update
                                this.tableView.reloadData()
                            } else {  // 삭제
                                let alert = UIAlertController(title: "삭제하시겠습니까?", message: "", preferredStyle: .alert)
                                let okAction = UIAlertAction(title: "확인", style: .destructive) { _ in
                                    modalVC.dismiss(animated: true, completion: nil)
                                    guard let recipe = this.realm.object(ofType: RecipeModel.self, forPrimaryKey: this.recipeID) else { return }
                                    try! this.realm.write {
                                        if recipe.image_count != 0 {
                                            for i in 0..<recipe.image_count {
                                                RealmImageManager.shared.deleteImageFromDocumentDirectory(imageName: "\(recipe.id)_\(i+1).png")
                                            }
                                        }
                                        Log.info("Recipe [ \(recipe.name) ] 삭제 완료")
                                        this.realm.delete(recipe)
                                        this.navigationController?.popViewController(animated: true)
                                    }
                                }
                                let cancelAction = UIAlertAction(title: "취소", style: .cancel)
                                alert.addAction(okAction)
                                alert.addAction(cancelAction)
                                modalVC.present(alert, animated: true, completion: nil)
                            }
                        }).disposed(by: this.bag)
                }
                
            }.disposed(by: bag)
    }
}


//MARK: - UITableViewDelegate
extension RecipeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if viewType != .main {
            return 4
        } else {
            return 3
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "headerCell", for: indexPath) as! RecipeHeaderTableViewCell
            switch viewType {
            case .add, .update:
                if indexPath.section == 0 {
                    let imageAttachment = NSTextAttachment()
                    imageAttachment.image = UIImage(named:"Mandatory")
                    imageAttachment.bounds = CGRect(x: 0, y: -4, width: imageAttachment.image!.size.width, height: imageAttachment.image!.size.height)
                    let attachmentString = NSAttributedString(attachment: imageAttachment)
                    let completeText = NSMutableAttributedString(string: "")
                    let textAfterIcon = NSAttributedString(string: "\(headerList[0]) ")
                    completeText.append(textAfterIcon)
                    completeText.append(attachmentString)
                    cell.titleLB.attributedText = completeText
                } else {
                    cell.titleLB.text = headerList[indexPath.section]
                }
            case .main:
                cell.titleLB.text = headerList[indexPath.section + 1]
            }
            
            return cell
        case 1:
            if viewType == .add {
                switch indexPath.section {
                case 0:
                    return tableView.dequeueReusableCell(withIdentifier: "nameCell", for: indexPath) as! RecipeNameTableViewCell
                case 1:
                    let sampleCell = tableView.dequeueReusableCell(withIdentifier: "sampleCell", for: indexPath) as! RecipeSampleTableViewCell
                    sampleCell.viewType = .add
                    return sampleCell
                case 2:
                    return tableView.dequeueReusableCell(withIdentifier: "settingCell", for: indexPath) as! RecipeSettingTableViewCell
                case 3:
                    return tableView.dequeueReusableCell(withIdentifier: "memoCell", for: indexPath) as! RecipeMemoTableViewCell
                default:
                    return UITableViewCell()
                }
            } else if viewType == .main {
                switch indexPath.section {
                case 0:
                    let sampleCell = tableView.dequeueReusableCell(withIdentifier: "sampleCell", for: indexPath) as! RecipeSampleTableViewCell
                    sampleCell.viewType = viewType
                    sampleCell.recipeID = recipeID
                    sampleCell.sampleImageCount = recipeModel.image_count
                    return sampleCell
                case 1:
                    let settingCell = tableView.dequeueReusableCell(withIdentifier: "settingCell", for: indexPath) as! RecipeSettingTableViewCell
                    settingCell.viewType = viewType
                    settingCell.selectedSimul = recipeModel.film_simulation
                    settingCell.selectedDynamic = recipeModel.dynamic_range
                    settingCell.selectedHighlight = recipeModel.highlight
                    settingCell.selectedShadow = recipeModel.shadow
                    settingCell.selectedColor = recipeModel.color
                    settingCell.selectedNoise = recipeModel.noise_reduction
                    settingCell.selectedSharp = recipeModel.sharpening
                    settingCell.selectedClarity = recipeModel.clarity
                    settingCell.selectedGrain = recipeModel.grain_effect
                    settingCell.selectedColorChrome = recipeModel.color_chrome_effect
                    settingCell.selectedColorChromeBlue = recipeModel.color_chrome_effect_blue
                    settingCell.selectedWhiteBalance = recipeModel.white_balance
                    settingCell.selectedRed = recipeModel.red
                    settingCell.selectedBlue = recipeModel.blue
                    settingCell.selectedExposure1 = recipeModel.exposure_compensation_1
                    settingCell.selectedExposure2 = recipeModel.exposure_compensation_2
                    return settingCell
                case 2:
                    let memoCell = tableView.dequeueReusableCell(withIdentifier: "memoCell", for: indexPath) as! RecipeMemoTableViewCell
                    memoCell.memoPlaceholder.isHidden = true
                    memoCell.memoTextView.text = recipeModel.memo
                    memoCell.memoTextView.isEditable = false
                    return memoCell
                default:
                    return UITableViewCell()
                }
            } else {
                switch indexPath.section {
                case 0:
                    return tableView.dequeueReusableCell(withIdentifier: "nameCell", for: indexPath) as! RecipeNameTableViewCell
                case 1:
                    let sampleCell = tableView.dequeueReusableCell(withIdentifier: "sampleCell", for: indexPath) as! RecipeSampleTableViewCell
                    sampleCell.viewType = .add
                    return sampleCell
                case 2:
                    return tableView.dequeueReusableCell(withIdentifier: "settingCell", for: indexPath) as! RecipeSettingTableViewCell
                case 3:
                    return tableView.dequeueReusableCell(withIdentifier: "memoCell", for: indexPath) as! RecipeMemoTableViewCell
                default:
                    return UITableViewCell()
                }
            }
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if viewType == .main {
            if indexPath.row == 1 {
                switch indexPath.section {
                case 0:
                    return 120
                case 1:
                    return 832
                case 2:
                    return 272
                default:
                    return 120
                }
            } else {
                return 56
            }
        } else {
            if indexPath.row == 1 {
                switch indexPath.section {
                case 0:
                    return 88
                case 1:
                    return 120
                case 2:
                    return 832
                case 3:
                    return 272
                default:
                    return 88
                }
            } else {
                return 56
            }
        }
    }
}

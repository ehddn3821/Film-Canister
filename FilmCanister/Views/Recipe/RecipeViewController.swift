//
//  RecipeViewController.swift
//  FilmCanister
//
//  Created by dwKang on 2021/12/24.
//

import UIKit
import RxSwift
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
    let headerList = ["Name", "Sample", "Setting", "Memo"]
    var viewType: ViewType = .add
    var recipeID = 0
    
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
    
    func btnActions() {
        customNavigationBar.rightBtn.rx.tap
            .bind { [weak self] _ in
                guard let this = self else { return }
                let nameCell = this.tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! RecipeNameTableViewCell
                let simulCell = this.tableView.cellForRow(at: IndexPath(row: 1, section: 2)) as! RecipeSettingTableViewCell
                var selectedImageList: [UIImage] = []
                if let sampleCell = this.tableView.cellForRow(at: IndexPath(row: 1, section: 1)) as? RecipeSampleTableViewCell {
                    selectedImageList = sampleCell.selectedImageList
                }
                
                let id = UInt64((Date().timeIntervalSince1970) * 1000)
                let recipe = RecipeModel(id: Int(id),
                                         name: nameCell.nameTextField.text!,
                                         simulName: simulCell.selectedSimul,
                                         imageCount: selectedImageList.count)
                try! this.realm.write {
                    if !selectedImageList.isEmpty {
                        for i in 0..<selectedImageList.count {
                            RealmImageManager.shared.saveImageToDocumentDirectory(imageName: "\(id)_\(i+1).png", image: selectedImageList[i])
                        }
                    }
                    this.realm.add(recipe)
                    Log.info("Recipe [ \(nameCell.nameTextField.text!) ] 추가 완료")
                }
                
                this.navigationController?.popViewControllerWithHandler(animated: true, completion: {
                    let mainVC = UIApplication.topViewController() as! MainViewController
                    var toastStyle = ToastStyle()
                    toastStyle.backgroundColor = .init(named: Constants.COLOR_ENABLE)!
                    toastStyle.messageColor = .white
                    toastStyle.imageSize = .init(width: 24, height: 24)
                    mainVC.view.makeToast("Recipe has been deleted.", image: .init(named: "check"), style: toastStyle)
                })
                
            }.disposed(by: bag)
    }
}

extension RecipeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if viewType == .add {
            return headerList.count
        } else {
            return headerList.count - 1
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
            case .add:
                if indexPath.section == 0 {
                    let imageAttachment = NSTextAttachment()
                    imageAttachment.image = UIImage(named:"mandatory")
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
            case .update:
                break
            }
            
            return cell
        case 1:
            if viewType == .add {
                switch indexPath.section {
                case 0:
                    return tableView.dequeueReusableCell(withIdentifier: "nameCell", for: indexPath) as! RecipeNameTableViewCell
                case 1:
                    let sampleCell = tableView.dequeueReusableCell(withIdentifier: "sampleCell", for: indexPath) as! RecipeSampleTableViewCell
                    sampleCell.viewType = viewType
                    return sampleCell
                case 2:
                    return tableView.dequeueReusableCell(withIdentifier: "settingCell", for: indexPath) as! RecipeSettingTableViewCell
                case 3:
                    return tableView.dequeueReusableCell(withIdentifier: "memoCell", for: indexPath) as! RecipeMemoTableViewCell
                default:
                    return UITableViewCell()
                }
            } else {
                switch indexPath.section {
                case 0:
                    let sampleCell = tableView.dequeueReusableCell(withIdentifier: "sampleCell", for: indexPath) as! RecipeSampleTableViewCell
                    sampleCell.viewType = viewType
                    sampleCell.recipeID = recipeID
                    sampleCell.sampleImageCount = realm.object(ofType: RecipeModel.self, forPrimaryKey: recipeID)!.imageCount
                    return sampleCell
                case 1:
                    let settingCell = tableView.dequeueReusableCell(withIdentifier: "settingCell", for: indexPath) as! RecipeSettingTableViewCell
                    settingCell.viewType = viewType
                    settingCell.recipeID = recipeID
                    return settingCell
                case 2:
                    return tableView.dequeueReusableCell(withIdentifier: "memoCell", for: indexPath) as! RecipeMemoTableViewCell
                default:
                    return UITableViewCell()
                }
            }
            
            
        default:
            return UITableViewCell()
        }
    }
}

//
//  AddViewController.swift
//  FilmCanister
//
//  Created by dwKang on 2021/12/24.
//

import UIKit
import RxSwift
import RealmSwift

class AddViewController: CustomNavigationBarViewController<UIView> {
    let bag = DisposeBag()
    var realm = try! Realm()
    
    let headerList = ["Name", "Sample", "Setting", "Memo"]
    
    
    //MARK: - UI Propertys
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AddHeaderTableViewCell.classForCoder(), forCellReuseIdentifier: "headerCell")
        tableView.register(AddNameTableViewCell.classForCoder(), forCellReuseIdentifier: "nameCell")
        tableView.register(AddSampleTableViewCell.classForCoder(), forCellReuseIdentifier: "sampleCell")
        tableView.register(AddSettingTableViewCell.classForCoder(), forCellReuseIdentifier: "settingCell")
        tableView.register(AddMemoTableViewCell.classForCoder(), forCellReuseIdentifier: "memoCell")
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
    }
    
    func btnActions() {
        customNavigationBar.rightBtn.rx.tap
            .bind { [weak self] _ in
                guard let this = self else { return }
                let nameCell = this.tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! AddNameTableViewCell
                let simulCell = this.tableView.cellForRow(at: IndexPath(row: 1, section: 2)) as! AddSettingTableViewCell
                let id = UInt64((Date().timeIntervalSince1970) * 1000)
                let recipe = RecipeModel(id: Int(id),
                                         name: nameCell.nameTextField.text!,
                                         simulName: simulCell.selectedSimul)
                try! this.realm.write {
                    this.realm.add(recipe)
                    Log.info("Recipe [ \(nameCell.nameTextField.text!) ] 추가 완료")
                }
                this.navigationController?.popViewController(animated: true)
                
            }.disposed(by: bag)
    }
}

extension AddViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return headerList.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "headerCell", for: indexPath) as! AddHeaderTableViewCell
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
            return cell
        case 1:
            switch indexPath.section {
            case 0:
                return tableView.dequeueReusableCell(withIdentifier: "nameCell", for: indexPath) as! AddNameTableViewCell
            case 1:
                return tableView.dequeueReusableCell(withIdentifier: "sampleCell", for: indexPath) as! AddSampleTableViewCell
            case 2:
                return tableView.dequeueReusableCell(withIdentifier: "settingCell", for: indexPath) as! AddSettingTableViewCell
            case 3:
                return tableView.dequeueReusableCell(withIdentifier: "memoCell", for: indexPath) as! AddMemoTableViewCell
            default:
                return UITableViewCell()
            }
            
        default:
            return UITableViewCell()
        }
    }
}

//
//  AddViewController.swift
//  FilmCanister
//
//  Created by dwKang on 2021/12/24.
//

import UIKit

class AddViewController: CustomNavigationBarViewController<UIView> {
    let headerList = ["Title", "Sample", "Setting", "Memo"]
    
    //MARK: - UI Propertys
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AddHeaderTableViewCell.classForCoder(), forCellReuseIdentifier: "headerCell")
        tableView.register(AddTitleTableViewCell.classForCoder(), forCellReuseIdentifier: "titleCell")
        tableView.register(AddSampleTableViewCell.classForCoder(), forCellReuseIdentifier: "sampleCell")
        tableView.separatorStyle = .none
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
                return tableView.dequeueReusableCell(withIdentifier: "titleCell", for: indexPath) as! AddTitleTableViewCell
            case 1:
                return tableView.dequeueReusableCell(withIdentifier: "sampleCell", for: indexPath) as! AddSampleTableViewCell
            default:
                return UITableViewCell()
            }
            
        default:
            return UITableViewCell()
        }
    }
}

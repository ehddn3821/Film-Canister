//
//  RecipeSettingTableViewCell.swift
//  FilmCanister
//
//  Created by dwKang on 2021/12/25.
//

import UIKit
import RxSwift
import RealmSwift

class RecipeSettingTableViewCell: UITableViewCell {
    let bag = DisposeBag()
    
    var viewType: ViewType = .main
    var editChange = BehaviorSubject<Bool>(value: false)
    
    var selectedSimul = "Provia"
    var selectedDynamic = "Auto"
    var selectedHighlight = "0"
    var selectedShadow = "0"
    var selectedColor = "0"
    var selectedNoise = "0"
    var selectedSharp = "0"
    var selectedClarity = "0"
    var selectedGrain = "Off"
    var selectedColorChrome = "Off"
    var selectedColorChromeBlue = "Off"
    var selectedWhiteBalance = "Auto"
    var selectedRed = "0"
    var selectedBlue = "0"
    var selectedExposure1 = "0"
    var selectedExposure2 = "0"
    var kValue = ""
    
    
    let tableView = UITableView()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .systemBackground
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SettingTableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        tableView.register(TwoSettingTableViewCell.classForCoder(), forCellReuseIdentifier: "twoCell")
        tableView.allowsSelection = false
        tableView.isUserInteractionEnabled = true
        tableView.separatorStyle = .none
        
        contentView.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        editChange.subscribe(onNext: { isChange in
            if isChange {
                let cell = self.tableView.cellForRow(at: IndexPath(row: 10, section: 0)) as! SettingTableViewCell
                cell.whiteBalanceValueLB.isHidden = true
                cell.whiteBalanceValueTF.isHidden = false
            }
        }).disposed(by: bag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK: - UITableViewDelegate
extension RecipeSettingTableViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 13
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //MARK: - Modal 리스트 넣기
        var settingList: [String] = []
        
        switch indexPath.row {
        case 0:
            settingList = Constants.SIMULATION_LIST
        case 1:
            settingList = Constants.DYNAMIC_RANGE_LIST
        case 2:
            settingList = Constants.HIGHLIGHT_SHADOW_LIST
        case 3...5:
            settingList = Constants.COLOR_NOISE_SHARP_LIST
        case 6:
            settingList = Constants.CLARITY_LIST
        case 7:
            settingList = Constants.GRAIN_EFFECT_LIST
        case 8, 9:
            settingList = Constants.COLOR_CHROME_EFFECT_LIST
        case 10:
            settingList = Constants.WHITE_BALANCE_LIST
        case 11:
            settingList = Constants.RED_BLUE_LIST
        case 12:
            settingList = Constants.EXPOSURE_LIST
        default:
            break
        }
        
        let topVC = UIApplication.topViewController()
        
        switch indexPath.row {
        case 0, 1:  // Film Simulation, Dynamic Range
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SettingTableViewCell
            cell.iconIV.image = .init(named: Constants.SETTING_IMAGE_LIST[indexPath.row])
            cell.nameLB.text = Constants.SETTING_LIST[indexPath.row]
            
            if indexPath.row == 0 {
                cell.valueBtn.setTitle(selectedSimul, for: .normal)
            } else {
                cell.valueBtn.setTitle(selectedDynamic, for: .normal)
            }
            
            cell.valueBtn.rx.tap
                .bind { [weak self] _ in
                    guard let this = self else { return }
                    let modalVC = RecipeSettingModalViewController(settingList: settingList)
                    modalVC.modalPresentationStyle = .overFullScreen
                    topVC?.present(modalVC, animated: true)
                    modalVC.selectedItem
                        .subscribe(onNext: { itemName in
                            cell.valueBtn.setTitle(itemName, for: .normal)
                            if indexPath.row == 0 {
                                this.selectedSimul = itemName
                            } else {
                                this.selectedDynamic = itemName
                            }
                        }).disposed(by: this.bag)
                }.disposed(by: bag)
            
            return cell
        case 2:  // Highlight, Shadow
            let twoCell = tableView.dequeueReusableCell(withIdentifier: "twoCell", for: indexPath) as! TwoSettingTableViewCell
            twoCell.firstIconIV.image = .init(named: Constants.SETTING_IMAGE_LIST[2])
            twoCell.firstNameLB.text = Constants.SETTING_LIST[2]
            twoCell.secondIconIV.image = .init(named: Constants.SETTING_IMAGE_LIST[3])
            twoCell.secondNameLB.text = Constants.SETTING_LIST[3]
            twoCell.firstNameLBLeadingConstraint.isActive = true
            twoCell.secondNameLBLeadingConstraint.isActive = true
            
            twoCell.firstValueBtn.setTitle(selectedHighlight, for: .normal)
            twoCell.secondValueBtn.setTitle(selectedShadow, for: .normal)
            
            twoCell.firstValueBtn.rx.tap
                .bind { [weak self] _ in
                    guard let this = self else { return }
                    let modalVC = RecipeSettingModalViewController(settingList: settingList)
                    modalVC.modalPresentationStyle = .overFullScreen
                    topVC?.present(modalVC, animated: true)
                    modalVC.selectedItem
                        .subscribe(onNext: { itemName in
                            twoCell.firstValueBtn.setTitle(itemName, for: .normal)
                            this.selectedHighlight = itemName
                        }).disposed(by: this.bag)
                }.disposed(by: bag)
            
            twoCell.secondValueBtn.rx.tap
                .bind { [weak self] _ in
                    guard let this = self else { return }
                    let modalVC = RecipeSettingModalViewController(settingList: settingList)
                    modalVC.modalPresentationStyle = .overFullScreen
                    topVC?.present(modalVC, animated: true)
                    modalVC.selectedItem
                        .subscribe(onNext: { itemName in
                            twoCell.secondValueBtn.setTitle(itemName, for: .normal)
                            this.selectedShadow = itemName
                        }).disposed(by: this.bag)
                }.disposed(by: bag)
            
            return twoCell
        case 3...10:  // Color ~ White Balance
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SettingTableViewCell
            cell.iconIV.image = .init(named: Constants.SETTING_IMAGE_LIST[indexPath.row + 1])
            cell.nameLB.text = Constants.SETTING_LIST[indexPath.row + 1]
            
            if indexPath.row == 3 {
                cell.valueBtn.setTitle(selectedColor, for: .normal)
            } else if indexPath.row == 4 {
                cell.valueBtn.setTitle(selectedNoise, for: .normal)
            } else if indexPath.row == 5 {
                cell.valueBtn.setTitle(selectedSharp, for: .normal)
            } else if indexPath.row == 6 {
                cell.valueBtn.setTitle(selectedClarity, for: .normal)
            } else if indexPath.row == 7 {
                cell.valueBtn.setTitle(selectedGrain, for: .normal)
            } else if indexPath.row == 8 {
                cell.valueBtn.setTitle(selectedColorChrome, for: .normal)
            } else if indexPath.row == 9 {
                cell.valueBtn.setTitle(selectedColorChromeBlue, for: .normal)
            } else {
                cell.divider.isHidden = true
                cell.valueBtn.setTitle(selectedWhiteBalance, for: .normal)
                self.editChange.subscribe(onNext: { isChange in
                    if cell.valueBtn.titleLabel?.text == "K" {
                        if self.viewType == .main {
                            cell.whiteBalanceValueTF.isHidden = true
                            cell.whiteBalanceValueLB.isHidden = false
                        } else {
                            cell.whiteBalanceValueTF.isHidden = false
                            cell.whiteBalanceValueLB.isHidden = true
                        }
                        cell.whiteBalanceValueLB.text = self.kValue
                        cell.whiteBalanceValueTF.text = self.kValue
                    } else {
                        cell.whiteBalanceValueTF.isHidden = true
                        cell.whiteBalanceValueLB.isHidden = true
                    }
                }).disposed(by: self.bag)
            }
            
            cell.valueBtn.rx.tap
                .bind { [weak self] _ in
                    guard let this = self else { return }
                    let modalVC = RecipeSettingModalViewController(settingList: settingList)
                    modalVC.modalPresentationStyle = .overFullScreen
                    topVC?.present(modalVC, animated: true)
                    modalVC.selectedItem
                        .subscribe(onNext: { itemName in
                            cell.valueBtn.setTitle(itemName, for: .normal)
                            if indexPath.row == 3 {
                                this.selectedColor = itemName
                            } else if indexPath.row == 4 {
                                this.selectedNoise = itemName
                            } else if indexPath.row == 5 {
                                this.selectedSharp = itemName
                            } else if indexPath.row == 6 {
                                this.selectedClarity = itemName
                            } else if indexPath.row == 7 {
                                this.selectedGrain = itemName
                            } else if indexPath.row == 8 {
                                this.selectedColorChrome = itemName
                            } else if indexPath.row == 9 {
                                this.selectedColorChromeBlue = itemName
                            } else {
                                this.selectedWhiteBalance = itemName
                                if itemName == "K" {
                                    cell.whiteBalanceValueLB.isHidden = true
                                    cell.whiteBalanceValueTF.isHidden = false
                                } else {
                                    cell.whiteBalanceValueTF.isHidden = true
                                    cell.whiteBalanceValueLB.isHidden = true
                                }
                            }
                        }).disposed(by: this.bag)
                }.disposed(by: bag)
            
            return cell
        case 11:  // Red, Blue
            let twoCell = tableView.dequeueReusableCell(withIdentifier: "twoCell", for: indexPath) as! TwoSettingTableViewCell
            twoCell.firstNameLB.text = Constants.SETTING_LIST[12]
            twoCell.secondNameLB.text = Constants.SETTING_LIST[13]
            twoCell.firstNameLBLeadingConstraint = twoCell.firstNameLB.leadingAnchor.constraint(equalTo: twoCell.contentView.leadingAnchor, constant: 16)
            twoCell.secondNameLBLeadingConstraint = twoCell.secondNameLB.leadingAnchor.constraint(equalTo: twoCell.contentView.leadingAnchor, constant: UIScreen.main.bounds.width/2 + 16)
            twoCell.firstNameLBLeadingConstraint.isActive = true
            twoCell.secondNameLBLeadingConstraint.isActive = true
            
            twoCell.firstValueBtn.setTitle(selectedRed, for: .normal)
            twoCell.secondValueBtn.setTitle(selectedBlue, for: .normal)
            
            twoCell.firstValueBtn.rx.tap
                .bind { [weak self] _ in
                    guard let this = self else { return }
                    let modalVC = RecipeSettingModalViewController(settingList: settingList)
                    modalVC.modalPresentationStyle = .overFullScreen
                    topVC?.present(modalVC, animated: true)
                    modalVC.selectedItem
                        .subscribe(onNext: { itemName in
                            twoCell.firstValueBtn.setTitle(itemName, for: .normal)
                            this.selectedRed = itemName
                        }).disposed(by: this.bag)
                }.disposed(by: bag)
            
            twoCell.secondValueBtn.rx.tap
                .bind { [weak self] _ in
                    guard let this = self else { return }
                    let modalVC = RecipeSettingModalViewController(settingList: settingList)
                    modalVC.modalPresentationStyle = .overFullScreen
                    topVC?.present(modalVC, animated: true)
                    modalVC.selectedItem
                        .subscribe(onNext: { itemName in
                            twoCell.secondValueBtn.setTitle(itemName, for: .normal)
                            this.selectedBlue = itemName
                        }).disposed(by: this.bag)
                }.disposed(by: bag)
            
            return twoCell
        case 12:  // Exposure Compensation
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SettingTableViewCell
            cell.iconIV.image = .init(named: Constants.SETTING_IMAGE_LIST[12])
            cell.nameLB.text = Constants.SETTING_LIST[14]
            cell.exposureValueBtn.isHidden = false
            cell.toLB.isHidden = false
            cell.divider.isHidden = true
            
            cell.exposureValueBtn.setTitle(selectedExposure1, for: .normal)
            cell.valueBtn.setTitle(selectedExposure2, for: .normal)
            
            cell.exposureValueBtn.rx.tap
                .bind { [weak self] _ in
                    guard let this = self else { return }
                    let modalVC = RecipeSettingModalViewController(settingList: settingList)
                    modalVC.modalPresentationStyle = .overFullScreen
                    topVC?.present(modalVC, animated: true)
                    modalVC.selectedItem
                        .subscribe(onNext: { itemName in
                            cell.exposureValueBtn.setTitle(itemName, for: .normal)
                            this.selectedExposure1 = itemName
                        }).disposed(by: this.bag)
                }.disposed(by: bag)
            
            cell.valueBtn.rx.tap
                .bind { [weak self] _ in
                    guard let this = self else { return }
                    let modalVC = RecipeSettingModalViewController(settingList: settingList)
                    modalVC.modalPresentationStyle = .overFullScreen
                    topVC?.present(modalVC, animated: true)
                    modalVC.selectedItem
                        .subscribe(onNext: { itemName in
                            cell.valueBtn.setTitle(itemName, for: .normal)
                            this.selectedExposure2 = itemName
                        }).disposed(by: this.bag)
                }.disposed(by: bag)
            
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
}

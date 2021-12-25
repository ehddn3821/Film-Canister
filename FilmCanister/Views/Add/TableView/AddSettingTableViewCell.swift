//
//  AddSettingTableViewCell.swift
//  FilmCanister
//
//  Created by dwKang on 2021/12/25.
//

import UIKit
import RxSwift

class AddSettingTableViewCell: UITableViewCell {
    let bag = DisposeBag()
    
    let settingList = [ "Film Simulation",
                        "Dynamic Range",
                        "Highlight",
                        "Shadow",
                        "Color",
                        "Noise Reduction",
                        "Sharpening",
                        "Clarity",
                        "Grain Effect",
                        "Color Chorme Effect",
                        "Color Chorme Effect Blue",
                        "White Balance",
                        "Red",
                        "Blue",
                        "Exposure Compensation" ]
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .systemBackground
        
        let filmSimulation = makeSetting(settingList[0], imageName: "film_simulation")
        filmSimulation.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
        }
        
        let dynamicRange = makeSetting(settingList[1], imageName: "dyanamic_range")
        dynamicRange.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(filmSimulation.snp.bottom)
        }
        
        let highlight = makeSetting(settingList[2], imageName: "highlight")
        highlight.snp.makeConstraints { make in
            make.width.equalToSuperview().dividedBy(2)
            make.leading.equalToSuperview()
            make.top.equalTo(dynamicRange.snp.bottom)
        }
        
        let shadow = makeSetting(settingList[3], imageName: "shadow")
        shadow.snp.makeConstraints { make in
            make.leading.equalTo(highlight.snp.trailing)
            make.top.equalTo(highlight)
            make.trailing.equalToSuperview()
        }
        
        let color = makeSetting(settingList[4], imageName: "color")
        color.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(shadow.snp.bottom)
        }
        
        let noiseReduction = makeSetting(settingList[5], imageName: "noise_reduction")
        noiseReduction.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(color.snp.bottom)
        }
        
        let sharpening = makeSetting(settingList[6], imageName: "sharpening")
        sharpening.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(noiseReduction.snp.bottom)
        }
        
        let clarity = makeSetting(settingList[7], imageName: "clarity")
        clarity.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(sharpening.snp.bottom)
        }
        
        let grainEffect = makeSetting(settingList[8], imageName: "grain_effect")
        grainEffect.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(clarity.snp.bottom)
        }
        
        let colorChormeEffect = makeSetting(settingList[9], imageName: "color_chorme_effect")
        colorChormeEffect.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(grainEffect.snp.bottom)
        }
        
        let colorChormeEffectBlue = makeSetting(settingList[10], imageName: "color_chorme_effect_blue")
        colorChormeEffectBlue.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(colorChormeEffect.snp.bottom)
        }
        
        let whiteBalance = makeSetting(settingList[11], imageName: "white_balance", isDivider: false)
        whiteBalance.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(colorChormeEffectBlue.snp.bottom)
        }
        
        let red = makeSetting(settingList[12], isImage: false)
        red.snp.makeConstraints { make in
            make.width.equalToSuperview().dividedBy(2)
            make.leading.equalToSuperview()
            make.top.equalTo(whiteBalance.snp.bottom)
        }
        
        let blue = makeSetting(settingList[13], isImage: false)
        blue.snp.makeConstraints { make in
            make.leading.equalTo(red.snp.trailing)
            make.top.equalTo(red)
            make.trailing.equalToSuperview()
        }
        
        let exposureCompensation = makeSetting(settingList[14], imageName: "exposure_compensation", isDivider: false)
        exposureCompensation.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(blue.snp.bottom)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Make setting view
    private func makeSetting(_ name: String, imageName: String = "", isImage: Bool = true, isDivider: Bool = true) -> UIView {
        let view = UIView()
        
        if isImage {
            let iv = UIImageView()
            view.addSubview(iv)
            iv.image = UIImage(named: imageName)
            iv.snp.makeConstraints { make in
                make.size.equalTo(24)
                make.leading.equalTo(view).offset(16)
                make.centerY.equalToSuperview()
            }
            
            let lb = UILabel()
            view.addSubview(lb)
            lb.text = name
            lb.font = UIFont(name: Constants.MAIN_FONT_REGULAR, size: 12)
            lb.textColor = UIColor(named: Constants.COLOR_MAIN_TEXT)
            lb.snp.makeConstraints { make in
                make.leading.equalTo(iv.snp.trailing).offset(6)
                make.centerY.equalToSuperview()
            }
        } else {
            let lb = UILabel()
            view.addSubview(lb)
            lb.text = name
            lb.font = UIFont(name: Constants.MAIN_FONT_REGULAR, size: 12)
            lb.textColor = UIColor(named: Constants.COLOR_MAIN_TEXT)
            lb.snp.makeConstraints { make in
                make.leading.equalTo(view).offset(16)
                make.centerY.equalToSuperview()
            }
        }
        
        let valueLB = UILabel()
        view.addSubview(valueLB)
        valueLB.textColor = UIColor(named: Constants.COLOR_MAIN_TEXT)
        valueLB.font = UIFont(name: Constants.MAIN_FONT_SEMIBOLD, size: 14)
        valueLB.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16)
        }
        
        if name == settingList[0] {
            valueLB.text = "Provia"
        } else if name == settingList[1] {
            valueLB.text = "Auto"
        } else if name == settingList[2] {
            valueLB.text = "0"
        } else if name == settingList[3] {
            valueLB.text = "0"
        } else if name == settingList[4] {
            valueLB.text = "0"
        } else if name == settingList[5] {
            valueLB.text = "0"
        } else if name == settingList[6] {
            valueLB.text = "0"
        } else if name == settingList[7] {
            valueLB.text = "0"
        } else if name == settingList[8] {
            valueLB.text = "Off"
        } else if name == settingList[9] {
            valueLB.text = "Off"
        } else if name == settingList[10] {
            valueLB.text = "Off"
        } else if name == settingList[11] {
            valueLB.text = "Auto"
        } else if name == settingList[12] {
            valueLB.text = "0"
        } else if name == settingList[13] {
            valueLB.text = "0"
        } else {
            valueLB.text = "0"
            
            let toLB = UILabel()
            view.addSubview(toLB)
            toLB.textColor = UIColor(named: Constants.COLOR_MAIN_TEXT)
            toLB.font = UIFont(name: Constants.MAIN_FONT_REGULAR, size: 12)
            toLB.text = "to"
            toLB.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.trailing.equalToSuperview().offset(-65)
            }
            
            let valueLB2 = UILabel()
            view.addSubview(valueLB2)
            valueLB2.textColor = UIColor(named: Constants.COLOR_MAIN_TEXT)
            valueLB2.font = UIFont(name: Constants.MAIN_FONT_SEMIBOLD, size: 14)
            valueLB2.text = "0"
            valueLB2.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.trailing.equalTo(toLB.snp.leading).offset(-8)
            }
        }
        
        let btn = UIButton()
        view.addSubview(btn)
        btn.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        if isDivider {
            let divider = UIView()
            view.addSubview(divider)
            divider.backgroundColor = UIColor(named: Constants.COLOR_DIVIDER)
            divider.snp.makeConstraints { make in
                make.height.equalTo(1)
                make.leading.equalToSuperview().offset(16)
                make.bottom.equalToSuperview()
                make.trailing.equalToSuperview().offset(-16)
            }
        }
        
        contentView.addSubview(view)
        view.snp.makeConstraints { make in
            make.height.equalTo(64)
        }
        
        btn.rx.tap
            .bind { [weak self] _ in
                guard let this = self else { return }
                
                let topVC = UIApplication.topViewController()
                let modalVC = AddSettingModalViewController()
                modalVC.modalPresentationStyle = .overFullScreen
                
                if name == this.settingList[0] {
                    topVC?.present(modalVC, animated: true)
                    modalVC.selectedItem
                        .subscribe(onNext: { itemName in
                            valueLB.text = itemName
                    }).disposed(by: this.bag)
                } else if name == this.settingList[1] {
                } else if name == this.settingList[2] {
                } else if name == this.settingList[3] {
                } else if name == this.settingList[4] {
                } else if name == this.settingList[5] {
                } else if name == this.settingList[6] {
                } else if name == this.settingList[7] {
                } else if name == this.settingList[8] {
                } else if name == this.settingList[9] {
                } else if name == this.settingList[10] {
                } else if name == this.settingList[11] {
                } else if name == this.settingList[12] {
                } else if name == this.settingList[13] {
                } else {
                    
                }
            }.disposed(by: bag)
        
        return view
    }
}

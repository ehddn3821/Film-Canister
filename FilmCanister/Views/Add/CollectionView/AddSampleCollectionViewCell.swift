//
//  AddSampleCollectionViewCell.swift
//  FilmCanister
//
//  Created by dwKang on 2021/12/24.
//

import UIKit

class AddSampleCollectionViewCell: UICollectionViewCell {
    let addImageBtn = UIButton()
    let selectedIV = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.backgroundColor = .systemBackground
        
        contentView.addSubview(addImageBtn)
        addImageBtn.setImage(UIImage(named: "add_image"), for: .normal)
        addImageBtn.snp.makeConstraints { make in
            make.size.equalTo(88)
            make.top.equalTo(16)
            make.bottom.equalTo(-16)
        }
        
        contentView.addSubview(selectedIV)
        selectedIV.contentMode = .scaleAspectFit
        selectedIV.snp.makeConstraints { make in
            make.size.equalTo(88)
            make.top.equalTo(16)
            make.bottom.equalTo(-16)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

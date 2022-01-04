//
//  AddSampleCollectionViewCell.swift
//  FilmCanister
//
//  Created by dwKang on 2021/12/24.
//

import UIKit

class RecipeSampleCollectionViewCell: UICollectionViewCell {
    let sampleIV = UIImageView()
    let removeBtn = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.backgroundColor = .systemBackground
        
        contentView.addSubview(sampleIV)
        sampleIV.contentMode = .scaleAspectFill
        sampleIV.layer.cornerRadius = 12
        sampleIV.clipsToBounds = true
        sampleIV.image = .init(named: "AddImage")
        sampleIV.snp.makeConstraints { make in
            make.size.equalTo(88)
            make.top.equalTo(16)
            make.bottom.equalTo(-16)
        }
        
        sampleIV.addSubview(removeBtn)
        removeBtn.setImage(.init(named: "remove"), for: .normal)
        removeBtn.snp.makeConstraints { make in
            make.size.equalTo(24)
            make.top.equalTo(4)
            make.trailing.equalTo(-4)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        var view = removeBtn.hitTest(removeBtn.convert(point, from: self), with: event)
        if view == nil {
            view = super.hitTest(point, with: event)
        }
        return view
    }
}

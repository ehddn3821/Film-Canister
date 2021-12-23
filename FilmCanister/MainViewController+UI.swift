//
//  MainViewController+UI.swift
//  FilmCanister
//
//  Created by dwKang on 2021/12/23.
//

import UIKit
import SnapKit

extension MainViewController {
    
    func setupUI() {
        view.backgroundColor = .init(hexColor: .mainBackground)
        navigationItem.title = "List"
        
        view.addSubview(filmIV)
        view.addSubview(emptySimulLB)
        
        filmIV.image = UIImage(named: "film")
        filmIV.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.height.equalTo(32)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-14)
        }
        
        emptySimulLB.text = "There is no registered film simulation."
        emptySimulLB.textColor = .init(hexColor: .secondary)
        emptySimulLB.font = UIFont.systemFont(ofSize: 12)
        emptySimulLB.snp.makeConstraints { make in
            make.top.equalTo(filmIV.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
    }
}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct Preview: PreviewProvider {

    static var previews: some View {
        // view controller using programmatic UI
        MainViewController().toPreview()
    }
}
#endif

//
//  AddSampleTableViewCell.swift
//  FilmCanister
//
//  Created by dwKang on 2021/12/24.
//

import UIKit
import RxSwift

class AddSampleTableViewCell: UITableViewCell {
    let bag = DisposeBag()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return cv
    }()
    
    let photoPicker = UIImagePickerController()
    
    var selectedImageList: [UIImage] = []
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        photoPicker.delegate = self
        
        collectionView.register(AddSampleCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "cvCell")
        
        photoPicker.sourceType = .photoLibrary
        
        contentView.backgroundColor = .systemBackground
        
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.height.equalTo(120)
            make.edges.equalToSuperview()
        }
    }
}


//MARK: - Picker delegate
extension AddSampleTableViewCell: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectedImageList.append(image)
            picker.dismiss(animated: true, completion: nil)
            collectionView.reloadData()
        }
    }
}


// MARK: - CollectionView delegate
extension AddSampleTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedImageList.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cvCell", for: indexPath) as! AddSampleCollectionViewCell
        if indexPath.row == 0 {
            cell.addImageBtn.isHidden = false
            cell.selectedIV.isHidden = true
            cell.addImageBtn.rx.tap
                .bind { [weak self] _ in
                    guard let this = self else { return }
                    let topVC = UIApplication.topViewController()
                    topVC?.present(this.photoPicker, animated: true, completion: nil)
                }.disposed(by: bag)
        } else {
            if !selectedImageList.isEmpty {
                cell.selectedIV.image = selectedImageList[indexPath.row - 1]
                cell.addImageBtn.isHidden = true
                cell.selectedIV.isHidden = false
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 88, height: 120)
    }
}

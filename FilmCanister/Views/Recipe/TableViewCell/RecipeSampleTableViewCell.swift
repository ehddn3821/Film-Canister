//
//  RecipeSampleTableViewCell.swift
//  FilmCanister
//
//  Created by dwKang on 2021/12/24.
//

import UIKit
import RxSwift
import RealmSwift

class RecipeSampleTableViewCell: UITableViewCell {
    let bag = DisposeBag()
    var viewType: ViewType = .add
    var recipeID = 0
    var sampleImageCount = 0
    var isUpdateFirstCheck = false
    var realm = try! Realm()
    
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
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(RecipeSampleCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "cvCell")
        
        photoPicker.delegate = self
        photoPicker.sourceType = .photoLibrary
        
        contentView.backgroundColor = .systemBackground
        
        contentView.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.snp.makeConstraints { make in
            make.height.equalTo(120)
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK: - Picker delegate
extension RecipeSampleTableViewCell: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectedImageList.append(image)
            sampleImageCount += 1
            picker.dismiss(animated: true, completion: nil)
            collectionView.reloadData()
        }
    }
}


// MARK: - CollectionView delegate
extension RecipeSampleTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if viewType == .main {
            return sampleImageCount
        } else {
            return sampleImageCount + 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cvCell", for: indexPath) as! RecipeSampleCollectionViewCell
        switch viewType {
        case .add, .update:
            if indexPath.row == 0 {
                cell.sampleIV.image = .init(named: "AddImage")
                cell.removeBtn.isHidden = true
            } else {
                if !selectedImageList.isEmpty {
                    cell.sampleIV.image = selectedImageList[indexPath.row - 1]
                    cell.removeBtn.isHidden = false
                    cell.removeBtn.tag = indexPath.row
                    cell.removeBtn.addTarget(self, action: #selector(deleteCell(sender:)), for: .touchUpInside)
                }
            }
        case .main:
            if sampleImageCount == 0 {
                cell.sampleIV.isHidden = true
            } else {
                cell.sampleIV.image = ImageManager.shared.loadImageFromDocumentDirectory(imageName: "\(recipeID)_\(indexPath.row+1)")
            }
            cell.removeBtn.isHidden = true
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 88, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let topVC = UIApplication.topViewController()
        if viewType == .main {
            let sampleImage = ImageManager.shared.loadImageFromDocumentDirectory(imageName: "\(recipeID)_\(indexPath.row+1)")
            topVC?.navigationController?.pushViewController(DetailImageViewController(detailImg: sampleImage!), animated: true)
        } else {
            if indexPath.row == 0 {  // Sample 추가 버튼
                topVC?.present(photoPicker, animated: true, completion: nil)
            } else {  // Detail image view
                topVC?.navigationController?.pushViewController(DetailImageViewController(detailImg: selectedImageList[indexPath.row - 1]), animated: true)
            }
        }
    }
    
    @objc func deleteCell(sender: UIButton) {
        selectedImageList.remove(at: sender.tag - 1)
        sampleImageCount -= 1
        collectionView.deleteItems(at: [IndexPath(row: sender.tag, section: 0)])
    }
}

//
//  RecipeSampleTableViewCell.swift
//  FilmCanister
//
//  Created by dwKang on 2021/12/24.
//

import UIKit
import RxSwift
import RealmSwift
import Toast_Swift
import BSImagePicker
import PhotosUI
import Photos

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
    
    var selectedAssets: [PHAsset] = []
    var selectedImageList: [UIImage] = []
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(RecipeSampleCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "cvCell")
        
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


// MARK: - CollectionView delegate
extension RecipeSampleTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if viewType == .main {
            return sampleImageCount == 0 ? 1 : sampleImageCount
        } else {
            return sampleImageCount + 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cvCell", for: indexPath) as! RecipeSampleCollectionViewCell
        switch viewType {
        case .add, .update:
            if indexPath.row == 0 {
                cell.sampleIV.image = .init(named: "add_image")
                cell.removeBtn.isHidden = true
            } else {
                if !selectedImageList.isEmpty {
                    cell.sampleIV.image = selectedImageList[indexPath.row - 1]
                    cell.sampleIV.tag = indexPath.row
                    cell.removeBtn.isHidden = false
                    cell.removeBtn.tag = indexPath.row
                    cell.removeBtn.addTarget(self, action: #selector(deleteCell(sender:)), for: .touchUpInside)
                }
            }
        case .main:
            if sampleImageCount == 0 {
                cell.sampleIV.image = .init(named: "no_image")
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
        guard let topVC = UIApplication.topViewController() as? BaseViewController else { return }
        if viewType == .main {
            guard let sampleImage = ImageManager.shared.loadImageFromDocumentDirectory(imageName: "\(recipeID)_\(indexPath.row+1)") else { return }
            topVC.navigationController?.pushViewController(DetailImageViewController(detailImg: sampleImage), animated: true)
        } else {
            if indexPath.row == 0 {  // Sample 추가 버튼
                if sampleImageCount < 5 {  // 5장 제한
                    //                    topVC?.present(photoPicker, animated: true, completion: nil)
                    selectedAssets = []
                    print("sampleImageCount = \(sampleImageCount)")
                    
                    if #available(iOS 14.0, *) {
                        var configuration = PHPickerConfiguration()
                        configuration.selectionLimit = 5 - sampleImageCount
                        configuration.filter = .images
                        let picker = PHPickerViewController(configuration: configuration)
                        picker.delegate = self
                        topVC.present(picker, animated: true)
                    } else {
                        let imagePicker = ImagePickerController()
                        imagePicker.settings.selection.max = 5 - sampleImageCount
                        imagePicker.settings.fetch.assets.supportedMediaTypes = [.image]
                        let options = imagePicker.settings.fetch.album.options
                        imagePicker.settings.fetch.album.fetchResults = [
                            PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: options),
                            PHAssetCollection.fetchAssetCollections(with: .album, subtype: .albumRegular, options: options),
                        ]
                        
                        let tempSampleImageCount = sampleImageCount
                        
                        topVC.presentImagePicker(imagePicker, select: { (asset) in
                            
                            self.sampleImageCount += 1
                            print("sampleImageCount(select) = \(self.sampleImageCount)")
                            
                        }, deselect: { (asset) in
                            
                            self.sampleImageCount -= 1
                            print("sampleImageCount(deselect) = \(self.sampleImageCount)")
                            
                        }, cancel: { (assets) in
                            
                            self.sampleImageCount = tempSampleImageCount
                            
                        }, finish: { (assets) in
                            DispatchQueue.global().async {
                                let imageManager = PHImageManager.default()
                                let option = PHImageRequestOptions()
                                option.isSynchronous = true
                                option.isNetworkAccessAllowed = true
                                
                                topVC.showLoding()
                                
                                for i in 0..<assets.count {
                                    
                                    var thumbnail = UIImage()
                                    
                                    imageManager.requestImage(for: assets[i],
                                                                 targetSize: CGSize(width: assets[i].pixelWidth, height: assets[i].pixelHeight),
                                                                 contentMode: .aspectFit,
                                                                 options: option) { (result, info) in
                                        thumbnail = result!
                                    }
                                    
                                    let data = thumbnail.pngData()! as CFData
                                    let imageSource = CGImageSourceCreateWithData(data, nil)!
                                    let maxPixel = max(UIScreen.main.bounds.width, UIScreen.main.bounds.height) * UIScreen.main.scale
                                    let downSampleOptions = [ kCGImageSourceCreateThumbnailFromImageAlways: true, kCGImageSourceShouldCacheImmediately: true, kCGImageSourceCreateThumbnailWithTransform: true, kCGImageSourceThumbnailMaxPixelSize: maxPixel ] as CFDictionary
                                    let downSampledImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, downSampleOptions)!
                                    let newImage = UIImage(cgImage: downSampledImage)
                                    
                                    self.selectedImageList.append(newImage as UIImage)
                                }
                                
                                DispatchQueue.main.async {
                                    self.collectionView.reloadData()
                                    topVC.hideLoding()
                                }
                            }
                        })
                    }
                } else {
                    var toastStyle = ToastStyle()
                    toastStyle.backgroundColor = .init(named: Constants.COLOR_DELETE)!
                    toastStyle.messageColor = .white
                    toastStyle.imageSize = .init(width: 24, height: 24)
                    topVC.view.makeToast("Up to 5 pictures can be attached.", image: .init(named: "error"), style: toastStyle)
                }
            } else {  // Detail image view
                topVC.navigationController?.pushViewController(DetailImageViewController(detailImg: selectedImageList[indexPath.row - 1]), animated: true)
            }
        }
    }
    
    @objc func deleteCell(sender: UIButton) {
        print("delete sender.tag: \(sender.tag)")
        
        selectedImageList.remove(at: sender.tag - 1)
        print("delete item: \(sender.tag)")
        sampleImageCount -= 1
        self.collectionView.reloadData()
    }
}

@available(iOS 14, *)
extension RecipeSampleTableViewCell: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        for i in 0..<results.count {
            let result = results[i]
            let itemProvider = result.itemProvider
            if itemProvider.canLoadObject(ofClass: UIImage.self) {
                itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                    guard let image = image as? UIImage else { return }
                    self.selectedImageList.append(image)
                    self.sampleImageCount += 1
                    if results.count - 1 == i {
                        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
                            self.collectionView.reloadData()
                        }
                    }
                }
            }
        }
    }
}

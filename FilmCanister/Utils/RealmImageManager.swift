//
//  RealmImageManager.swift
//  FilmCanister
//
//  Created by dwKang on 2021/12/29.
//

import UIKit

class RealmImageManager {
    
    static var shared = RealmImageManager()
    
    
    //MARK: - 이미지 document에 저장
    func saveImageToDocumentDirectory(imageName: String, image: UIImage) {
        // 이미지 저장 경로 설정
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        // 이미지 파일 이름 & 최종 경로 설정
        let imageUrl = documentDirectory.appendingPathComponent(imageName)
        
        // 이미지 압축
        guard let data = image.pngData() else {
            Log.error("이미지 압축 실패")
            return
        }
        
        // 동일한 경로에 같은 이름 있으면 덮어쓰기
        if FileManager.default.fileExists(atPath: imageUrl.path) {
            do {
                try FileManager.default.removeItem(at: imageUrl)
                Log.info("이미지 덮어쓰기 - 이전 이미지 삭제 완료")
            } catch {
                Log.error("이미지 덮어쓰기 - 이전 이미지 삭제 실패")
            }
        }
        
        // 이미지 document에 저장
        do {
            try data.write(to: imageUrl)
            Log.info("이미지 저장 완료")
        } catch {
            Log.error("이미지 저장 실패")
        }
    }
    
    
    //MARK: - 이미지 document에서 불러오기
    func loadImageFromDocumentDirectory(imageName: String) -> UIImage? {
        // 폴더 경로 가져오기
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let path = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        
        // 이미지 URL 찾기
        if let directoryPath = path.first {
            let imageUrl = URL(fileURLWithPath: directoryPath).appendingPathComponent(imageName)
            return UIImage(contentsOfFile: imageUrl.path)
        }
        return nil
    }
    
    
    //MARK: - 이미지 삭제하기
    func deleteImageFromDocumentDirectory(imageName: String) {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        let imageURL = documentDirectory.appendingPathComponent(imageName)
        
        if FileManager.default.fileExists(atPath: imageURL.path) {
            do {
                try FileManager.default.removeItem(at: imageURL)
                Log.info("이미지 삭제 완료")
            } catch {
                Log.error("이미지 삭제 실패")
            }
        }
    }
}

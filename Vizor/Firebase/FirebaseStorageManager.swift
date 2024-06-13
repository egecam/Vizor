//
//  FirebaseStorageManager.swift
//  Vizor
//
//  Created by Ege Çam on 11.06.2024.
//

import Foundation
import FirebaseStorage
import UIKit

final class FirebaseStorageManager {
    static let shared = FirebaseStorageManager()
    private let storage = Storage.storage()
    
    private init() {}
    
    func uploadImage(_ image: UIImage, completion: @escaping (Result<String, Error>) -> Void) {
        let storageRef = storage.reference()
        let imagesRef = storageRef.child("images/\(UUID().uuidString).jpg")
        
        guard let imageData = image.jpegData(compressionQuality: 0.75) else {
            completion(.failure(NSError(domain: "ImageConversion", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to convert image to data."])))
            return
        }
        
        imagesRef.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            imagesRef.downloadURL { url, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let downloadURL = url?.absoluteString else {
                    completion(.failure(NSError(domain: "DownloadURL", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to get download URL."])))
                    return
                }
                
                completion(.success(downloadURL))
            }
        }
    }
}

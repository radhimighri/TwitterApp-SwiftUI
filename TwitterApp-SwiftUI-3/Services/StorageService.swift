//
//  ImageUploader.swift
//  TwitterApp-SwiftUI-3
//
//  Created by Radhi MIGHRI on 09/02/2022.
//

import Firebase
import UIKit


struct ImageUploader {
    
    static func uploadImage(image: UIImage, completion: @escaping(String) -> Void) {
        
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {return}
        
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_images/\(filename)")
        
//        ref.putData(imageData, metadata: nil) { _, err in
//            if let e = err {
//                print("DEBUG: Failed to upload with error: \(e.localizedDescription)")
//                return
//            }
//
//            ref.downloadURL { imageUrl, _ in
//                guard let imageURL = imageUrl?.absoluteString else {return}
//                completion(imageURL)
//            }
//        }
        
        ref.putData(imageData, metadata: nil) { _, error in
            if let error = error {
                debugPrint("DEBUG: Failed to upload with error: \(error)")
                return
            }
            
            ref.downloadURL { imageUrl, _ in
                guard let imageURL = imageUrl?.absoluteString else {return}
                completion(imageURL)
            }
            
        }
        
    }
}

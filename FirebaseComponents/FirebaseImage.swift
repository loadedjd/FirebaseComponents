//
//  FirebaseImage.swift
//  FirebaseComponents
//
//  Created by Jared Williams on 4/14/18.
//  Copyright © 2018 Jared Williams. All rights reserved.
//

import Foundation
import FirebaseStorage



open class FirebaseImage : FirebaseStandard {
    internal static func uploadImage(to child: String, image: UIImage, compression: CompressionLevel, completion: ((Error?)->())?) {
        
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"
        
        if let compressedData = UIImageJPEGRepresentation(image, compression.rawValue) {
                
            uploadArbitraryDataToStorage(child: child, data: compressedData, metaData: metaData) { (error: Error?) in
                completion?(error)
            }
        }
    }
    
    internal static func getImage(from child: String, memorySize: MemoryAllocationLevel, completion: @escaping (UIImage)->()) {
        getArbitraryDataFromStorage(child: child, maximumMemory: memorySize) { (data: Data?, error: Error?) in
            if error == nil {
                if let unwrappedData = data {
                    if let image = UIImage(data: unwrappedData) {
                        completion(image)
                    }
                }
            }
        }
    }
}

//
//  FirebaseComponentsStandard.swift
//  FirebaseComponents
//
//  Created by Jared Williams on 4/13/18.
//  Copyright © 2018 Jared Williams. All rights reserved.
//

import Foundation
import Firebase
import FirebaseStorage



public typealias RealtimeDatabaseData = [String:Any]

public enum CompressionLevel : CGFloat {
    case High = 0.1
    case Medium = 0.5
    case Low = 1.0
}

public enum MemoryAllocationLevel: Int64 {
    case Low = 5120 // 5KB
    case medium = 1048576 // 1 MB
    case High = 5242880 // 5 MB
}



open class FirebaseStandard {
    
    
    internal static var DATABASE_REFERENCE = Database.database().reference()
    internal static var STORAGE_REFERENCE = Storage.storage().reference()
    
    
    internal static func uploadArbitraryDataToRealTimeDatabase(at child: String, data: Any, autoId: Bool, completion: ((Error?)->())?) {
        
        let localPath = DATABASE_REFERENCE.child(child)
        
        if autoId {
            localPath.childByAutoId().setValue(data) { (error: Error?, _) in
                completion?(error)
            }
        } else {
            localPath.setValue(data) { (error: Error?, _) in
                completion?(error)
            }
        }
        
    }
    
    internal static func getArbitraryDataFromRealtimeDatabase(child: String, completion: @escaping (Any?)->()) {
        
        DATABASE_REFERENCE.child(child).observeSingleEvent(of: .value) { (snapshot: DataSnapshot) in
            completion(snapshot.value)
        }
        
    }
    
    internal static func updateArbitraryDataToRealTimeDatabase(to child: String, data: [AnyHashable : Any], completion: ((Error?)->())?) {
        DATABASE_REFERENCE.child(child).updateChildValues(data) { (error: Error?, _) in
            completion?(error)
        }
    }
    
    internal static func uploadArbitraryDataToStorage(child: String, data: Data, metaData: StorageMetadata, completion: ((Error?)->())?) {
        STORAGE_REFERENCE.child(child).putData(data, metadata: metaData) { (_, error: Error?) in
            completion?(error)
        }
    }
    
    internal static func getArbitraryDataFromStorage(child: String, maximumMemory: MemoryAllocationLevel, completion: @escaping (Data?, Error?)->()) {
        STORAGE_REFERENCE.child(child).getData(maxSize: maximumMemory.rawValue) { (data: Data?, error: Error?) in // This is downloading into memory so we really dont want large amounts of data here, if larger than, say 15 MB, writeToFile should be used
            completion(data, error)
        }
    }
    
    internal static func subscribeToContinuousArbitraryRealtimeDatabaseEventWithData(child: String, event: DataEventType, completion: @escaping (Any?)->()) {
        DATABASE_REFERENCE.child(child).observe(event) { (snapshot: DataSnapshot) in
            completion(snapshot.value)
        }
    }
    
    internal static func subscribeToSingleArbitraryRealtimeDatabaseEventWithData(child: String, event: DataEventType, completion: @escaping (Any?)->()) {
        DATABASE_REFERENCE.child(child).observeSingleEvent(of: event) { (snapshot: DataSnapshot) in
            completion(snapshot.value)
        }
    }
    
    
    
}

//
//  FirebaseData.swift
//  FirebaseComponents
//
//  Created by Jared Williams on 4/14/18.
//  Copyright © 2018 Jared Williams. All rights reserved.
//

import Foundation
import Firebase


open class FirebaseData : FirebaseStandard {
    
    
    
    static func uploadToDatabaseWithAutoId(to child: String, dictionary data: RealtimeDatabaseData, completion: ((Error?)->())?) {
        uploadArbitraryDataToRealTimeDatabase(at: child, data: data, autoId: true) { (error: Error?) in
            completion?(error)
        }
    }
    
    static func uploadToDatabase(to child: String, dictionary data: RealtimeDatabaseData, completion: ((Error?)->())?) {
        uploadArbitraryDataToRealTimeDatabase(at: child, data: data, autoId: false) { (error: Error?) in
            completion?(error)
        }
    }
    
    static func listenOnce(at child: String, event: DataEventType, completion: @escaping (Any?)->()) {
        subscribeToSingleArbitraryRealtimeDatabaseEventWithData(child: child, event: event) { (data: Any?) in
            completion(data)
        }
    }
    
    static func listen(at child: String, event: DataEventType, completion: @escaping (Any?)->()) {
        subscribeToContinuousArbitraryRealtimeDatabaseEventWithData(child: child, event: event) { (data: Any?) in
            completion(data)
        }
    }
    
    
}

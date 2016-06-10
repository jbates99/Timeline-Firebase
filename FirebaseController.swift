//
//  FirebaseController.swift
//  Timeline
//
//  Created by Joshua Bates on 6/9/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation
import Firebase

class FirebaseController {
    
    static let base = FIRDatabase.database().reference()
    
    static func dataAtEndpoint(endpoint: String, completion: (data: AnyObject?) -> Void) {
        let baseForEndpoint = FirebaseController.base.child(endpoint)
        baseForEndpoint.observeSingleEventOfType(.Value, withBlock: { snapshot in
            if snapshot.value is NSNull {
                completion(data: nil)
            } else {
                completion(data: snapshot.value)
            }
        })
    }
    
    static func observeDataAtEndpoint(endpoint: String, completion: (data: AnyObject?) -> Void) {
        let baseForEndpoint = FirebaseController.base.child(endpoint)
        baseForEndpoint.observeEventType(.Value, withBlock: { snapshot in
            if snapshot.value is NSNull {
                completion(data: nil)
            } else {
                completion(data: snapshot.value)
            }
        })
        
    }
}

protocol FirebaseType {
    var identifier: String? { get set }
    var endpoint: String { get }
    var jsonValue: [String: AnyObject] { get }
    
    init?(json: [String : AnyObject], identifier: String)
    
    mutating func save()
    func delete()
}

extension FirebaseType {
    mutating func save() {
        var endpointBase = FirebaseController.base
        
        if let identifier = self.identifier {
            endpointBase = FirebaseController.base.child(endpoint).child(identifier)
        } else {
            endpointBase = FirebaseController.base.child(endpoint).childByAutoId()
            self.identifier = endpointBase.key
        }
        endpointBase.updateChildValues(self.jsonValue)
    }
    
    func delete() {
        if let identifier = self.identifier {
            let endpointBase = FirebaseController.base.child(endpoint).child(identifier)
            endpointBase.removeValue()
        }
    }
}

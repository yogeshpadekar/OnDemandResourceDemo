//
//  ResourceRequestManager.swift
//  Prasthana
//
//  Created by Yogesh Padekar on 15/08/20.
//  Copyright © 2020 Padekar. All rights reserved.
//

import Foundation

class ResourceRequestManager {
    static let shared = ResourceRequestManager()
    var request: NSBundleResourceRequest?
    
    /// Helper function to download on demand resources
    /// - Parameters:
    ///   - tag: Resource tag String
    ///   - onSuccess: Success completion handler
    ///   - onFailure: Failure completion handler
    func requestResourceWith(tag: String,
                             onSuccess: @escaping () -> Void,
                             onFailure: @escaping (NSError) -> Void) {
        request = NSBundleResourceRequest(tags: [tag])
        
        guard let request = request else {
            return
        }
        // purge the resources associated with the current request
        request.endAccessingResources()
        request.loadingPriority = NSBundleResourceRequestLoadingPriorityUrgent
        request.beginAccessingResources { (error: Error?) in
            
            if let error = error {
                onFailure(error as NSError)
                return
            }
            onSuccess()
        }
    }
}

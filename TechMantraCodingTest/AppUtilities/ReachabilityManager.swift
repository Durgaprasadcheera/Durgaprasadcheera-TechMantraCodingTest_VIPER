//
//  ReachabilityManager.swift
//  GitHubUserSearch
//
//  Created by Durga Cheera on 18/09/22.
//

import Foundation
import Reachability

@objc class ReachabilityManager: NSObject {
    
    @objc static let shared = ReachabilityManager()
    
    let reachability = try! Reachability()
    
    @objc func isReachable() -> Bool{
        return reachability.connection != .unavailable ? true : false
    }
}

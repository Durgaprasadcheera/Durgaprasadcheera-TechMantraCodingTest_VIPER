//
//  GitHubUserDetailsProtocols.swift
//  PopularGitHubUsers
//
//  Created by Durga Cheera on 13/02/23.

//

import Foundation
import UIKit

protocol ViewToPresenterDetailsProtocol: class{
    
    var view: PresenterToViewDetailsProtocol? {get set}
    var interactor: PresenterToInteractorDetailsProtocol? {get set}
    var router: PresenterToRouterDetailsProtocol? {get set}
}

protocol PresenterToViewDetailsProtocol: class{
    func showGitHubUserDetails(gitHubUser: User)
}

@objc protocol PresenterToRouterDetailsProtocol: class {
    @objc static func createModule(with user: User)-> UIViewController
}

protocol PresenterToInteractorDetailsProtocol: class {
    var presenter:InteractorToPresenterDetailsProtocol? {get set}
}

protocol InteractorToPresenterDetailsProtocol: class {
}

//
//  GitHubUserDetailsPresenter.swift
//  PopularGitHubUsers
//
//  Created by Durga Cheera on 13/02/23.
//

import Foundation
import UIKit

class GitHubUserDetailsPresenter:ViewToPresenterDetailsProtocol {
    
    var view: PresenterToViewDetailsProtocol?
    
    var interactor: PresenterToInteractorDetailsProtocol?
    
    var router: PresenterToRouterDetailsProtocol?
    

}

extension GitHubUserDetailsPresenter: InteractorToPresenterDetailsProtocol{
}

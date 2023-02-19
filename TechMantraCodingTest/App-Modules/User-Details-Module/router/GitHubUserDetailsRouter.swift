//
//  GitHubUserDetailsRouter.swift
//  PopularGitHubUsers
//
//  Created by Durga Cheera on 13/02/23.

//

import Foundation
import UIKit

@objc class GitHubUserDetailsRouter: NSObject, PresenterToRouterDetailsProtocol{
    
    @objc static func createModule(with user: User) -> UIViewController {
        
        let view = mainstoryboard.instantiateViewController(withIdentifier: GITHUBUSER_DETAILS_VIEWCONTROLLER_STORYBOARD_ID) as! GitHubUserDetailsViewController
        
        let presenter: ViewToPresenterDetailsProtocol & InteractorToPresenterDetailsProtocol = GitHubUserDetailsPresenter()
        let interactor: PresenterToInteractorDetailsProtocol = GitHubUserDetailsInteractor()
        let router:PresenterToRouterDetailsProtocol = GitHubUserDetailsRouter()
        
        view.presentor = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        view.activeUser = user
        return view
        
    }
    
    static var mainstoryboard: UIStoryboard{
        return UIStoryboard(name:MAIN_STORYBOARD_NAME,bundle: Bundle.main)
    }
    
}

//
//  GitHubUsersListRouter.m
//  TechMantraCodingTest
//
//  Created by Durga Cheera on 17/02/23.
//

#import "GitHubUsersListRouter.h"

@class GitHubUserDetailsRouter;

@implementation GitHubUsersListRouter

+ (GitHubUsersListViewController *)createModule {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName: @"Main" bundle: [NSBundle mainBundle]];
    GitHubUsersListViewController *viewController = [storyboard instantiateViewControllerWithIdentifier: @"GitHubUsersListViewController"];
    id<ViewToPresenterProtocol> presenter = [GitHubUsersListPresenter new];
    id<PresenterToInteractorProtocol> interactor = [GitHubUsersListInteractor new];
    id<PresenterToRouterProtocol> router = [GitHubUsersListRouter new];
    
    viewController.presenter = presenter;
    presenter.view = viewController;
    presenter.interactor = interactor;
    presenter.router = router;
    interactor.presenter = presenter;
    return viewController;
}

- (void)pushToGitHubUserDetailsScreen:(UINavigationController *)navigationController selectedUser:(User *)selectedGitHubUser {
//    UIViewController *viewController = [GitHubUserDetailsRouter createModule];
//    [navigationController pushViewController: viewController animated: true];
}
@end

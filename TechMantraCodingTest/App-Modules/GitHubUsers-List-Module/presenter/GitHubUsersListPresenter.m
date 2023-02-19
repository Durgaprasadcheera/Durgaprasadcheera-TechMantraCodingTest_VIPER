//
//  GitHubUsersListPresenter.m
//  TechMantraCodingTest
//
//  Created by Durga Cheera on 16/02/23.
//

#import "GitHubUsersListPresenter.h"

@implementation GitHubUsersListPresenter

@synthesize view;// = _view;
@synthesize interactor = _interactor;
@synthesize router = _router;

#pragma ViewToPresenterProtocol Methods
- (void)startFetchingGitHubUsersListWith:(NSString *)userName {
    [self.interactor fetchGitHubUsersListWith: userName];
}

- (void)showGitHubUserDetailsController:(UINavigationController *)navigationController selecteduser:(User *)selectedGitHubUser {
    [self.router pushToGitHubUserDetailsScreen: navigationController selectedUser: selectedGitHubUser];
}

- (void)gitHubUsersListFetchedSuccess:(User *)gitHubUser {
    [self.view showGitHubUser: gitHubUser];
}

- (void)gitHubUsersListFetchFailed {
    [self.view showError];
}
@end

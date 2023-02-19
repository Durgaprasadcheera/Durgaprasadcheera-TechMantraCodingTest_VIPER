//
//  GitHubUsersListRouter.h
//  TechMantraCodingTest
//
//  Created by Durga Cheera on 17/02/23.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "GitHubUsersListViewController.h"
#import "GitHubUsersListPresenter.h"
#import "GitHubUsersListInteractor.h"

@class User, GitHubUsersListViewController, GitHubUserDetailsRouter;


NS_ASSUME_NONNULL_BEGIN

@protocol PresenterToRouterProtocol <NSObject>

+ (GitHubUsersListViewController *) createModule;
- (void) pushToGitHubUserDetailsScreen: (UINavigationController *)navigationController selectedUser: (User *)selectedGitHubUser;

@end

@interface GitHubUsersListRouter : NSObject <PresenterToRouterProtocol>

@end

NS_ASSUME_NONNULL_END

//
//  GitHubUsersListPresenter.h
//  TechMantraCodingTest
//
//  Created by Durga Cheera on 16/02/23.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "GitHubUsersListViewController.h"
#import "GitHubUsersListRouter.h"
#import "GitHubUsersListInteractor.h"

@protocol PresenterToViewProtocol;
@protocol PresenterToRouterProtocol;
@class User, GitHubUsersListViewController;

NS_ASSUME_NONNULL_BEGIN


@protocol ViewToPresenterProtocol <NSObject>

@property (strong, nonatomic) id<PresenterToViewProtocol> view;
@property (strong, nonatomic) id<PresenterToInteractorProtocol> interactor;
@property (strong, nonatomic) id<PresenterToRouterProtocol> router;

- (void)startFetchingGitHubUsersListWith: (NSString *)userName;
- (void)showGitHubUserDetailsController: (UINavigationController *)navigationController selecteduser: (User *)selectedGitHubUser;

@end

@interface GitHubUsersListPresenter : NSObject <ViewToPresenterProtocol, InteractorToPresenterProtocol>

@end

NS_ASSUME_NONNULL_END

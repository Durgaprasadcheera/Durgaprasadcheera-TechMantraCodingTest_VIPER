//
//  GitHubUsersListViewController.h
//  TechMantraCodingTest
//
//  Created by Durga Cheera on 13/02/23.
//

#import <UIKit/UIKit.h>
#import "GitHubUsersListPresenter.h"
@class UserDisplayTableViewCell;


@protocol ViewToPresenterProtocol;
@class User, UserDisplayTableViewCell;



NS_ASSUME_NONNULL_BEGIN

@protocol PresenterToViewProtocol <NSObject>

- (void) showGitHubUser: (User *)user;
- (void) showError;

@end

@interface GitHubUsersListViewController : UIViewController <PresenterToViewProtocol>

@property (strong, nonatomic) id<ViewToPresenterProtocol> presenter;

@end

NS_ASSUME_NONNULL_END

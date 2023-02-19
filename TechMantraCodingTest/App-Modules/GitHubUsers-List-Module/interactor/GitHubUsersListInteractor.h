//
//  GitHubUsersListInteractor.h
//  TechMantraCodingTest
//
//  Created by Durga Cheera on 17/02/23.
//

#import <Foundation/Foundation.h>

@protocol PresenterToInteractorProtocol, InteractorToPresenterProtocol;
@class User;

NS_ASSUME_NONNULL_BEGIN

@protocol InteractorToPresenterProtocol <NSObject>

- (void) gitHubUsersListFetchedSuccess: (User *)gitHubUser;
- (void) gitHubUsersListFetchFailed;

@end

@protocol PresenterToInteractorProtocol <NSObject>

@property (strong, nonatomic) id<InteractorToPresenterProtocol> presenter;
- (void) fetchGitHubUsersListWith: (NSString *)userName;

@end

@interface GitHubUsersListInteractor: NSObject <PresenterToInteractorProtocol>

@end

NS_ASSUME_NONNULL_END

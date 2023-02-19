//
//  GitHubUsersListInteractor.m
//  TechMantraCodingTest
//
//  Created by Durga Cheera on 17/02/23.
//

#import "GitHubUsersListInteractor.h"
#import "TechMantraCodingTest-Swift.h"

@implementation GitHubUsersListInteractor

@synthesize presenter;

- (void)fetchGitHubUsersListWith:(NSString *)userName {
    NSString *url = [[NSString alloc] initWithFormat: @"https://api.github.com/users/%@", userName];
    [self fetchGitHubUsersListFrom: url  completion:^(User * _Nullable user, NSError * _Nullable error) {
        if (error != nil) {
            [self.presenter gitHubUsersListFetchFailed];
        } else {
            [self.presenter gitHubUsersListFetchedSuccess: user];
        }
    }];
}

- (void)fetchGitHubUsersListFrom: (NSString *)url completion: (void(^)(User *user, NSError *error))onCompletion {
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];

    //create the Method "GET"
    [urlRequest setHTTPMethod:@"GET"];

    NSURLSession *session = [NSURLSession sharedSession];

    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
      NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
      if(httpResponse.statusCode == 200)
      {
        
        NSError *parseError = nil;
        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
        NSLog(@"The response is - %@",responseDictionary);
         
          dispatch_async(dispatch_get_main_queue(), ^{
              CoreDataUserManager *coredataManager = [CoreDataUserManager shared];
              [[CoreDataUserManager shared] saveUserToLocalDBWithUserDict:responseDictionary isFollower:false completion:^(User * _Nullable user) {
                  onCompletion(user, nil);
              }];
          });
          /* if let userDict = response as? [String: Any] {
              DispatchQueue.main.async {
                  CoreDataUserManager.shared.saveUserToLocalDB(userDict: userDict, isFollower: false, completion: { (user) in
                      completion(nil, user)
                  })
              }
          }
              */
      }
      else
      {
        NSLog(@"Error while fetching data: %@", error.localizedDescription);
          onCompletion(nil, error.localizedDescription);
      }
    }];
    [dataTask resume];
}


//func fetchGitHubUsersList(from url: String, completionHandler: @escaping (_ user: User?, _ error: Error?) -> ()) {
//    Alamofire.request(url).responseData{ (response:DataResponse<Data>) in
//
//        switch(response.result) {
//        case let .success(data):
//            do {
//                let resultData = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
//                print(resultData)
//
//                if let userDict = resultData as? [String: Any] {
//                    DispatchQueue.main.async {
//                        CoreDataUserManager.shared.saveUserToLocalDB(userDict: userDict, isFollower: false, completion: { (user) in
//                            completionHandler(user, nil)
//                        })
//                    }
//                }
//                // Decoding the JSON response to codable structure
//                /*
//                let jsonDecoder = JSONDecoder()
//                let gitHubUsersListResponse = try jsonDecoder.decode(GitHubUsersListModel.self, from: data)
//                if let gitHubUsersData = gitHubUsersListResponse.results {
//                    completionHandler(gitHubUsersData, nil)
//                }
//                */
//
//            } catch let error {
//                print(error)
//                completionHandler(nil, error)
//            }
//            break
//
//        case .failure(_):
//            print(response.result.error.debugDescription)
//            completionHandler(nil, response.result.error)
//        }
//
//    }
//}


@end

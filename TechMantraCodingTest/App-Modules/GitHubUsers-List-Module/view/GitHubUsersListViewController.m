//
//  GitHubUsersListViewController.m
//  TechMantraCodingTest
//
//  Created by Durga Cheera on 13/02/23.
//

#import "GitHubUsersListViewController.h"
#import "TechMantraCodingTest-Swift.h"



@interface GitHubUsersListViewController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *searchResultsTableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *showHistoryButton;
@property (strong, nonatomic) User *activeUser;
@property (strong, nonatomic) NSArray<User *> *cachedUsers;
@property (strong, nonatomic) NSArray<User *> *filteredUsers;
@property (assign, nonatomic) BOOL showHistoryData;

@end

@implementation GitHubUsersListViewController

@synthesize presenter = _presenter;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.showHistoryButton setTitle: @"Show History"];
}

- (void)showGitHubUser:(User *)user {
    self.activeUser = user;
    [_searchResultsTableView reloadData];
}

- (void)showError {
    [self showAlertWith:@"Error while fetching the data!"];
}

- (IBAction)showHistoryButtonClicked: (UIBarButtonItem *)sender {
    [self.searchBar setText: nil];
    self.activeUser = nil;
    
    if (self.showHistoryData == false) {
        self.showHistoryData = true;
        [self getCachedUsersFromDB];
        [self.searchResultsTableView setSeparatorStyle: UITableViewCellSeparatorStyleSingleLine];
        [self.showHistoryButton setTitle: @"Hide searches"];
    } else {
        self.showHistoryData = false;
        [self.searchResultsTableView setSeparatorStyle: UITableViewCellSeparatorStyleNone];
        [self.showHistoryButton setTitle: @"Recent searches"];
    }
    [self.searchResultsTableView reloadData];
}

- (void)getCachedUsersFromDB {
    if (self.showHistoryData == YES) {
        self.cachedUsers = [[CoreDataUserManager shared] getAllUsersFromDB];
        self.filteredUsers = self.cachedUsers;
        [self.searchResultsTableView reloadData];
    }
}

- (void)fetchUserDetailsFromGitHub: (NSString *)text {
    [self.presenter startFetchingGitHubUsersListWith: text];
}

- (void)showAlertWith: (NSString *)message {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle: @"GitHub" message: message preferredStyle: UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle: @"OK" style: UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //
    }];
    [alertController addAction: okAction];
    [self presentViewController: alertController animated: true completion: nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSUInteger num = (self.showHistoryData == true) ? [self.filteredUsers count] : (self.activeUser != nil) ? 1 : 0;
    if (num == 0) {
        CGSize size = [tableView bounds].size;
        UILabel *noDataLabel = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, size.width, size.height)];
        
        if (self.searchBar.text.length > 0) {
            noDataLabel.text = @"No results found with the searched username!!";
            noDataLabel.textColor = [UIColor redColor];
        } else {
            noDataLabel.text = @"Search with an username to see the results";
            noDataLabel.textColor     = [UIColor blackColor];
        }
        noDataLabel.font          = [UIFont systemFontOfSize: 20];
        noDataLabel.textAlignment = NSTextAlignmentCenter;
        noDataLabel.numberOfLines = 0;
        tableView.backgroundView  = noDataLabel;
        tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
        return 0;
    }
    
    tableView.backgroundView  = nil;
    return num;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UserDisplayTableViewCell *cell = (UserDisplayTableViewCell *)[tableView dequeueReusableCellWithIdentifier: @"searchResultsUserCell" forIndexPath:indexPath];
    
    if (cell == nil) {
        return [UITableViewCell new];
    } else {
        if (self.showHistoryData == true) {
            [cell setUpUserCellWithUser:[_filteredUsers objectAtIndex:indexPath.row]];
        } else {
            [cell setUpUserCellWithUser:_activeUser];
        }
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.showHistoryData == true) {
        self.activeUser = self.filteredUsers[indexPath.row];
    }
    [self performSegueWithIdentifier:@"toUserDetailsScreen" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier  isEqual: @"toUserDetailsScreen"]) {
        GitHubUserDetailsViewController *detailsView = (GitHubUserDetailsViewController *)segue.destinationViewController;
        detailsView.activeUser = self.activeUser;
    }
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSString *trimmedText = [searchBar.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (trimmedText.length > 0 && self.showHistoryData == false) {
        [self fetchUserDetailsFromGitHub: trimmedText];
    }
    [searchBar resignFirstResponder];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSString *trimmedText = [[searchBar.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]] lowercaseString];
    if (trimmedText.length > 0 && self.showHistoryData == false) {
        //
    } else {
        self.filteredUsers = self.cachedUsers;
    }
    [self.searchResultsTableView reloadData];
}

@end

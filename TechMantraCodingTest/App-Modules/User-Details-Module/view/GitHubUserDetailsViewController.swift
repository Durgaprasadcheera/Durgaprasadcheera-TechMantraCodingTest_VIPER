//
//  GitHubUserDetailsViewController.swift
//  PopularGitHubUsers
//
//  Created by Durga Cheera on 13/02/23.

//

import UIKit

class GitHubUserDetailsViewController: UIViewController {
    
    @IBOutlet var userDetailsTableView: UITableView!
    
    var presentor:ViewToPresenterDetailsProtocol?
    
    @objc var activeUser: User?
    var isFollowersShown: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = (activeUser?.login ?? "User") + "'s details"
        
    }
}

// MARK:- UITableViewDataSource, UITableViewDelegate
extension GitHubUserDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activeUser != nil ? 1 : 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = userDetailsTableView.dequeueReusableCell(withIdentifier: "UserDisplayTableViewCell", for: indexPath) as? UserDisplayTableViewCell else {
            fatalError("AddAttendeeTableViewCell not found.")
        }
        cell.setUpUserCell(user: activeUser!)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

// MARK:- UserDisplayTableViewCellProtocol
extension GitHubUserDetailsViewController: UserDisplayTableViewCellProtocol {
    func shareUserDetails(_ message: String) {
        let activityVC = UIActivityViewController(activityItems: [message], applicationActivities: nil)
        self.present(activityVC, animated: true, completion: nil)
    }
    
    func navigateIndication(view: ButtonTags) {
        if view.rawValue == 0 {
            isFollowersShown = true
        } else {
            isFollowersShown = false
        }
        showAlert(message: "Development in Progress")
//        performSegue(withIdentifier: "toFollowersScreen", sender: self)
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "GitHub", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in }))
        present(alert, animated: true, completion: nil)
    }
    
/*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toFollowersScreen" {
            let destinationVC = segue.destination as! UserFollowersViewController
            destinationVC.activeUser = activeUser
            destinationVC.isFollowersShown = isFollowersShown
        }
    }*/
}

extension GitHubUserDetailsViewController:PresenterToViewDetailsProtocol{
    func showGitHubUserDetails(gitHubUser: User) {
        self.activeUser = gitHubUser
    }
}

// MARK: Factory method

extension GitHubUserDetailsViewController {
    static func createViewController() -> GitHubUserDetailsViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "UserDetailsViewController") as? GitHubUserDetailsViewController
    }
}


extension UIView {

    func applyGradient(colours: [UIColor], cornerRadius: CGFloat?, startPoint: CGPoint, endPoint: CGPoint)  {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        if let cornerRadius = cornerRadius {
            gradient.cornerRadius = cornerRadius
        }
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        gradient.colors = colours.map { $0.cgColor }
        self.layer.insertSublayer(gradient, at: 0)
    }
}
    
    

    /*

    var presentor:ViewToPresenterDetailsProtocol?
    
    @IBOutlet weak var gitHubUserImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bylineLabel: UILabel!
    @IBOutlet weak var publishedDateLabel: UILabel!
    @IBOutlet weak var abstractLabel: UILabel!
    var gitHubUserDetails:Results!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = GITHUBUSER_DETAILS_TITLE
        
        // Rendering the selected gitHubUser details
        titleLabel.text = self.gitHubUserDetails.title ?? ""
        bylineLabel.text = self.gitHubUserDetails.byline ?? ""
        publishedDateLabel.text =  self.gitHubUserDetails.published_date ?? ""
        abstractLabel.text =  self.gitHubUserDetails.abstract ?? ""
        
        // Setting up the square image
        let imageUrl = getSquareImageURL()
        if let url = URL(string: imageUrl) {
            self.gitHubUserImageView.sd_setImage(with: url, placeholderImage: UIImage(named: GITHUBUSER_DEFAULT_IMAGE))
        } else {
            if let encodedURLString = imageUrl.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) {
                if let url = URL(string: encodedURLString) {
                    self.gitHubUserImageView.sd_setImage(with: url, placeholderImage: UIImage(named: GITHUBUSER_DEFAULT_IMAGE))
                }
            }
        }
    }
    
    // Function to get the square image from media meta data
    func getSquareImageURL() -> String {
        if let mediaInfo = gitHubUserDetails.media, !mediaInfo.isEmpty {
            if let metaData = mediaInfo.first?.mediaMetadata, !metaData.isEmpty {
                let thumbNailMetaData = metaData.filter({ "\($0.format ?? "")" == SQUARE_IMAGE_KEY})
                if !thumbNailMetaData.isEmpty {
                    return thumbNailMetaData.first?.url ?? ""
                }
            }
        }
        return ""
    }
}

extension GitHubUserDetailsViewController:PresenterToViewDetailsProtocol{
    func showGitHubUserDetails(gitHubUserDetails: Results) {
        self.gitHubUserDetails = gitHubUserDetails
    }
}

*/




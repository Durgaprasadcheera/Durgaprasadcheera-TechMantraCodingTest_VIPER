//
//  AppUtils.swift
//  PopularGitHubUsers
//
//  Created by Durga Cheera on 13/02/23.

//

import Foundation
import UIKit


/* Show Progress Indicator */
func showProgressIndicator(view:UIView){
    
    view.isUserInteractionEnabled = false
    
    // Create and add the view to the screen.
    let progressIndicator = ProgressIndicator(text: "Please wait..")
    progressIndicator.tag = PROGRESS_INDICATOR_VIEW_TAG
    view.addSubview(progressIndicator)
    
}

/* Hide progress Indicator */
func hideProgressIndicator(view:UIView){
    
    view.isUserInteractionEnabled = true
    
    if let viewWithTag = view.viewWithTag(PROGRESS_INDICATOR_VIEW_TAG) {
        viewWithTag.removeFromSuperview()
    }
    
}

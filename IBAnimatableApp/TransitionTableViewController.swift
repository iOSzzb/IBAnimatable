//
//  Created by Jake Lin on 2/29/16.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

class TransitionTableViewController: UITableViewController {

  private var transitionAnimationsHeaders = [String]()
  private var transitionAnimations = [[String]]()

  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    generateTransitionTypeData()
  }

  // MARK: - Navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    super.prepareForSegue(segue, sender: sender)
    
    guard let toNavigationController = segue.destinationViewController as? AnimatableNavigationController, indexPath = tableView.indexPathForSelectedRow else {
      return
    }
    
    let transitionAnimationType = String(transitionAnimations[indexPath.section][indexPath.row])
    toNavigationController.transitionAnimationType = transitionAnimationType
    
    if let transitionViewController = toNavigationController.topViewController as? TransitionViewController{
      transitionViewController.animationType = transitionAnimationType
    }
  }

}

// MARK: - Factory

private extension TransitionTableViewController {
  
  func generateTransitionTypeData() {
    transitionAnimationsHeaders.append("Fade")
    transitionAnimations.append(["Fade", "FadeIn", "FadeOut"])
    transitionAnimationsHeaders.append("SystemCube")
    transitionAnimations.append(transitionTypeWithDirections(forName: "SystemCube"))
    transitionAnimationsHeaders.append("SystemFlip")
    transitionAnimations.append(transitionTypeWithDirections(forName: "SystemFlip"))
    transitionAnimationsHeaders.append("SystemPageCurl")
    transitionAnimations.append(["SystemPageCurl(Top)", "SystemPageCurl(Bottom)"])
  }
  
  func transitionTypeWithDirections(forName prefixName: String) -> [String] {
    return [prefixName + "(Left)", prefixName + "(Right)", prefixName + "(Top)", prefixName + "(Bottom)"]
  }
  
}

// MARK: - UITableViewDataSource / UITableViewDelegate

extension TransitionTableViewController {
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return transitionAnimations.count
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return transitionAnimations[section].count
  }
  
  override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return transitionAnimationsHeaders[section]
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("transitionCell", forIndexPath: indexPath) as UITableViewCell
    cell.textLabel?.text = transitionAnimations[indexPath.section][indexPath.row]
    return cell
  }
  
}
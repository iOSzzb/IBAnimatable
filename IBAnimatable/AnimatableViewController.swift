//
//  Created by Jake Lin on 12/14/15.
//  Copyright © 2015 IBAnimatable. All rights reserved.
//

import UIKit

@IBDesignable open class AnimatableViewController: UIViewController, ViewControllerDesignable, StatusBarDesignable, RootWindowDesignable, TransitionAnimatable {
  // MARK: - ViewControllerDesignable
  @IBInspectable open var hideNavigationBar: Bool = false
  
  // MARK: - StatusBarDesignable
  @IBInspectable open var lightStatusBar: Bool = false
  
  // MARK: - RootWindowDesignable
  @IBInspectable open var rootWindowBackgroundColor: UIColor?

  // MARK: - TransitionAnimatable
  @IBInspectable  var _transitionAnimationType: String? {
    didSet {
      if let _transitionAnimationType = _transitionAnimationType {
        transitionAnimationType = TransitionAnimationType(string: _transitionAnimationType)
      }
    }
  }
  open var transitionAnimationType: TransitionAnimationType?
  
  @IBInspectable open var transitionDuration: Double = .nan
  
  open var interactiveGestureType: InteractiveGestureType?
  @IBInspectable var _interactiveGestureType: String? {
    didSet {
      if let _interactiveGestureType = _interactiveGestureType {
        interactiveGestureType = InteractiveGestureType.fromString(_interactiveGestureType)
      }
    }
  }

  // MARK: - Lifecylce
  open override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    confingHideNavigationBar()
    configRootWindowBackgroundColor()
  }
  
  open override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    resetHideNavigationBar()

  }
  
  open override var preferredStatusBarStyle: UIStatusBarStyle {
    if lightStatusBar {
      return .lightContent
    }
    return .default
  }

  
  open override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    super.prepare(for: segue, sender: sender)
    
    // Configure custom transition animation
    guard (segue.destination is PresentationDesignable) == false else {
        return
    }
    
    guard let transitionAnimationType = transitionAnimationType else {
      return
    }
    
    let toViewController = segue.destination
    // If interactiveGestureType has been set
    if let interactiveGestureType = interactiveGestureType {
      toViewController.transitioningDelegate = TransitionPresenterManager.sharedManager().retrievePresenter(transitionAnimationType: transitionAnimationType, transitionDuration: transitionDuration, interactiveGestureType: interactiveGestureType)
    } else {
      toViewController.transitioningDelegate = TransitionPresenterManager.sharedManager().retrievePresenter(transitionAnimationType: transitionAnimationType, transitionDuration: transitionDuration)
    }
  }

}

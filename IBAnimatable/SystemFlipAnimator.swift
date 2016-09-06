//
//  Created by Jake Lin on 2/25/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

/**
 System Flip Animator - To support Flip animation (Four flip directions supported: left, right, top, bottom)
 */
public class SystemFlipAnimator: NSObject, AnimatedTransitioning {
  // MARK: - AnimatorProtocol
  public var transitionAnimationType: TransitionAnimationType
  public var transitionDuration: Duration = defaultTransitionDuration
  public var reverseAnimationType: TransitionAnimationType?
  public var interactiveGestureType: InteractiveGestureType?

  // MARK: - private
  fileprivate var fromDirection: TransitionAnimationType.Direction
  
  public init(fromDirection: TransitionAnimationType.Direction, transitionDuration: Duration) {
    self.fromDirection = fromDirection
    self.transitionDuration = transitionDuration
    
    switch fromDirection {
    case .right:
      self.transitionAnimationType = .systemFlip(fromDirection: .right)
      self.reverseAnimationType = .systemFlip(fromDirection: .left)
      self.interactiveGestureType = .pan(fromDirection: .left)
    case .top:
      self.transitionAnimationType = .systemFlip(fromDirection: .top)
      self.reverseAnimationType = .systemFlip(fromDirection: .bottom)
      self.interactiveGestureType = .pan(fromDirection: .bottom)
    case .bottom:
      self.transitionAnimationType = .systemFlip(fromDirection: .bottom)
      self.reverseAnimationType = .systemFlip(fromDirection: .top)
      self.interactiveGestureType = .pan(fromDirection: .top)
    default:
      self.transitionAnimationType = .systemFlip(fromDirection: .left)
      self.reverseAnimationType = .systemFlip(fromDirection: .right)
      self.interactiveGestureType = .pan(fromDirection: .right)
    }
    
    super.init()
  }
}

extension SystemFlipAnimator: UIViewControllerAnimatedTransitioning {
  public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return retrieveTransitionDuration(transitionContext: transitionContext)
  }
  
  public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    animateWithCATransition(transitionContext: transitionContext, type: SystemTransitionType.flip, subtype: fromDirection.CATransitionSubtype)
  }
}

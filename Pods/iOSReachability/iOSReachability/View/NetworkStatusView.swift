//
//  CustomNoNetworkView.swift
//  LargeNavihationBar
//
//  Created by Tanuja Awasthi on 01/12/18.
//  Copyright © 2018 Tanuja Awasthi. All rights reserved.
//

import UIKit

public enum UINavigationLabelAnimationDirection {
    /* Message navigation will be from top to bottom */
    case eTop
    /* Message navigation will be from bottom to top */
    case eBottom
}

let NavigationViewHeight: CGFloat = 54.0
let xPosition: CGFloat = 40.0

 class NetworkStatusView: UIView {
    var lastContentOffset: CGFloat = 0
    let navigationBarLbl = UILabel()
    var defaultYPosition: CGFloat = 0
    var title: String = ""
    var subTitle: String = ""
    var disableViewMoving: Bool = false
    var isSubViewOnWindow: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = ReachabilityManager.shared.msgBgColor
        self.clipsToBounds = true
        navigationBarLbl.textAlignment = .center
        navigationBarLbl.font = ReachabilityManager.shared.msgFont
       // navigationBarLbl.backgroundColor = .red
        navigationBarLbl.numberOfLines = 0
        navigationBarLbl.textColor = ReachabilityManager.shared.msgTextColor
        navigationBarLbl.frame = CGRect(x: 0, y: 0  , width: frame.size.width, height: frame.size.height)
        self.addSubview(navigationBarLbl)
        UIApplication.shared.keyWindow?.addSubview(self)
        isSubViewOnWindow = true
        navigationBarLbl.attributedText = self.attributedString(with: "No Internet", secondStr: "Please check your internet connection or try again later", spaceLines: 2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")}
    
    func attributedString(with firstStr: String, secondStr: String, spaceLines: CGFloat)->NSAttributedString {
        let strig = String(format:"%@\n%@",firstStr,secondStr)
        let attributedString = NSMutableAttributedString(string:strig)
        
        // *** Create instance of `NSMutableParagraphStyle`
        let paragraphStyle = NSMutableParagraphStyle()
        
        // *** set LineSpacing property in points ***
        paragraphStyle.lineSpacing = spaceLines // Whatever line spacing you want in points
        paragraphStyle.alignment = .center
        paragraphStyle.lineBreakMode = .byTruncatingTail
        // *** Apply attribute to string ***
        /* First Text font and color style */
        attributedString.addAttribute(NSAttributedString.Key.font, value: UIFont.init(name: "Helvetica Neue", size: 16.0)!, range:NSMakeRange(0, firstStr.count))
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, firstStr.count))
        
        attributedString.addAttribute(NSAttributedString.Key.font, value: UIFont.init(name: "Helvetica Neue", size: 14.0)!, range: NSMakeRange(firstStr.count + 1, secondStr.count))
        
        return attributedString
    }
    
     func displayInternetStatus() {
        self.moveTitleView(inDirection: .eBottom)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3.0) {
            self.moveTitleView(inDirection: .eTop)
        }
    }

    func moveTitleView(inDirection direction: UINavigationLabelAnimationDirection) {
        if disableViewMoving == true {
            return
        }
        var frame = self.frame
        var animationTime: Float = 0.0
        if direction == .eTop {
            animationTime = 0.4
            frame.origin.y = NetworkStatusView.yPositionOfLabel(withDirection: .eTop)
            
            
        }else if direction == .eBottom {
            animationTime = 0.5
            frame.origin.y =  NetworkStatusView.yPositionOfLabel(withDirection: .eBottom)
        }
        
        UIView.animate(withDuration: TimeInterval(animationTime),
                       delay: 0.0,
                       options: .curveEaseOut,
                       animations: { () -> Void in
                        self.frame = frame
                        self.setNeedsLayout()
        }, completion: { (finished) -> Void in
            // ....
        })
    }
    
    class func yPositionOfLabel(withDirection direction: UINavigationLabelAnimationDirection)->CGFloat {
        var bottomYPosition: CGFloat = 0.0
        if direction == .eBottom {
            if UIScreen.main.bounds.size.height > 736 {
                bottomYPosition = 28.0
            }else {
                bottomYPosition = 10.0
            }
        }else if direction == .eTop {
            bottomYPosition  = -NavigationViewHeight
        }
        return bottomYPosition
    }

}

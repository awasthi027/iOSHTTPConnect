//
//  ReachabilityManager.swift
//  NetworkStatusMonitor
//
//  Created by Sauvik Dolui on 18/10/16.
//  Copyright © 2016 Innofied Solution Pvt. Ltd. All rights reserved.
//

import Foundation
import UIKit

public class ReachabilityManager: NSObject {
    
    var noNetworkView: NetworkStatusView?
    /** Default messsage bg color is white */
    public var msgBgColor: UIColor = .white
    /** Default  message text color black */
    public var msgTextColor: UIColor = .black
    /** Default is system font and defaulr font size 16.0 */
    public var msgFont: UIFont = UIFont.systemFont(ofSize: 16.0)
    /** No alert message navigation direction */
    public var defaultMsgPosition: UINavigationLabelAnimationDirection = .eBottom
    /** dafault is FALSE. will not display alert message */
    public var isEnableMessageView: Bool =  false
    
    public static let shared = ReachabilityManager()  // 2. Shared instance
    
    private override init() {
        super.init()
        self.startMonitoring()
    }
    /** Boolean to track network reachability  Get propertoy */
    public var isNetworkAvailable : Bool {
        return reachability.connection == .wifi || reachability.connection == .cellular
    }
    
    /** Reachibility instance for Network status monitoring */
    let reachability = Reachability()!
    
    /** Called whenever there is a change in NetworkReachibility Status */
    /** Parameter notification: Notification with the Reachability instance */
    @objc func reachabilityChanged(notification: Notification) {
        let reachability = notification.object as! Reachability
        switch reachability.connection {
        case .none:
            debugPrint("Network became unreachable")
        case .wifi:
            debugPrint("Network reachable through WiFi")
        case .cellular:
            debugPrint("Network reachable through Cellular Data")
        }
    }
    
    
    /** Starts monitoring the network availability status */
    public func startMonitoring() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.reachabilityChanged),
                                               name: Notification.Name.reachabilityChanged,
                                               object: reachability)
        do{
            try reachability.startNotifier()
        }catch{
            debugPrint("Could not start reachability notifier")
        }
    }
    
    /** Stops monitoring the network availability status */
    public func stopMonitoring() {
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: Notification.Name.reachabilityChanged,
                                                  object: reachability)
    }
    /** Display meessge message no internet */
    public func displayInternetStatus() {
        if ReachabilityManager.shared.isEnableMessageView == false {
            return
        }
        DispatchQueue.main.async {
            if self.noNetworkView == nil {
             self.noNetworkView = NetworkStatusView.init(frame:  CGRect(x: xPosition, y: NetworkStatusView.yPositionOfLabel(withDirection: .eTop), width: (UIScreen.main.bounds.size.width - 2 * xPosition) , height: NavigationViewHeight))
            }
            if let item  = self.noNetworkView {
             item.displayInternetStatus()
            }
        }
    }
}

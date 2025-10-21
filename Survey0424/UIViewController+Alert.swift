//
//  UIViewController+Alert.swift
//  Survey0424
//
//  Created by Paul Neuhold on 24.04.24.
//

import Foundation
import UIKit

extension UIViewController {
    public func presentInfoAlert(title: String?,
                                 message: String?,
                                 actionTitle: String,
                                 cancelTitle: String,
                                 completion: ((UIAlertAction) -> Void)? = nil,
                                 style: UIAlertAction.Style = .default ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: style, handler: completion))
        alert.addAction(UIAlertAction(title: cancelTitle, style: .cancel))
        present(alert, animated: true, completion: nil)
    }
    
    public func presentInfoAlert(title: String?,
                                 message: String?,
                                 actionTitle: String,
                                 completion: ((UIAlertAction) -> Void)? = nil,
                                 style: UIAlertAction.Style = .default ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: style, handler: completion))
        present(alert, animated: true, completion: nil)
    }
    
    public func presentActivityController(shareItem: Any,
                                          sender: UIView,
                                          useCenterSourceRect: Bool = false,
                                          onDiscardCompletion: (() -> Void)? = nil,
                                          onItemCompletion: (() -> Void)? = nil) {
        
        let activityViewController = UIActivityViewController(activityItems: [shareItem],
                                                              applicationActivities: nil)
        
        activityViewController.popoverPresentationController?.sourceView = sender
        activityViewController.popoverPresentationController?.sourceRect = useCenterSourceRect ? CGRect(origin: sender.center, size: CGSize(width: 5, height: 5)) : sender.frame
        activityViewController.popoverPresentationController?.canOverlapSourceViewRect = true
        
        activityViewController.completionWithItemsHandler = {
            activityType, completed, returnedItems, activityError in
            
            if completed {
                onItemCompletion?()
            }
            if activityType == nil && !completed {
                onDiscardCompletion?()
            }
        }
        
        present(activityViewController, animated: true, completion: nil)
    }
}

//
//  MessageUIHelper.swift
//  Survey0424
//
//  Created by Paul Neuhold on 25.04.24.
//

import Foundation
import MessageUI

final class MessageUIHelper {
    static let sharedHelper = MessageUIHelper()
    
    private init(){}
    
    func sendMail(on presenter: UIViewController & MFMailComposeViewControllerDelegate, recepient: String, msg: String? = nil, subject: String? = nil, attachmentUrl: URL? = nil,  fallback: @escaping(()->Void)) {
        if !MFMailComposeViewController.canSendMail() {
            fallback()
            return
        }
        let mailComposeViewController = MFMailComposeViewController()
        
        mailComposeViewController.mailComposeDelegate = presenter
        if !recepient.isEmpty {
            mailComposeViewController.setToRecipients([recepient])
        }
        
        if let msg {
            mailComposeViewController.setMessageBody(msg, isHTML: false)
        }
        
        if let subject {
            mailComposeViewController.setSubject(subject)
        }
        
        if let url = attachmentUrl, let fileData = try? Data(contentsOf: url) {
            mailComposeViewController.addAttachmentData(fileData, mimeType: "text/csv", fileName: "surveyExport.csv")
        }
        
        // Present the view controller modally
        presenter.present(mailComposeViewController, animated: true, completion: nil)
    }
}


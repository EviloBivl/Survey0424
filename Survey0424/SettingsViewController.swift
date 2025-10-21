//
//  SettingsViewController.swift
//  Survey0424
//
//  Created by Paul Neuhold on 24.04.24.
//

import Foundation
import UIKit
import MessageUI

enum TextFieldType : Int {
    case surveyQuestion = 0
    case surveyQuestionSubtitle = 1
    case surveyFeedbackTitle = 2
    case surveyFeedbackSubtitle = 3
    
}

class SettingsViewController: UITableViewController {
    
    var viewModel: SettingsViewModel = SettingsViewModel()
    var sTitle: String = ""
    var sSubtitle: String = ""
    var fTitle: String = ""
    var fSubtitle: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        setupTable()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage.init(systemName: "xmark"), style: .done, target: self, action: #selector(dismissVc))
    }
    
    @objc private func dismissVc(){
        self.dismiss(animated: true)
    }
    
    private func setupTable() {
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .systemGray6
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Settings"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TextInfoTableViewCell()
        cell.content = viewModel.content(at: indexPath) as? TextInfoTableViewCell.Content
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let exporter = Exporter()
        
        guard let cellType = viewModel.cellType(at: indexPath) else { return }
        var share: String? = nil
        
        switch cellType {
        case .singleExport:
            share = exporter.singleValueExport()
            
        case .summedExport:
            share = exporter.summedValueExport()
            
        case .fullExport:
            share = exporter.fullExport()
            
        case .surveyQuestion:
            showSettingsAlert()
            
        case .exportFile:
            guard let csvData = exporter.fullExport(),
                let fileUrl = FileStorage.storeString(str: csvData, fileName: "survey_export.csv") else { return }
            presentActivityController(shareItem: fileUrl, sender: (tableView.cellForRow(at: indexPath) as? TextInfoTableViewCell)?.infoTitle ?? self.view )
            
        case .exportMail:
            guard let csvData = exporter.fullExport(),
                let fileUrl = FileStorage.storeString(str: csvData, fileName: "survey_export.csv") else { return }
            MessageUIHelper.sharedHelper.sendMail(on: self, recepient: "", attachmentUrl: fileUrl, fallback: {
                self.presentInfoAlert(title: "Ups", message: "Leider konnte kein Mail Client geöffnet werden", actionTitle: "OK")
            })
            
        case .clear:
            tryClearData()
        }
        UIPasteboard.general.string = share
        
        guard let share else { return }
        let cell = tableView.cellForRow(at: indexPath) as? TextInfoTableViewCell
        presentActivityController(shareItem: share,
                                  sender: cell?.infoTitle ?? self.view)
        
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return viewModel.footerText
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSingleSection
    }
}

extension SettingsViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}

extension SettingsViewController: SettingsViewModelDelegate {
    func signalUpdate() {
        tableView.reloadData()
    }
}

extension SettingsViewController {
    func tryClearData() {
        
        presentInfoAlert(title: "Attention",
                         message: "You are about to wipe all the collected data, are you sure you want to do this?",
                         actionTitle: "Delete",
                         cancelTitle: "Cancel",
                         completion: { _ in
            SurveyResultDataStore.sharedStore.clear()
            SurveyState.shared.clearTitles()
            self.tableView.reloadData()
        },
                         style: .destructive)
    }
    
    func showSettingsAlert() {
        let alert = UIAlertController(title: "Set Surveydata",
                                      message: "Here you can enter a question which should be raised and the content of the feedback Screen",
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "Save",
                                   style: .default,
                                   handler: {
            result in
            self.storeValues()
        })
        let actionAbort = UIAlertAction(title: "Cancel",
                                        style: .cancel ,
                                        handler: {
            result in
        })
        
        alert.addAction(actionAbort)
        alert.addAction(action)
        
        alert.addTextField(configurationHandler: {
            textField in
            textField.placeholder = "Survey Title"
            textField.delegate = self
            textField.tag = TextFieldType.surveyQuestion.rawValue
        })
        
        alert.addTextField(configurationHandler: {
            textField in
            textField.placeholder = "Survey Subtitle"
            textField.delegate = self
            textField.tag = TextFieldType.surveyQuestionSubtitle.rawValue
        })
        
        alert.addTextField(configurationHandler: {
            textField in
            textField.placeholder = "Feedback Title"
            textField.delegate = self
            textField.tag = TextFieldType.surveyFeedbackTitle.rawValue
        })
        
        alert.addTextField(configurationHandler: {
            textField in
            textField.placeholder = "The Feedback Subtitle"
            textField.delegate = self
            textField.tag = TextFieldType.surveyFeedbackSubtitle.rawValue
        })
        
        self.present(alert, animated: true, completion: nil)
    }
    
    private func storeValues(){
        if !sTitle.isEmpty {
            viewModel.setQuestion(sTitle)
        }
        
        if !sSubtitle.isEmpty {
            viewModel.setQuestionSubtitle(sSubtitle)
        }
        
        if !fTitle.isEmpty {
            viewModel.setFeedbackTitle(fTitle)
        }
        
        if !fSubtitle.isEmpty {
            viewModel.setFeedbackSubtitle(fSubtitle)
        }
    }
}

extension SettingsViewController : UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        
        if textField.tag == TextFieldType.surveyQuestion.rawValue {
            sTitle = text
        } else if textField.tag == TextFieldType.surveyQuestionSubtitle.rawValue {
            sSubtitle = text
        } else if textField.tag == TextFieldType.surveyFeedbackTitle.rawValue {
            fTitle = text
        } else if textField.tag == TextFieldType.surveyFeedbackSubtitle.rawValue {
            fSubtitle = text
        }
    }
}

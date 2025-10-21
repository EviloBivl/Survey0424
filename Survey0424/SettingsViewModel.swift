//
//  SettingsViewModel.swift
//  Survey0424
//
//  Created by Paul Neuhold on 24.04.24.
//

import Foundation

protocol SettingsViewModelDelegate: AnyObject {
    func signalUpdate()
}

final class SettingsViewModel: SingleSectionDataViewModel {
    static let surveyQuestionKey = "com.pneuhold.surveyQuestion"
    static let surveyQuestionSubtitleKey = "com.pneuhold.surveyQuestionSubtitleKey"
    static let surveyFeedbackTitle = "com.pneuhold.surveyFeedbackTitle"
    static let surveyFeedbackSubtitle = "com.pneuhold.surveyFeedbackSubtitle"
    
    enum CellType {
        case singleExport
        case summedExport
        case fullExport
        case surveyQuestion
        case clear
        case exportFile
        case exportMail
    }
    
    var cellData: [CellDataModel<CellType>] = [CellDataModel<CellType>]()
    weak var delegate: SettingsViewModelDelegate?
    
    init(){
        updateCells()
    }
    
    private func updateCells(){
        cellData.removeAll()
        
        cellData.append(CellDataModel(cellType: .clear, content: TextInfoTableViewCell.Content(title: "Clear", text: "This clear the current stored survey results")))
   
        cellData.append(CellDataModel(cellType: .singleExport, content: TextInfoTableViewCell.Content(title: "Export Single", text: "This will export a csv string with all single values")))
        cellData.append(CellDataModel(cellType: .summedExport, content: TextInfoTableViewCell.Content(title: "Export Summed", text: "This will export a csv string with the summarized values")))
        cellData.append(CellDataModel(cellType: .fullExport, content: TextInfoTableViewCell.Content(title: "Export Full", text: "This will export a csv string with all values")))
        cellData.append(CellDataModel(cellType: .exportFile, content: TextInfoTableViewCell.Content(title: "Export File", text: "This will open the share dialog with an csv file, after sharing it gets deleted right away")))
        cellData.append(CellDataModel(cellType: .exportMail, content: TextInfoTableViewCell.Content(title: "Export Mail", text: "Opens your default mail client to send a file as attachment")))
        
        cellData.append(CellDataModel(cellType: .surveyQuestion, content: TextInfoTableViewCell.Content(title: "Set Survey Questions", text: "If you click here you will get a prompt to setup the surves journey!")))
        
        notifyUpdate()
    }
    
    var footerText: String {
        return """
        \n
        Current State:
            SurveyQuestion: \(SurveyState.shared.surveyQuestion)
            SurveySubtitle: \(SurveyState.shared.surveySubtitle)
            FeedbackTitle: \(SurveyState.shared.feedBackTitle)
            FeedbackSubtitle: \(SurveyState.shared.feedbackSubtitle)
        """
    }
    
    private func notifyUpdate() {
        delegate?.signalUpdate()
    }
    
    func setQuestion(_ value: String?) {
        guard let newValue = value else { return }
        UserDefaults.standard.setValue(newValue, forKey: SettingsViewModel.surveyQuestionKey)
        UserDefaults.standard.synchronize()
        notifyUpdate()
    }
    
    func setQuestionSubtitle(_ value: String?) {
        guard let newValue = value else { return }
        UserDefaults.standard.setValue(newValue, forKey: SettingsViewModel.surveyQuestionSubtitleKey)
        notifyUpdate()
    }
    
    func setFeedbackTitle(_ value: String?) {
        guard let newValue = value else { return }
        UserDefaults.standard.setValue(newValue, forKey: SettingsViewModel.surveyFeedbackTitle)
        notifyUpdate()
    }
    
    func setFeedbackSubtitle(_ value: String?) {
        guard let newValue = value else { return }
        UserDefaults.standard.setValue(newValue, forKey: SettingsViewModel.surveyFeedbackSubtitle)
        notifyUpdate()
    }
    
}

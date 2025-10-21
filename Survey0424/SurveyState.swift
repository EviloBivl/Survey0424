//
//  SurveyConfig.swift
//  Survey0424
//
//  Created by Paul Neuhold on 24.04.24.
//

import Foundation

final class SurveyState {
    static let shared = SurveyState()
    
    private let fallbackFeedbackTitle = "Thank You!"
    private let fallbackFeedbackSubtitle = "We appriciate your Feedback, have a nice day!"
    
    private let fallbackSurveyQuestion = "How does the place feel now?"
    private let fallbackSurveySubtitle = "Wie fühlt sich der Platz jetzt an?"
    
    static let feedbackScreenDuration: CGFloat = 2
    
    private init() {}
    
    public func getStringValue(forKey: String) -> String? {
        return UserDefaults.standard.value(forKey: forKey) as? String
    }
    
    public func clearTitles(){
        clear(forKey: SettingsViewModel.surveyQuestionKey)
        clear(forKey: SettingsViewModel.surveyQuestionSubtitleKey)
        clear(forKey: SettingsViewModel.surveyFeedbackTitle)
        clear(forKey: SettingsViewModel.surveyFeedbackSubtitle)
    }
    
    private func clear(forKey: String) {
        UserDefaults.standard.removeObject(forKey: forKey)
    }
    
    var surveyQuestion: String {
        guard let storedValue = getStringValue(forKey: SettingsViewModel.surveyQuestionKey), !storedValue.isEmpty else { return fallbackSurveyQuestion }
        return storedValue
    }
    
    var surveySubtitle: String {
        guard let storedValue = getStringValue(forKey: SettingsViewModel.surveyQuestionSubtitleKey), !storedValue.isEmpty else { return fallbackSurveySubtitle }
        return storedValue
    }
    
    var feedBackTitle: String {
        guard let storedValue = getStringValue(forKey: SettingsViewModel.surveyFeedbackTitle), !storedValue.isEmpty else { return fallbackFeedbackTitle }
        return storedValue
    }
    
    var feedbackSubtitle: String {
        guard let storedValue = getStringValue(forKey: SettingsViewModel.surveyFeedbackSubtitle), !storedValue.isEmpty else { return fallbackFeedbackSubtitle }
        return storedValue
    }
    
}

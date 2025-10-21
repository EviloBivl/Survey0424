//
//  SurveySceenViewModel.swift
//  Survey0424
//
//  Created by Paul Neuhold on 19.04.24.
//

import Foundation
import UIKit

protocol SurveySceenViewModelDelegate: AnyObject {}

final class SurveySceenViewModel {
    weak var delegate: SurveySceenViewModelDelegate?
    
    init(){}
    
    func didClick(result: SurveyResult, increaseValue: Int = 1) {
        let item = SurveyItem(value: result, date: Date().timeIntervalSince1970)
        SurveyResultDataStore.sharedStore.append(item: item)
    }
    
    var surveyQuestion: String {
        return SurveyState.shared.surveyQuestion
    }
    
    var surveySubtitle: String {
        return SurveyState.shared.surveySubtitle
    }
}

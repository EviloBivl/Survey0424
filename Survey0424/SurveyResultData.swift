//
//  SurveyResultData.swift
//  Survey0424
//
//  Created by Paul Neuhold on 24.04.24.
//

import Foundation

struct SurveyResultData: Codable {
    var items: [SurveyItem]
}

struct SurveyItem: Codable {
    let value: SurveyResult
    let date: TimeInterval
}


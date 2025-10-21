//
//  SurveyResultStore.swift
//  Survey0424
//
//  Created by Paul Neuhold on 24.04.24.
//

import Foundation


final class SurveyResultDataStore: UserDefaultStoreCodable {
    typealias Model = SurveyResultData
    static var userDefaultsKey: String = "com.paulneuhold.surveyItem24"
    
    static let sharedStore = SurveyResultDataStore()
    
    private var createdModel: Model {
        return model ?? SurveyResultData(items: [SurveyItem]())
    }
    
    public func append(item: SurveyItem) {
        var model = createdModel
        model.items.append(item)
        persist(model: model)
    }
}

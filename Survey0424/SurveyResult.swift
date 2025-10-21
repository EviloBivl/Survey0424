//
//  SurveyResult.swift
//  Survey0424
//
//  Created by Paul Neuhold on 25.04.24.
//

import Foundation
import UIKit

enum SurveyResult: Int, CaseIterable, Codable {
    case sehrGut = 0
    case gut
    case neutral
    case schlecht
    
    var prettyName: String {
        switch self {
        case .sehrGut:
            return "Sehr Gut"
        case .gut:
            return "Gut"
        case .neutral:
            return "Neutral"
        case .schlecht:
            return "Schlecht"
        }
    }
    
    var key: String {
        return "\(self)"
    }
}

//
//  FontWeight.swift
//  Survey0424
//
//  Created by Paul Neuhold on 24.04.24.
//

import Foundation
import UIKit

enum FontWeight {
    case thin
    case light
    case regular
    case semibold
    case bold
    case black
    case extraBold
}

extension FontWeight {
    var weight: CGFloat {
        switch self {
        case .thin:
            return UIFont.Weight.thin.rawValue
        case .light:
            return UIFont.Weight.light.rawValue
        case .regular:
            return UIFont.Weight.regular.rawValue
        case .semibold:
            return UIFont.Weight.semibold.rawValue
        case .bold:
            return UIFont.Weight.bold.rawValue
        case .black:
            return UIFont.Weight.black.rawValue
        case .extraBold:
            return UIFont.Weight.heavy.rawValue
        
        }
    }
}

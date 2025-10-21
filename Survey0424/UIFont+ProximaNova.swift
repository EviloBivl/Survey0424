//
//  UIFont+ProximaNova.swift
//  Survey0424
//
//  Created by Paul Neuhold on 24.04.24.
//

import Foundation
import UIKit

extension UIFont {
    class func printAllFilesInSandbox(){
        guard let documentsDirectory =  try? FileManager().url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true) else { return }
        guard let fileEnumerator = FileManager.default.enumerator(at: documentsDirectory, includingPropertiesForKeys: nil, options: FileManager.DirectoryEnumerationOptions()) else { return }
        while let file = fileEnumerator.nextObject() {
            print("Stored File: \(file)")
        }
    }
    
    enum ProximaNova: String {
        case black = "ProximaNova-Black"
        case bold = "ProximaNova-Bold"
        case extraBold = "ProximaNova-Extrabld"
        case light = "ProximaNova-Light"
        case regular = "ProximaNova-Regular"
        case semibold = "ProximaNova-Semibold"
        case thin = "ProximaNovaT-Thin"
    }
    
    static func proximaNova(ofSize size: CGFloat) -> UIFont {
        return proximaNovaFont(ofSize: size, weight: .regular)
    }
    
    static func proximaNovaFont(ofSize size: CGFloat, weight: FontWeight) -> UIFont {
        let fallbackFont = UIFont.systemFont(ofSize: CGFloat(size), weight: UIFont.Weight(rawValue: weight.weight))
        
        switch weight {
        case .thin:
            return UIFont(name: ProximaNova.thin.rawValue, size: CGFloat(size)) ?? fallbackFont
        case .light:
            return UIFont(name: ProximaNova.light.rawValue, size: CGFloat(size)) ?? fallbackFont
        case .regular:
            return UIFont(name: ProximaNova.regular.rawValue, size: CGFloat(size)) ?? fallbackFont
        case .semibold:
            return UIFont(name: ProximaNova.semibold.rawValue, size: CGFloat(size)) ?? fallbackFont
        case .bold:
            return UIFont(name: ProximaNova.bold.rawValue, size: CGFloat(size)) ?? fallbackFont
        case .black:
            return UIFont(name: ProximaNova.black.rawValue, size: CGFloat(size)) ?? fallbackFont
        case .extraBold:
            return UIFont(name: ProximaNova.extraBold.rawValue, size: CGFloat(size)) ?? fallbackFont
        }
    }
}

//
//  Exporter.swift
//  Survey0424
//
//  Created by Paul Neuhold on 24.04.24.
//

import Foundation

final class Exporter {
    public static var localLongTimeFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.system
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm:ss"
        //if we want utc
        //utcTimeFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        return dateFormatter
    }
    
    private let selectedValuesTotalHeader: String = "Selected Values Total"
    private let selectedValuesTotalValuesHeader: String = "Total Values"
    
    private let headerSingleValue: String = "Selected Value"
    private let headerSingleValueTime: String = "Selected Value Time"
    private let csvSeperator: String = ";"
    
    public func summedValueExport() -> String? {
        let fullSummedHeader: String = selectedValuesTotalHeader + csvSeperator + selectedValuesTotalValuesHeader + "\n"
        
        var csvData: String = ""
        csvData += fullSummedHeader
        
        var values: [String: Int] = [String: Int]()
        
        guard let model = SurveyResultDataStore.sharedStore.model else {
            return nil
        }
        
        model.items.forEach {
            let current = values[$0.value.key] ?? 0
            values[$0.value.key] = (current + 1)
        }
        
        SurveyResult.allCases.forEach {
            let value = values[$0.key] ?? 0
            csvData += "\($0.prettyName)\(csvSeperator)\(value)\n"
        }
        return csvData
    }
    
    public func singleValueExport() -> String? {
        let fullSingleValueHeader: String = headerSingleValue + csvSeperator + headerSingleValueTime + "\n"
        
        var csvData = ""
        csvData += fullSingleValueHeader + "\n"
        
        guard let model = SurveyResultDataStore.sharedStore.model else {
            return nil
        }
        
        model.items.forEach {
            let dateString = Exporter.localLongTimeFormatter.string(from: Date(timeIntervalSince1970: $0.date))
            csvData += "\($0.value.prettyName)\(csvSeperator)\(dateString)\n"
        }
        
        csvData += csvSeperator + "\n"
        return csvData
    }
    
    public func fullExport() -> String? {
        guard let single = singleValueExport(), let summed = summedValueExport() else {
            return nil
        }
        
        var csvData: String = ""
        
        csvData += summed
        csvData += csvSeperator + "\n"
        csvData += single
        
        return csvData
    }
}

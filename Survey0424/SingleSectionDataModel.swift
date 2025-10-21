//
//  SingleSectionDataModel.swift
//  Survey0424
//
//  Created by Paul Neuhold on 24.04.24.
//

import Foundation

struct CellDataModel<T> {
    let cellType: T
    let content: Any?
}

protocol TableViewSection {}

protocol SingleSectionDataViewModel {
    associatedtype CellType
    var cellData: [CellDataModel<CellType>] { get set }
    var numberOfSections: Int { get }
    var numberOfRowsInSingleSection: Int { get }
    
    func cellType(at indexPath: IndexPath) -> CellType?
    func content(at indexPath: IndexPath) -> Any?
    
}

extension SingleSectionDataViewModel {
    func cellType(at indexPath: IndexPath) -> CellType? {
        return cellData[indexPath.row].cellType
    }
    
    func content(at indexPath: IndexPath) -> Any? {
        return cellData[indexPath.row].content
    }
    
    var numberOfSections: Int {
        return 1
    }
    
    var numberOfRowsInSingleSection: Int {
        return cellData.count
    }
}

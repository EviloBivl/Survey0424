//
//  UserDefaultsCodable.swift
//  Survey0424
//
//  Created by Paul Neuhold on 24.04.24.
//

import Foundation

public protocol UserDefaultStoreCodable {
    associatedtype Model: Codable
    static var userDefaultsKey: String { get }
}

public extension UserDefaultStoreCodable {
    
    var model: Model? {
        guard let data = UserDefaults.standard.value(forKey: Self.userDefaultsKey) as? Data else {
            print("Decode error:  UserDefault Object: \(Model.self)")
            return nil
        }
        let decoder = JSONDecoder()
        guard let decodedObj = try? decoder.decode(Model.self, from: data) else { return nil }
        return decodedObj
    }
    
    func persist(model: Model) {
        let encoder = JSONEncoder()
        guard let encodedObj = try? encoder.encode(model) else {
            print("Encode error:  UserDefault Object: \(Model.self)")
            return
        }
        UserDefaults.standard.set(encodedObj, forKey: Self.userDefaultsKey)
        UserDefaults.standard.synchronize()
    }
    
    func clear() {
        UserDefaults.standard.removeObject(forKey: Self.userDefaultsKey)
        UserDefaults.standard.synchronize()
    }
}

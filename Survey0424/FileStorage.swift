//
//  FileStorage.swift
//  Survey0424
//
//  Created by Paul Neuhold on 25.04.24.
//

import Foundation

struct FileStorage {
    static func storeString(str: String, fileName: String) -> URL? {
        guard let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        var storedFilename = fileName
        let fileUrl = dir.appendingPathComponent(storedFilename)
        do {
            try str.write(to: fileUrl, atomically: true, encoding: String.Encoding.utf8)
            return fileUrl
        } catch {
            return nil
            // failed to write file – bad permissions, bad filename, missing permissions, or more likely it can't be converted to the encoding
        }
    }
    
    static func deleteFile(path: URL) {
        do {
            try FileManager.default.removeItem(at: path)
            print("deleted file at \(path.absoluteString)")
        } catch {
            print("could no delete file")
        }
    }
}

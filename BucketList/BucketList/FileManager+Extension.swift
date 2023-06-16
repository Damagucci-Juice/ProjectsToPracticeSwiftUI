//
//  FileManager+Extension.swift
//  BucketList
//
//  Created by Gucci on 2023/06/16.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

//
//  Cache.swift
//  GitHistory
//
//  Created by chenyh on 2020/12/27.
//

import UIKit
import FMDB

private let kCacheTable = "cacheTable"

class Cache {
    static let shared = Cache()
    
    private var database: FMDatabase?
    
    init() {
        createTable()
    }
    
    private func createTable() {
        database = FMDatabase(path: path)
        guard let db = database else {
            print("database create failure")
            return
        }
        if db.open() {
            let sql = """
            create table if not exists \(kCacheTable) (id INTEGER primary key, value TEXT, time TEXT)
            """
            if db.executeUpdate(sql, withArgumentsIn: []) {
                print("craete table success")
            }
        }
    }
    
    func insert(data: String, time: String) -> Bool {
        guard let db = database  else {
            return false
        }
        let sql = """
        INSERT INTO \(kCacheTable) (value, time) VALUES('\(data)', '\(time)')
        """
        return db.executeUpdate(sql, withArgumentsIn: [])
    }
    
    func queryList(count: Int = 0) -> [[String: String]] {
        guard let db = database  else {
            print("db get failure")
            return []
        }
        let limit = count == 0 ? "" : "LIMIT \(count)"
        let sql = """
        SELECT * FROM \(kCacheTable) Order By time Desc \(limit)
        """
        guard let result = db.executeQuery(sql, withArgumentsIn: []) else {
            print("query cache failure")
            return []
        }
        var tmp: [[String: String]] = []
        while result.next() {
            let time = result.string(forColumn: "time") ?? ""
            let data = result.string(forColumn: "value") ?? ""
            let map = [
                "time": time,
                "data": data
            ]
            tmp.append(map)
        }
        
        return tmp
    }
    
}


extension Cache {
    private var path: String? {
        get {
            let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
            guard let documentPath = paths.first else {
                return nil;
            }
            
            return documentPath + "/" + kCacheTable
        }
    }
}

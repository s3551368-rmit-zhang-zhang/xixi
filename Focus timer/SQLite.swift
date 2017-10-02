//
//  SQLite.swift
//  Focus timer
//
//  Created by Zhang Zhang on 9/28/17.
//  Copyright © 2017 Zhang Zhang. All rights reserved.
//

import Foundation
import SQLite

class SQLite {
    
    static let shared = SQLite()
    
    private init(){
        self.initialSQLite()
    }
    var database : Connection!
    
    let musicTable = Table("music")
    
    let id = Expression<Int>("id")
    
    let name = Expression<String>("name")
    
    func initialSQLite(){
        
        do{
            
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("music").appendingPathExtension("sqlite3")
            let database = try Connection(fileUrl.path)
            self.database = database
            
        }catch {
            print(error)
        }
       
    }
    
    func createTable(){
        
        let createTable = self.musicTable.create { (table) in
            table.column(self.id, primaryKey: true)
            table.column(self.name, unique: true)
        }
        
        do{
            try self.database.run(createTable)
            print("Created Table")
        }catch{
            print(error)
        }
    }
}

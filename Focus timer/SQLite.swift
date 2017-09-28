//
//  SQLite.swift
//  Focus timer
//
//  Created by Zhang Zhang on 9/28/17.
//  Copyright © 2017 Zhang Zhang. All rights reserved.
//

import Foundation
import SQLite

struct SQLite {
    
    var database : Connection!
    
    let musicTable = Table("music")
    
    let id = Expression<Int>("id")
    
    mutating func initialSQLite(){
        
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
        
    }
}

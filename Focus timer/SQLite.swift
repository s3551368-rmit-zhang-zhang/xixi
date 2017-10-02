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
    
    let type = Expression<String>("type")
    
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
            table.column(self.id, primaryKey: .autoincrement)
            table.column(self.name, unique: true)
            table.column(self.type)
        }
        
        do{
            try self.database.run(createTable)
            print("Created Table")
        }catch{
            print(error)
        }
    }
    
    func insertMusic(name:String, type:String){
        
        let insert = self.musicTable.insert(self.name <- name, self.type <- type)
        
        do{
           try self.database.run(insert)
            print("Inserted music")
        }
        catch{
            print(error)
        }
    }
    
    func listMusic(){
        do {
            let musics = try self.database.prepare(self.musicTable)
            for music in musics{
                print("musicId: \(music[self.id]), name: \(music[self.name]), type: \(music[self.type])")
            }
        }catch{
            print(error)

        }
    }
    func getIndex(id:Int) -> (String, String){
       
        var Nname = ""
        var Ntype = ""
        
        let filter = musicTable.filter(self.id == id)
        
        do {
            for music in try self.database.prepare(filter){
                
                Nname = music[name]
                Ntype = music[type]
                
            }
        }catch{
            print(error)
        }
        return (Nname, Ntype)
        
    }
    
    func deletTable(){
        do{
            try self.database.run(musicTable.drop())
            print("Deleted")
        }catch{
            print(error)
        }
    }
    
}

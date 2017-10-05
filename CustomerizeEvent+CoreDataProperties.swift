//
//  CustomerizeEvent+CoreDataProperties.swift
//  
//
//  Created by Zhang Zhang on 10/3/17.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension CustomerizeEvent {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CustomerizeEvent> {
        return NSFetchRequest<CustomerizeEvent>(entityName: "CustomerizeEvent");
    }

    @NSManaged public var note: String?
    @NSManaged public var timeLength: Int32?
    @NSManaged public var owner: Customer?

}

//
//  CustomerizeEvent+CoreDataProperties.swift
//  
//
//  Created by James zhang on 3/10/17.
//
//

import Foundation
import CoreData


extension CustomerizeEvent {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CustomerizeEvent> {
        return NSFetchRequest<CustomerizeEvent>(entityName: "CustomerizeEvent")
    }

    @NSManaged public var note: String?
    @NSManaged public var timeLength: Int32
    @NSManaged public var owner: Customer?

}

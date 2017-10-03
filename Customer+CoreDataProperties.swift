//
//  Customer+CoreDataProperties.swift
//  
//
//  Created by Zhang Zhang on 10/3/17.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Customer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Customer> {
        return NSFetchRequest<Customer>(entityName: "Customer");
    }

    @NSManaged public var accountNum: String?
    @NSManaged public var password: String?
    @NSManaged public var customerEvent: NSSet?

}

// MARK: Generated accessors for customerEvent
extension Customer {

    @objc(addCustomerEventObject:)
    @NSManaged public func addToCustomerEvent(_ value: CustomerizeEvent)

    @objc(removeCustomerEventObject:)
    @NSManaged public func removeFromCustomerEvent(_ value: CustomerizeEvent)

    @objc(addCustomerEvent:)
    @NSManaged public func addToCustomerEvent(_ values: NSSet)

    @objc(removeCustomerEvent:)
    @NSManaged public func removeFromCustomerEvent(_ values: NSSet)

}

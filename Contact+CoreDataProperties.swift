//
//  Contact+CoreDataProperties.swift
//  NBC_iOS4th_LJH_PhoneAddressBook
//
//  Created by t2023-m0023 on 7/18/24.
//
//

import Foundation
import CoreData

extension Contact {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contact> {
        return NSFetchRequest<Contact>(entityName: "Contact")
    }

    @NSManaged public var userName: String?
    @NSManaged public var userNum: String?
    @NSManaged public var userImage: Data?

}

//
//  User.swift
//  NovelNestt
//
//  Created by MacMini on 12/04/1946 Saka.
//

import Foundation
import CoreData

@objc(user)
public class user: NSManagedObject {

}

extension user {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var name: String
    @NSManaged public var number: String
    @NSManaged public var email: String
    @NSManaged public var password: String
}

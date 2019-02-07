//
//  Goh+CoreDataProperties.swift
//  KenshinAppAll
//
//  Created by Harada Hiroaki on 2019/02/07.
//  Copyright © 2019 KenshinT. All rights reserved.
//
//

import Foundation
import CoreData


extension Goh {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Goh> {
        return NSFetchRequest<Goh>(entityName: "Goh")
    }

    @NSManaged public var updated_at: NSDate?
    @NSManaged public var created_at: NSDate?
    @NSManaged public var towns_name_j: String?
    @NSManaged public var towns_name_c: String?
    @NSManaged public var gou_ban: String?
    @NSManaged public var locations_code: String?

}

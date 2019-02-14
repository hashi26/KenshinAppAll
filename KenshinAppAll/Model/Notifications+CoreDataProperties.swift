//
//  Notifications+CoreDataProperties.swift
//  KenshinAppAll
//
//  Created by Harada Hiroaki on 2019/02/14.
//  Copyright © 2019 KenshinT. All rights reserved.
//
//

import Foundation
import CoreData


extension Notifications {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Notifications> {
        return NSFetchRequest<Notifications>(entityName: "Notifications")
    }

    @NSManaged public var contact_tel_no: String?
    @NSManaged public var contents: String?
    @NSManaged public var created_at: NSDate?
    @NSManaged public var delete_flg: Int16
    @NSManaged public var from_base_code: String?
    @NSManaged public var from_branch_office_code: String?
    @NSManaged public var from_sales_office_code: String?
    @NSManaged public var notification_no: String?
    @NSManaged public var sender_name: String?
    @NSManaged public var supervisor_name: String?
    @NSManaged public var title: String?
    @NSManaged public var to_base_code: String?
    @NSManaged public var to_branch_office_code: String?
    @NSManaged public var to_sales_office_code: String?
    @NSManaged public var updated_at: NSDate?

}

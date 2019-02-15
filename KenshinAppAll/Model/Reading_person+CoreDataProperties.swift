//
//  Reading_person+CoreDataProperties.swift
//  KenshinAppAll
//
//  Created by Harada Hiroaki on 2019/02/14.
//  Copyright © 2019 KenshinT. All rights reserved.
//
//

import Foundation
import CoreData


extension Reading_person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Reading_person> {
        return NSFetchRequest<Reading_person>(entityName: "Reading_person")
    }

    @NSManaged public var base_code: String?
    @NSManaged public var branch_office_code: String?
    @NSManaged public var created_at: NSDate?
    @NSManaged public var knsn_tnt_emp_no: String?
    @NSManaged public var knsn_tnt_name: String?
    @NSManaged public var knsn_tnt_pass: String?
    @NSManaged public var knsn_tnt_tel_no: String?
    @NSManaged public var sales_office_code: String?
    @NSManaged public var updated_at: NSDate?

}

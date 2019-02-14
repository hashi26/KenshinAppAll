//
//  Reading_results+CoreDataProperties.swift
//  KenshinAppAll
//
//  Created by iNET TG on 2019/02/14.
//  Copyright © 2019年 KenshinT. All rights reserved.
//
//

import Foundation
import CoreData


extension Reading_results {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Reading_results> {
        return NSFetchRequest<Reading_results>(entityName: "Reading_results")
    }

    @NSManaged public var constract_started_at: String?
    @NSManaged public var created_at: NSDate?
    @NSManaged public var gas_usage: Int16
    @NSManaged public var gmt_set_no: String?
    @NSManaged public var gmt_sizi_su: Int16
    @NSManaged public var is_opend: String?
    @NSManaged public var knsn_method: String?
    @NSManaged public var knsn_tnt_emp_no: String?
    @NSManaged public var knsn_ymd: String?
    @NSManaged public var readed_at: NSDate?
    @NSManaged public var updated_at: NSDate?

}

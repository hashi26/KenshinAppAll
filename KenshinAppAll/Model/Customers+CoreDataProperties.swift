//
//  Customers+CoreDataProperties.swift
//  KenshinAppAll
//
//  Created by Harada Hiroaki on 2019/02/14.
//  Copyright © 2019 KenshinT. All rights reserved.
//
//

import Foundation
import CoreData


extension Customers {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Customers> {
        return NSFetchRequest<Customers>(entityName: "Customers")
    }

    @NSManaged public var adrs_banchi: String?
    @NSManaged public var adrs_chou: String?
    @NSManaged public var adrs_goh: String?
    @NSManaged public var apart_heya_ban_cana: String?
    @NSManaged public var b1_kikan: String?
    @NSManaged public var b1_ryo: Int16
    @NSManaged public var bb1_kikan: String?
    @NSManaged public var bb1_ryo: Int16
    @NSManaged public var bb2_kikan: String?
    @NSManaged public var bb2_ryo: Int16
    @NSManaged public var constract_started_at: String?
    @NSManaged public var created_at: NSDate?
    @NSManaged public var customer_name_cana: String?
    @NSManaged public var customer_name_kanzi: String?
    @NSManaged public var flyer_refused: String?
    @NSManaged public var gmt_set_no: String?
    @NSManaged public var goh_ban: String?
    @NSManaged public var heya_ban_cana: String?
    @NSManaged public var ichi_code: String?
    @NSManaged public var in_dog: String?
    @NSManaged public var in_dog_code: String?
    @NSManaged public var kaiheisen_code: String?
    @NSManaged public var ken_seq: String?
    @NSManaged public var knsn_method_code: String?
    @NSManaged public var knsn_tnt_emp_no: String?
    @NSManaged public var memo: String?
    @NSManaged public var meter_no: String?
    @NSManaged public var mune_ban_cana: String?
    @NSManaged public var name_j: String?
    @NSManaged public var next_date: String?
    @NSManaged public var old_gas_siji: Int16
    @NSManaged public var opened_at: String?
    @NSManaged public var out_dog: String?
    @NSManaged public var out_dog_code: String?
    @NSManaged public var service_info: String?
    @NSManaged public var tatemono_cana: String?
    @NSManaged public var tatemono_kanzi: String?
    @NSManaged public var teirei_date: String?
    @NSManaged public var tel_no: String?
    @NSManaged public var updated_at: NSDate?
    @NSManaged public var wireless_used: String?
    @NSManaged public var yago_cana: String?
    @NSManaged public var yago_kanzi: String?
    @NSManaged public var yuso_setted: String?

}

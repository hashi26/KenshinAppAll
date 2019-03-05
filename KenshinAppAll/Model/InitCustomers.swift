//
//  InitCustomers.swift
//  KenshinAppAll
//
//  Created by Takumi Takeuchi on 2019/03/05.
//  Copyright © 2019年 KenshinT. All rights reserved.
//

import Foundation

class InitCustomers {
    
    // JSONを受け取るための構造体
    struct CustomersStruct : Codable {
        let adrs_banchi         : String
        let adrs_chou           : String
        let adrs_gou            : String
        let apart_heya_ban_c    : String
        let b1_kikan            : String
        let b1_ryo              : String
        let bb1_kikan           : String
        let bb1_ryo             : String
        let bb2_kikan           : String
        let bb2_ryo             : String
        let constract_started_at: String
        let created_at          : String
        let customer_name_c     : String
        let customer_name_j     : String
        let flyer_refused       : String
        let gmt_set_no          : String
        let gou_ban             : String
        let heya_ban_c          : String
        let ichi_code           : String
        let in_dog              : String
        let in_dog_code         : String
        let kaiheisen_code      : String
        let ken_seq             : String
        let knsn_method_code    : String
        let knsn_tnt_emp_no     : String
        let memo                : String
        let meter_no            : String
        let mune_ban_c          : String
        let name_j              : String
        let next_date           : String
        let old_gas_siji        : String
        let opened_at           : String
        let out_dog             : String
        let out_dog_code        : String
        let service_info        : String
        let tatemono_c          : String
        let tatemono_j          : String
        let teirei_date         : String
        let tel_no              : String
        let updated_at          : String
        let wireless_used       : String
        let yago_c              : String
        let yago_j              : String
        let yuso_setted         : String
    }
    
    // JSONファイルからJSONを読み込み
    // decodeした構造体のリスト（=配列）を返す
    static func getInitCustomersData()  throws -> [CustomersStruct]? {
        guard let path = Bundle.main.path(forResource: "customers", ofType: "json") else { return nil }
        let url = URL(fileURLWithPath: path)
        let data = try Data(contentsOf: url)
        
        // JSONデータを構造体型にデコードする
        let notificationsStructData = try! JSONDecoder().decode([CustomersStruct].self, from: data)
        return notificationsStructData
    }
}

//
//  NotificationsJsonInsert.swift
//  KenshinAppAll
//
//  Created by Takumi Takeuchi on 2019/02/15.
//  Copyright © 2019年 KenshinT. All rights reserved.
//

import Foundation

class InitNotifications {
//    var contact_tel_no: String!
//    var contents: String!
//    var created_at: NSDate!
//    var delete_flg: Int16!
//    var from_base_code: String!
//    var from_branch_office_code: String!
//    var from_sales_office_code: String!
//    var notification_no: String!
//    var sender_name: String!
//    var supervisor_name: String!
//    var title: String!
//    var to_base_code: String!
//    var to_branch_office_code: String!
//    var to_sales_office_code: String!
//    var updated_at: NSDate!
//
    // JSONを受け取るための構造体
    struct NotiricationsStruct : Codable {
        let notification_no         : String
        let title                   : String
        let contents                : String
        let from_branch_office_code : String
        let from_sales_office_code  : String
        let from_base_code          : String
        let sender_name             : String
        let supervisor_name         : String
        let contact_tel_no          : String
        let to_branch_office_code   : String
        let to_sales_office_code    : String
        let to_base_code            : String
        let created_at              : String
        let delete_flg              : String
        let updated_at              : String
    }
    
    // JSONファイルからJSONを読み込み
    // decodeした構造体のリスト（=配列）を返す
    static func getInitNotificationsData()  throws -> [NotiricationsStruct]? {
        guard let path = Bundle.main.path(forResource: "notifications", ofType: "json") else { return nil }
        let url = URL(fileURLWithPath: path)
        let data = try Data(contentsOf: url)
        
        // JSONデータを構造体型にデコードする
        let notificationsStructData = try! JSONDecoder().decode([NotiricationsStruct].self, from: data)
        return notificationsStructData
    }
}

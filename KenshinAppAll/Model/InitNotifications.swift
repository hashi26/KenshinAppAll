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
        let contact_tel_no          : String
        let contents                : String
        let created_at              : String
        let delete_flg              : String
        let from_base_code          : String
        let from_branch_office_code : String
        let from_sales_office_code  : String
        let notification_no         : String
        let sender_name             : String
        let supervisor_name         : String
        let title                   : String
        let to_base_code            : String
        let to_branch_office_code   : String
        let to_sales_office_code    : String
        let updated_at              : String
    }
    
    // JSONファイルからJSONを読み込み
    // Notificationsのリスト（=配列）を返す
    static func getInitNotificationsData() throws -> [Notifications]? {
        guard let path = Bundle.main.path(forResource: "notifications", ofType: "json") else { return nil }
        let url = URL(fileURLWithPath: path)
        let data = try Data(contentsOf: url)
        
        // JSONデータを構造体型にデコードする
        let notificationsStructData = try! JSONDecoder().decode([NotiricationsStruct].self, from: data)
        var dataList:[Notifications] = []
        
        for obj in notificationsStructData{
            // 構造体のプロパティから各変数を作成し、インスタンスを生成
            //        for i in notificationsStructData
            let notifications:Notifications = Notifications()
            
            notifications.contact_tel_no          = obj.contact_tel_no
            notifications.contents                = obj.contents
            notifications.created_at              = dateFromString(date: obj.created_at) as NSDate
            notifications.delete_flg              = Int16(obj.delete_flg)!
            notifications.from_base_code          = obj.from_base_code
            notifications.from_branch_office_code = obj.from_branch_office_code
            notifications.from_sales_office_code  = obj.from_sales_office_code
            notifications.notification_no         = obj.notification_no
            notifications.sender_name             = obj.sender_name
            notifications.supervisor_name         = obj.supervisor_name
            notifications.title                   = obj.title
            notifications.to_base_code            = obj.to_base_code
            notifications.to_branch_office_code   = obj.to_branch_office_code
            notifications.to_sales_office_code    = obj.to_sales_office_code
            notifications.updated_at              = dateFromString(date: obj.updated_at) as NSDate
            dataList.append(notifications)
        }
        
        return dataList
    }
    
    // StringからDateへの日付変換処理
    static func dateFromString(date:String) -> Date{
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        print("dateFromString:\(date)")
        let returnValue:Date = df.date(from: date)! as Date
        return returnValue
    }
}

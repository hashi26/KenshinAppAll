//
//  initReadingPerson.swift
//  KenshinAppAll
//
//  Created by TomonariNonaka on 2019/02/20.
//  Copyright © 2019 KenshinT. All rights reserved.
//

import Foundation

class initReadingPerson{
    
    struct ReadingPersonStruct : Codable {
        let base_code          : String // 基地コード
        let branch_office_code : String // 支社コード
        let created_at         : String // 登録日時
        let knsn_tnt_emp_no    : String // 検針担当者番号
        let knsn_tnt_name      : String // 検針担当者氏名
        let knsn_tnt_pass      : String // 検針担当者パスワード
        let knsn_tnt_tel_no    : String // 検針担当者電話番号
        let sales_office_code  : String //
        let updated_at         : String // 更新日時
    }

    // JSONファイルからJSONを読み込み
    // ReadingPersonのリスト（=配列）を返す
    static func getInitReadingPersonData() throws -> [Reading_person]? {
        guard let path = Bundle.main.path(forResource: "readingperson", ofType: "json") else { return nil }
        let url = URL(fileURLWithPath: path)
        let data = try Data(contentsOf: url)
        
        // JSONデータを構造体型にデコードする
        let readingPersonStructData = try! JSONDecoder().decode([ReadingPersonStruct].self, from: data)
        var dataList:[Reading_person] = []
        
        for obj in readingPersonStructData{
            // 構造体のプロパティから各変数を作成し、インスタンスを生成
            //        for i in notificationsStructData
            let readingPersons:Reading_person = Reading_person()
            
            readingPersons.base_code          = obj.base_code
            readingPersons.branch_office_code = obj.branch_office_code
            readingPersons.created_at         = dateFromString(date: obj.created_at) as NSDate
            readingPersons.knsn_tnt_emp_no    = obj.knsn_tnt_emp_no
            readingPersons.knsn_tnt_name      = obj.knsn_tnt_name
            readingPersons.knsn_tnt_pass      = obj.knsn_tnt_pass
            readingPersons.knsn_tnt_tel_no    = obj.knsn_tnt_tel_no
            readingPersons.sales_office_code  = obj.sales_office_code
            readingPersons.updated_at         = dateFromString(date: obj.updated_at) as NSDate
            dataList.append(readingPersons)
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

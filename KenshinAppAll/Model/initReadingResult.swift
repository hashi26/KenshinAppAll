//
//  initReadingResult.swift
//  KenshinAppAll
//
//  Created by iNET TG on 2019/02/26.
//  Copyright © 2019年 KenshinT. All rights reserved.
//

import Foundation

class InitReadingResult {

    // JSONを受け取るための構造体
    struct ReadingResultStruct : Codable {
        //ガスメータ設置場所番号
        let gmt_set_no : String
        //検針年月日
        let knsn_ymd : String
        //メーター指示数
        let gmt_sizi_su : Int16
        //開閉栓状態
        let is_opend : String
        //ガス使用量
        let gas_usage : Int16
        //検針担当者番号
        let knsn_tnt_emp_no : String
        //契約開始年月日
        let constract_started_at : String
        //検針方法コード
        let knsn_method : String
        //当日検針日時
        let readed_at : Date
        //登録日時
        let created_at : Date
        //更新日時
        let updated_at : Date
    }
    
    // JSONファイルからJSONを読み込み
    // Notificationsのリスト（=配列）を返す
    static func getInitReadingResultData() throws -> [Reading_results]? {
        guard let path = Bundle.main.path(forResource: "neadingResult", ofType: "json") else { return nil }
        let url = URL(fileURLWithPath: path)
        let data = try Data(contentsOf: url)
        
        // JSONデータを構造体型にデコードする
        let readingResultStructData = try! JSONDecoder().decode([ReadingResultStruct].self, from: data)
        var dataList:[Reading_results] = []
        
        for obj in readingResultStructData{
            // 構造体のプロパティから各変数を作成し、インスタンスを生成
            //        for i in notificationsStructData
            let readingResult:Reading_results = Reading_results()
            
            readingResult.gmt_set_no = obj.gmt_set_no
            readingResult.knsn_ymd = obj.knsn_ymd
            readingResult.gmt_sizi_su = obj.gmt_sizi_su
            readingResult.is_opend = obj.is_opend
            readingResult.gas_usage = obj.gas_usage
            readingResult.knsn_tnt_emp_no = obj.knsn_tnt_emp_no
            readingResult.constract_started_at = obj.constract_started_at
            readingResult.knsn_method = obj.knsn_method
            readingResult.readed_at = Date() as NSDate
            readingResult.created_at = Date() as NSDate
            readingResult.updated_at = Date() as NSDate

            dataList.append(readingResult)
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

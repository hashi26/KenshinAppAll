//
//  GohJsonInsert.swift
//  KenshinAppAll
//
//  Created by Harada Hiroaki on 2019/02/16.
//  Copyright © 2019 KenshinT. All rights reserved.
//

import Foundation
/*
class GohJsonInsert: Codable {
    //所在地行政区画CD
    let locations_code: String
    //号番号
    let gou_ban: String
    
    //町名・カナ
    let towns_name_c: String
    //町名・漢字
    let towns_name_j: String
    //登録日時
    let created_at: String
    //let created_at: Date
    //更新日時
    let updated_at: String
    //let updated_at: Date?
    
    init(locations_code: String, gou_ban: String,towns_name_c:String,towns_name_j:String,created_at:String,updated_at:String
        ){
        self.locations_code = locations_code
        self.gou_ban = gou_ban
        self.towns_name_c = towns_name_c
        self.towns_name_j = towns_name_j
        self.created_at = created_at
        self.updated_at = updated_at
    }
}
*/
class GohJsoninsert{
    struct GohStruct : Codable{
        let locations_code        : String
        let gou_ban               : String
        let towns_name_c          : String
        let towns_name_j          : String
        let created_at            : Date
        let updated_at            : Date
        
        // JSONファイルからJSONを読み込み
        // Notificationsのリスト（＝配列）を返す
        static func getIntGohData() throws -> [Goh]? {
            guard let path = Bundle.main.path(forResource: "notifications",ofType: "json") else {
                return nil}
            let url = URL(fileURLWithPath: path)
            let data = try Data(contentsOf: url)
            
            // JSONデータを構造体型いにデコードする
            let gohStructData = try! JSONDecoder().decode([GohStruct].self, from:data)
            var dataList:[Goh] = []
            
            for obj in gohStructData{
                //構造体のプロパティから各変数を作成し、インスタンスを作成
                let goh:Goh = Goh()
                
                goh.locations_code = obj.locations_code
                goh.gou_ban = obj.gou_ban
                goh.towns_name_c = obj.towns_name_c
                goh.towns_name_j = obj.towns_name_j
                goh.created_at = obj.created_at as NSDate
                goh.updated_at = obj.updated_at as NSDate
                dataList.append(goh)
            }
            
            return dataList
        }
        
        //StringからDateへの日付変換処理は、InitNotificationsで実装しているため記載不要
}
}

//
//  GohClass.swift
//  KenshinAppAll
//
//  Created by Harada Hiroaki on 2019/02/08.
//  Copyright © 2019 KenshinT. All rights reserved.
//

import Foundation
import CoreData //NSManagedObjectContext利用のため
import UIKit  //UIApplication利用のため

class GohClass: Codable {
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

//GohClass用のJCLを読み込むメソッド
func readGohClassJson() -> [GohClass]{
    var goh: [GohClass] = []
    guard let data1 = try? getJSONData1() else { return goh}
    //print(data1)
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    goh = try! decoder.decode([GohClass].self, from: data1!)
    return goh
}

func sampleFunc() {
    print("sample")
}

//GohClassテーブルからデータを全件取得するメソッド
func readGohClass() -> [Goh]{
    
    let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    let context:NSManagedObjectContext = appDelegate.managedObjectContext
    
    var goh: [Goh] = []
    let fetchRequest:NSFetchRequest<Goh> = Goh.fetchRequest()
    let fetchData = try! context.fetch(fetchRequest)
    if(!fetchData.isEmpty){
        for i in 0..<fetchData.count{
            goh.append(fetchData[i])
        }
    }
   return goh
}

//GohClassのjsonを読み込むための処理
//forResource:jsonのファイル名
func getJSONData1() throws -> Data? {
    guard let path = Bundle.main.path(forResource: "goh", ofType: "json") else { return nil }
    let url = URL(fileURLWithPath: path)
    
    return try Data(contentsOf: url)
}

//GohClassからGohへ変換するためのメソッド
func gohClassToGoh(gohClass:GohClass) -> Goh{
    let goh = Goh()
    goh.created_at = Date() as NSDate
    goh.gou_ban = gohClass.gou_ban
    goh.locations_code = gohClass.locations_code
    goh.towns_name_c = gohClass.towns_name_c
    goh.towns_name_j = gohClass.towns_name_j
    goh.updated_at = Date() as NSDate
    
    return goh
}

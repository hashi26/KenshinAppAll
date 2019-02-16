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


//GohClass用のJCLを読み込むメソッド
func readGohClassJson() -> [GohJsonInsert]{
    var goh: [GohJsonInsert] = []
    guard let data1 = try? getJSONData1() else { return goh}
    //print(data1)
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    goh = try! decoder.decode([GohJsonInsert].self, from: data1!)
    return goh
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
func gohClassToGoh(gohClass:GohJsonInsert) -> Goh{
    let goh = Goh()
    goh.created_at = Date() as NSDate
    goh.gou_ban = gohClass.gou_ban
    goh.locations_code = gohClass.locations_code
    goh.towns_name_c = gohClass.towns_name_c
    goh.towns_name_j = gohClass.towns_name_j
    goh.updated_at = Date() as NSDate
    
    return goh
}

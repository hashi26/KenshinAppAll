//
//  ReadingResultClass.swift
//  KenshinAppAll
//
//  Created by iNET TG on 2019/02/08.
//  Copyright © 2019年 KenshinT. All rights reserved.
//

import CoreData
import UIKit
import Foundation

//ReadingResultClass用のJCLを読み込むメソッド
func readReadingResultClassJson() -> [ReadingResultJsonInsert]{
    var readingResult: [ReadingResultJsonInsert] = []
    guard let data1 = try? getJSONData1() else { return readingResult}
    //print(data1)
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    readingResult = try! decoder.decode([ReadingResultJsonInsert].self, from: data1!)
    return readingResult
}

//Reading_resultテーブルからデータを全件取得するメソッド
func readReadingResultClass() -> [Reading_results]{
    
    let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    let context:NSManagedObjectContext = appDelegate.managedObjectContext
    
    var readingResult: [Reading_results] = []
    let fetchRequest:NSFetchRequest<Reading_results> = Reading_results.fetchRequest()
    let fetchData = try! context.fetch(fetchRequest)
    if(!fetchData.isEmpty){
        for i in 0..<fetchData.count{
            readingResult.append(fetchData[i])
        }
    }
    return readingResult
}

//ReadingResultClassのjsonを読み込むための処理
//forResource:jsonのファイル名
func getReadingResultJSONData1() throws -> Data? {
    guard let path = Bundle.main.path(forResource: "readingResult", ofType: "json") else { return nil }
    let url = URL(fileURLWithPath: path)
    
    return try Data(contentsOf: url)
}

//ReadingResultClassからGohへ変換するためのメソッド
func readingResultClassToReadingResult(readingResultClass:ReadingResultJsonInsert) -> Reading_results{
    let readingResult = Reading_results()
    readingResult.gmt_set_no = readingResultClass.gmt_set_no
    readingResult.knsn_ymd = readingResultClass.knsn_ymd
    readingResult.gmt_sizi_su = readingResultClass.gmt_sizi_su
    readingResult.is_opend = readingResultClass.is_opend
    readingResult.gas_usage = readingResultClass.gas_usage
    readingResult.knsn_tnt_emp_no = readingResultClass.knsn_tnt_emp_no
    readingResult.constract_started_at = readingResultClass.constract_started_at
    readingResult.knsn_method = readingResultClass.knsn_method
    readingResult.readed_at = Date() as NSDate
    readingResult.created_at = Date() as NSDate
    readingResult.updated_at = Date() as NSDate
    
    return readingResult
}

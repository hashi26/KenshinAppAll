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

class ReadingResultClass {
    
    var persistentContainer:NSPersistentContainer!
    let context:NSManagedObjectContext!
    
    init(completionClosure: @escaping () -> ()) {
        persistentContainer = NSPersistentContainer(name: "KenshinCD")
        persistentContainer.loadPersistentStores() { (description, error) in
            if let error = error {
                fatalError("ReadingResultClass.init()が失敗しました: \(error)")
            }
            completionClosure()
        }
        context = persistentContainer.viewContext
    }
    
    // 全件検索
    func selectReadingResult() -> [Reading_results] {
        let readingResultFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "ReadingResult")
        
        do {
            let fetchedReadingResult = try context.fetch(readingResultFetch) as! [Reading_results]
            return fetchedReadingResult
        } catch {
            fatalError("ReadingResultClass.selectReadingResult()が失敗しました: \(error)")
        }
        return []
    }
    
    // 追加
    func insertReadingResult(readingResult : Reading_results) {
        NSEntityDescription.insertNewObject(forEntityName: "ReadingResult", into: context)
        saveReadingResult()
    }
    
    // 初期データ追加
    // アプリ起動時にjsonからお知らせ一覧を作成し、CoreDataにinsertする
    func initInsertReadingResult(readingResult : Reading_results) {
        do {
            // Insert前にCoreData内にデータが存在するかを確認し、
            // データが存在する場合　：何もしない
            // データが存在しない場合：データをInsertする
            let resultSelectReadingResult = selectReadingResult()
            if resultSelectReadingResult.isEmpty {}
            else {
                let readingResultInsertData = try InitReadingResult.getInitReadingResultData()
                for obj in readingResultInsertData! {
                    insertReadingResult(readingResult: obj)
                }
            }
        } catch {
            fatalError("ReadingResultClass.initInsetReadingResult()が失敗しました : \(error)")
        }
    }
    
    // 保存
    func saveReadingResult() {
        if context.hasChanges {
            do {
                try context.save();
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
    
}





/*
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

//ReadingResultClassからReadingResultへ変換するためのメソッド
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
*/

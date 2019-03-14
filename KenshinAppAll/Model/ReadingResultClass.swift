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
    
    init() {
        persistentContainer = NSPersistentContainer(name: "KenshinCD")
        persistentContainer.loadPersistentStores() { (description, error) in
            if let error = error {
                fatalError("ReadingResultClass.init()が失敗しました: \(error)")
            }
        }
        context = persistentContainer.viewContext
    }
    
    // 全件検索
    func selectReadingResult() -> [Reading_results] {
        let readingResultFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Reading_results")
        
        do {
            let fetchedReadingResult = try context.fetch(readingResultFetch) as! [Reading_results]
            return fetchedReadingResult
        } catch {
            fatalError("ReadingResultClass.selectReadingResult()が失敗しました: \(error)")
        }
        return []
    }
    
    // ガスメータ設置場所番号を指定して検索
    func selectReadingResultByGmtSetNo(gmt_set_no:String) -> [Reading_results] {
        let readingResultFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Reading_results")
        
        // 条件指定
        let predicate = NSPredicate(format: "%K = %@","gmt_set_no", gmt_set_no)
        readingResultFetch.predicate = predicate
        
        do {
            let fetchedReadingResult = try self.context.fetch(readingResultFetch)
            return fetchedReadingResult as! [Reading_results]
        } catch {
            fatalError("ReadingResultClass.selectReadingResultByGmtSetNo()が失敗しました: \(error)")
        }
        return []
    }
    
    // 追加
    func insertReadingResult(otifications : Reading_results) {
        //NSEntityDescription.insertNewObject(forEntityName: "Reading_results", into: context) 変更前
        
        let insertEntity = NSEntityDescription.insertNewObject(forEntityName: "Reading_results", into: context) as! Reading_results

        insertEntity.gmt_set_no = otifications.gmt_set_no
        insertEntity.constract_started_at = otifications.constract_started_at
        insertEntity.gas_usage = otifications.gas_usage
        insertEntity.gmt_sizi_su = otifications.gmt_sizi_su
        insertEntity.is_opend = otifications.is_opend
        insertEntity.knsn_method = otifications.knsn_method
        insertEntity.knsn_tnt_emp_no = otifications.knsn_tnt_emp_no
        insertEntity.knsn_ymd = otifications.knsn_ymd
        insertEntity.readed_at = otifications.readed_at
        insertEntity.updated_at = otifications.updated_at
        insertEntity.created_at = otifications.created_at
        
        //値は入ってるかな？
        print("↓↓↓coredata登録前の変数に値は入ってる？")
        print("insertEntity.gmt_set_no",insertEntity.gmt_set_no)
        print("insertEntity.constract_started_at",insertEntity.constract_started_at)
        print("insertEntity.gas_usage",insertEntity.gas_usage)
        print("insertEntity.gmt_sizi_su",insertEntity.gmt_sizi_su)
        print("insertEntity.is_opend",insertEntity.is_opend)
        print("insertEntity.knsn_method",insertEntity.knsn_method)
        print("insertEntity.knsn_tnt_emp_no",insertEntity.knsn_tnt_emp_no)
        print("insertEntity.knsn_ymd",insertEntity.knsn_ymd)
        print("insertEntity.readed_at",insertEntity.readed_at)
        print("insertEntity.updated_at",insertEntity.updated_at)
        print("insertEntity.created_at",insertEntity.created_at)
        
        
        print("context",context)

        saveReadingResult()
    }
    
    // 初期データ追加
    // アプリ起動時にjsonからお知らせ一覧を作成し、CoreDataにinsertする
    func initInsertReadingResult() {
        do {
            // Insert前にCoreData内にデータが存在するかを確認し、
            // データが存在する場合　：何もしない
            // データが存在しない場合：データをInsertする
            if (selectReadingResult()).isEmpty {
                print("*** initInsertReadingResult が実行されます。")
                let readingResultInsertData = try InitReadingResult.getInitReadingResultData()
                
                // 構造体のプロパティから各変数を作成し、インスタンスを生成
                for obj in readingResultInsertData!{
                    let insertEntity = NSEntityDescription.insertNewObject(forEntityName: "Reading_results", into: context)
                    insertEntity.setValue(obj.constract_started_at, forKey: "constract_started_at")
                    insertEntity.setValue(Int16(obj.gas_usage), forKey: "gas_usage")
                    insertEntity.setValue(obj.gmt_set_no, forKey: "gmt_set_no")
                    insertEntity.setValue(dateFromString(date: obj.created_at)! as NSDate, forKey: "created_at")
                    insertEntity.setValue(obj.knsn_ymd, forKey: "knsn_ymd")
                    insertEntity.setValue(Int16(obj.gmt_sizi_su), forKey: "gmt_sizi_su")
                    insertEntity.setValue(obj.is_opend, forKey: "is_opend")
                    insertEntity.setValue(Int16(obj.gas_usage), forKey: "gas_usage")
                    insertEntity.setValue(obj.knsn_tnt_emp_no, forKey: "knsn_tnt_emp_no")
                    insertEntity.setValue(obj.knsn_method, forKey: "knsn_method")
                    if (obj.updated_at != "") {
                        insertEntity.setValue(dateFromString(date: obj.updated_at)! as NSDate, forKey: "updated_at")
                    }
                    saveReadingResult()
                }
            } else {
                print("*** initInsertNotifications が実行されませんでした。coredataにデータが存在します。 ")
            }
        } catch {
            fatalError("*** NotificationsClass.initInsetNotifications()が失敗しました : \(error)")
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
    
    // 削除
    func deleteReadingResult(delObj : Reading_results) {
        context.delete(delObj)
        saveReadingResult()
    }
    
    // 全削除
    func deleteReadingResultALL() {
        let result = selectReadingResult()
        for delObj in result {
            context.delete(delObj)
            saveReadingResult()
        }
    }
    
    // StringからDateへの日付変換処理
    func dateFromString(date:String) -> Date!{
        if date == "" {
            return nil
        } else {
            let df = DateFormatter()
            df.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let returnValue:Date = df.date(from: date)! as Date
            return returnValue
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

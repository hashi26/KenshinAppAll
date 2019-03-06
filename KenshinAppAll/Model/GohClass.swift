//
//  NotificationsClass.swift
//  KenshinAppAll
//
//  Created by Takumi Takeuchi on 2019/02/12.
//  Copyright © 2019年 KenshinT. All rights reserved.
//
import Foundation
import CoreData

class GohClass {
    var persistentContainer:NSPersistentContainer!
    let context:NSManagedObjectContext!
    
    
    
    init(){
        persistentContainer = NSPersistentContainer(name: "KenshinCD")
        persistentContainer.loadPersistentStores() { (description, error) in
            if let error = error {
                fatalError("NotificationsClass.init()が失敗しました: \(error)")
            }
        }
        context = persistentContainer.viewContext
    }
    
    // 全件検索
    func selectGoh() -> [Goh] {
        let GohFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Goh")
        //let sortDescripter = NSSortDescriptor(key: "updated_at", ascending: false)//ascendind:true 昇順、false 降順です
        //gohFetch.sortDescriptors = [sortDescripter]
        
        do {
            let fetchedGoh = try context.fetch(GohFetch) as! [Goh]
            return fetchedGoh
        } catch {
            fatalError("GohClass.selectGoh()が失敗しました: \(error)")
        }
        return []
    }
    
    // 追加
    func insertGoh(otifications : Goh) {
        NSEntityDescription.insertNewObject(forEntityName: "Goh", into: context)
        saveGoh()
    }
    
    // 初期データ追加
    // アプリ起動時にjsonからお知らせ一覧を作成し、CoreDataにinsertする
    func initInsertGoh() {
        do {
            // Insert前にCoreData内にデータが存在するかを確認し、
            // データが存在する場合　：何もしない
            // データが存在しない場合：データをInsertする
            if (selectGoh()).isEmpty {
                print("*** initInsertGoh が実行されます。")
                let gohInsertData = try GohJsoninsert.getInitGohData()
                
                // 構造体のプロパティから各変数を作成し、インスタンスを生成
                for obj in gohInsertData!{
                    let insertEntity = NSEntityDescription.insertNewObject(forEntityName: "Goh", into: context)
                    insertEntity.setValue(obj.locations_code, forKey: "locations_code")
                    insertEntity.setValue(obj.gou_ban, forKey: "gou_ban")
                    insertEntity.setValue(dateFromString(date: obj.created_at)! as NSDate, forKey: "created_at")
                    insertEntity.setValue(obj.towns_name_c, forKey: "towns_name_c")
                    insertEntity.setValue(obj.towns_name_j, forKey: "towns_name_j")
                    if (obj.updated_at != "") {
                        insertEntity.setValue(dateFromString(date: obj.updated_at)! as NSDate, forKey: "updated_at")
                    }
                    saveGoh()
                }
            } else {
                print("*** initInsertGoh が実行されませんでした。coredataにデータが存在します。 ")
            }
        } catch {
            fatalError("*** GohClass.initInsetGoh()が失敗しました : \(error)")
        }
    }
    
    // 削除
    func deleteGoh(delObj : Goh) {
        context.delete(delObj)
        saveGoh()
    }
    
    // 全削除
    func deleteGohALL() {
        let result = selectGoh()
        for delObj in result {
            context.delete(delObj)
            saveGoh()
        }
    }
    
    // 保存
    func saveGoh() {
        if context.hasChanges {
            do {
                try context.save();
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func dateFromString(date:String) -> Date!{
        if date == ""{
            return nil
        }else {
            let df = DateFormatter()
            df.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let retrunValue:Date = df.date(from: date)! as Date
            return retrunValue
        }
    }
    
}

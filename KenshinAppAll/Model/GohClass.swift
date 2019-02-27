//
//  GohClass.swift
//  KenshinAppAll
//
//  Created by Harada Hiroaki on 2019/02/08.
//  Copyright © 2019 KenshinT. All rights reserved.
//

import Foundation
import CoreData //NSManagedObjectContext利用のため

class GohClass{
    var persistentContainer:NSPersistentContainer!
    let context:NSManagedObjectContext!
    
    //初期化
    init(completionClosure: @escaping () -> ()) {
        persistentContainer = NSPersistentContainer(name: "KenshinCD")
        persistentContainer.loadPersistentStores() { (description, error) in
            if let error = error {
                fatalError("GohClass.init()が失敗しました: \(error)")
            }
            completionClosure()
        }
        context = persistentContainer.viewContext
    }
    
    // 全件検索
    func selectCustomers() -> [Goh] {
        let customersFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Goh")
        
        do {
            let fetchedGoh = try context.fetch(customersFetch) as! [Goh]
            return fetchedGoh
        } catch {
            fatalError("CustomerGoh.selectGoh()が失敗しました: \(error)")
        }
        return []
    }
    
    // 号番号を指定して検索
    func selectGohByGohBan(gou_ban:String) -> [Goh] {
        let gohFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Goh")
        
        // 条件指定
        gohFetch.predicate = NSPredicate(format: "gou_ban = ’\(gou_ban)’")
        
        do {
            let fetchedGoh = try context.fetch(gohFetch) as! [Goh]
            return fetchedGoh
        } catch {
            fatalError("GohClass.selectGohByGohBan()が失敗しました: \(error)")
        }
        return []
    }
    
    // 追加
    func insertCustomers() -> Goh{
        let goh = NSEntityDescription.insertNewObject(forEntityName: "Goh", into: context) as! Goh
        saveGoh()
        return goh
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
}

/*
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
*/
//GohClassのjsonを読み込むための処理
//forResource:jsonのファイル名
func getJSONData1() throws -> Data? {
    guard let path = Bundle.main.path(forResource: "goh", ofType: "json") else { return nil }
    let url = URL(fileURLWithPath: path)
    
    return try Data(contentsOf: url)
}

//GohClassからGohへ変換するためのメソッド
/*func gohClassToGoh(gohClass:GohJsonInsert) -> Goh{
    let goh = Goh()
    goh.created_at = Date() as NSDate
    goh.gou_ban = gohClass.gou_ban
    goh.locations_code = gohClass.locations_code
    goh.towns_name_c = gohClass.towns_name_c
    goh.towns_name_j = gohClass.towns_name_j
    goh.updated_at = Date() as NSDate
    
    return goh
}*/

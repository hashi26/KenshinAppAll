//
//  ReadingPersonClass.swift
//  KenshinAppAll
//
//  Created by Harada Hiroaki on 2019/02/14.
//  Copyright © 2019 KenshinT. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class ReadingPersonClass {
    //    @NSManaged public var contact_tel_no: String?
    //    @NSManaged public var contents: String?
    //    @NSManaged public var created_at: NSDate?
    //    @NSManaged public var delete_flg: Int16
    //    @NSManaged public var from_base_code: String?
    //    @NSManaged public var from_branch_office_code: String?
    //    @NSManaged public var from_sales_office_code: String?
    //    @NSManaged public var notification_no: String?
    //    @NSManaged public var sender_name: String?
    //    @NSManaged public var supervisor_name: String?
    //    @NSManaged public var title: String?
    //    @NSManaged public var to_base_code: String?
    //    @NSManaged public var to_branch_office_code: String?
    //    @NSManaged public var to_sales_office_code: String?
    //    @NSManaged public var updated_at: NSDate?
    
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
    func selectReadingPerson() -> [Reading_person]{
        let readingPersonFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Reading_person")
        let sortDescripter = NSSortDescriptor(key: "updated_at", ascending: false)//ascendind:true 昇順、false 降順です
        readingPersonFetch.sortDescriptors = [sortDescripter]
        
        do {
            let fetchedReadingPerson = try context.fetch(readingPersonFetch) as! [Reading_person]
            return fetchedReadingPerson
        } catch {
            fatalError("ReadingPersonClass.selectReadingPerson()が失敗しました: \(error)")
        }
        return []
    }
    
    // 追加
    func insertReadingPerson(otifications : Reading_person) {
        NSEntityDescription.insertNewObject(forEntityName: "Reading_person", into: context)
        saveReadingPerson()
    }
    
    // 検針担当者を指定して検索
    func selectReadingPersonByKnsnTntEmpNo(knsn_tnt_emp_no:String) -> [Reading_person] {
        let readingPersonFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Reading_person")
        
        // 条件指定
        readingPersonFetch.predicate = NSPredicate(format: "knsn_tnt_emp_no = '\(knsn_tnt_emp_no)'")
        
        do {
            let fetchedReadingPerson = try context.fetch(readingPersonFetch) as! [Reading_person]
            return fetchedReadingPerson
        } catch {
            fatalError("selectReadingPersonByKnsnTntEmpNo()が失敗しました: \(error)")
        }
        return []
    }
    
    
    // 初期データ追加
    // アプリ起動時にjsonからお知らせ一覧を作成し、CoreDataにinsertする
    func initInsertReadingPerson() {
        do {
            // Insert前にCoreData内にデータが存在するかを確認し、
            // データが存在する場合　：何もしない
            // データが存在しない場合：データをInsertする
            if (selectReadingPerson()).isEmpty {
                print("*** initInsertReadingPerson が実行されます。")
                let readingPersonInsertData = try initReadingPerson.getInitReadingPersonData()
                
                // 構造体のプロパティから各変数を作成し、インスタンスを生成
                for obj in readingPersonInsertData!{
                    let insertEntity = NSEntityDescription.insertNewObject(forEntityName: "Reading_person", into: context)
                    insertEntity.setValue(obj.branch_office_code, forKey: "branch_office_code")
                    insertEntity.setValue(obj.knsn_tnt_emp_no, forKey: "knsn_tnt_emp_no")
                    insertEntity.setValue(obj.knsn_tnt_name, forKey: "knsn_tnt_name")
                    insertEntity.setValue(obj.knsn_tnt_pass, forKey: "knsn_tnt_pass")
                    insertEntity.setValue(obj.knsn_tnt_tel_no, forKey: "knsn_tnt_tel_no")
                    insertEntity.setValue(obj.sales_office_code, forKey: "sales_office_code")

                    insertEntity.setValue(dateFromString(date: obj.created_at)! as NSDate, forKey: "created_at")
                    if (obj.updated_at != "") {
                        insertEntity.setValue(dateFromString(date: obj.updated_at)! as NSDate, forKey: "updated_at")
                    }
                    saveReadingPerson()
                }
            } else {
                print("*** initInsertReadingPerson が実行されませんでした。coredataにデータが存在します。 ")
            }
        } catch {
            fatalError("*** ReadingPersonClass.initInsertReadingPerson()が失敗しました : \(error)")
        }
    }
    
    // 削除
    func deleteReadingPerson(delObj : Reading_person) {
        context.delete(delObj)
        saveReadingPerson()
    }
    
    // 全削除
    func deleteReadingPersonALL() {
        let result = selectReadingPerson()
        for delObj in result {
            context.delete(delObj)
            saveReadingPerson()
        }
    }
    
    // 保存
    func saveReadingPerson() {
        if context.hasChanges {
            do {
                try context.save();
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
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
class ReadingPersonClass: Codable {
    //
    let base_code: String
    let branch_office_code: String
    let created_at: Date
    let knsn_tnt_emp_no: String
    let knsn_tnt_name: String
    let knsn_tnt_pass: String
    let knsn_tnt_tel_no: String
    let sales_office_code: String
    let updated_at: Date
    
    init(base_code : String ,
         branch_office_code : String ,
         created_at : Date ,
         knsn_tnt_emp_no : String ,
         knsn_tnt_name : String ,
         knsn_tnt_pass : String ,
         knsn_tnt_tel_no : String ,
         sales_office_code : String ,
         updated_at : Date
        ){
        self.base_code = base_code
        self.branch_office_code = branch_office_code
        self.created_at = created_at
        self.knsn_tnt_emp_no = knsn_tnt_emp_no
        self.knsn_tnt_name = knsn_tnt_name
        self.knsn_tnt_pass = knsn_tnt_pass
        self.knsn_tnt_tel_no = knsn_tnt_tel_no
        self.sales_office_code = sales_office_code
        self.updated_at = updated_at
    }
}

//ReadingPersonClass用のJsonを読み込むメソッド
/*func readReadingPersonClassJson() -> [ReadingPersonClass]{
    var readingPersonData: [ReadingPersonClass] = []
    guard let data1 = try? getJSONData1() else { return readingPersonData}
    //print(data1)
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    readingPersonData = try! decoder.decode([ReadingPersonClass].self, from: data1!)
    return readingPersonData
}*/

//Reading_personテーブルからデータを全件取得するメソッド
func readReadingPersonClass() -> [Reading_person]{
    
    let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    let context:NSManagedObjectContext = appDelegate.managedObjectContext
    
    var readingPerson: [Reading_person] = []
    let fetchRequest:NSFetchRequest<Reading_person> = Reading_person.fetchRequest()
    let fetchData = try! context.fetch(fetchRequest)
    if(!fetchData.isEmpty){
        for i in 0..<fetchData.count{
            readingPerson.append(fetchData[i])
        }
    }
    return readingPerson
}

//ReadingPersonClassのjsonを読み込むための処理
//forResource:jsonのファイル名
func getReadingPersonJSONData1() throws -> Data? {
    guard let path = Bundle.main.path(forResource: "readingPerson", ofType: "json") else { return nil }
    let url = URL(fileURLWithPath: path)
    
    return try Data(contentsOf: url)
}

//ReadingPersonClassからReadingPersonへ変換するためのメソッド
func readingPersonClassToReadingPerson(readingPersonClass:ReadingPersonClass) -> Reading_person{
    let readingPerson = Reading_person()
    readingPerson.base_code = readingPersonClass.base_code
    readingPerson.branch_office_code = readingPersonClass.branch_office_code
    readingPerson.created_at = Date() as NSDate
    readingPerson.knsn_tnt_emp_no = readingPersonClass.knsn_tnt_emp_no
    readingPerson.knsn_tnt_name = readingPersonClass.knsn_tnt_name
    readingPerson.knsn_tnt_pass = readingPersonClass.knsn_tnt_pass
    readingPerson.knsn_tnt_tel_no = readingPersonClass.knsn_tnt_tel_no
    readingPerson.sales_office_code = readingPersonClass.sales_office_code
    readingPerson.updated_at = Date() as NSDate

    return readingPerson
}
*/

//
//  NotificationsClass.swift
//  KenshinAppAll
//
//  Created by Takumi Takeuchi on 2019/02/12.
//  Copyright © 2019年 KenshinT. All rights reserved.
//

import Foundation
import CoreData

class NotificationsClass {
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
    func selectNotifications() -> [Notifications] {
        let notificationsFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Notifications")
        let sortDescripter = NSSortDescriptor(key: "updated_at", ascending: false)//ascendind:true 昇順、false 降順です
        notificationsFetch.sortDescriptors = [sortDescripter]
        
        do {
            let fetchedNotifications = try context.fetch(notificationsFetch) as! [Notifications]
            return fetchedNotifications
        } catch {
            fatalError("NotificationsClass.selectNotifications()が失敗しました: \(error)")
        }
        return []
    }
    
    // 追加
    func insertNotifications(otifications : Notifications) {
        NSEntityDescription.insertNewObject(forEntityName: "Notifications", into: context)
        saveNotifications()
    }
    
    // 初期データ追加
    // アプリ起動時にjsonからお知らせ一覧を作成し、CoreDataにinsertする
    func initInsertNotifications() {
        do {
            // Insert前にCoreData内にデータが存在するかを確認し、
            // データが存在する場合　：何もしない
            // データが存在しない場合：データをInsertする
            if (selectNotifications()).isEmpty {
                print("*** initInsertNotifications が実行されます。")
                let notificationsInsertData = try InitNotifications.getInitNotificationsData()
                
                // 構造体のプロパティから各変数を作成し、インスタンスを生成
                for obj in notificationsInsertData!{
                    let insertEntity = NSEntityDescription.insertNewObject(forEntityName: "Notifications", into: context)
                    insertEntity.setValue(obj.contact_tel_no, forKey: "contact_tel_no")
                    insertEntity.setValue(obj.contents, forKey: "contents")
                    insertEntity.setValue(dateFromString(date: obj.created_at)! as NSDate, forKey: "created_at")
                    insertEntity.setValue(Int16(obj.delete_flg), forKey: "delete_flg")
                    insertEntity.setValue(obj.from_base_code, forKey: "from_base_code")
                    insertEntity.setValue(obj.from_branch_office_code, forKey: "from_branch_office_code")
                    insertEntity.setValue(obj.notification_no, forKey: "notification_no")
                    insertEntity.setValue(obj.sender_name, forKey: "sender_name")
                    insertEntity.setValue(obj.supervisor_name, forKey: "supervisor_name")
                    insertEntity.setValue(obj.title, forKey: "title")
                    insertEntity.setValue(obj.to_base_code, forKey: "to_base_code")
                    insertEntity.setValue(obj.to_branch_office_code, forKey: "to_branch_office_code")
                    insertEntity.setValue(obj.to_sales_office_code, forKey: "to_sales_office_code")
                    if (obj.updated_at != "") {
                        insertEntity.setValue(dateFromString(date: obj.updated_at)! as NSDate, forKey: "updated_at")
                    }
                    saveNotifications()
                }
            } else {
                print("*** initInsertNotifications が実行されませんでした。coredataにデータが存在します。 ")
            }
        } catch {
            fatalError("*** NotificationsClass.initInsetNotifications()が失敗しました : \(error)")
        }
    }
    
    // 削除
    func deleteNotifications(delObj : Notifications) {
        context.delete(delObj)
        saveNotifications()
    }
    
    // 全削除
    func deleteNotificationsALL() {
        let result = selectNotifications()
        for delObj in result {
            context.delete(delObj)
            saveNotifications()
        }
    }
    
    // 保存
    func saveNotifications() {
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

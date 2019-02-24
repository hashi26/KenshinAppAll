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

    init(completionClosure: @escaping () -> ()) {
        persistentContainer = NSPersistentContainer(name: "KenshinCD")
        persistentContainer.loadPersistentStores() { (description, error) in
            if let error = error {
                fatalError("NotificationsClass.init()が失敗しました: \(error)")
            }
            completionClosure()
        }
        context = persistentContainer.viewContext
    }

    // 全件検索
    func selectNotifications() -> [Notifications] {
        let notificationsFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Notifications")
        
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
    func initInsertNotifications(otifications : Notifications) {
        do {
            // Insert前にCoreData内にデータが存在するかを確認し、
            // データが存在する場合　：何もしない
            // データが存在しない場合：データをInsertする
            let resultSelectNotifications = selectNotifications()
            if resultSelectNotifications.isEmpty {}
            else {
                let notificationsInsertData = try InitNotifications.getInitNotificationsData()
                for obj in notificationsInsertData! {
                    insertNotifications(otifications: obj)
                }
            }
        } catch {
            fatalError("NotificationsClass.initInsetNotifications()が失敗しました : \(error)")
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
    
    
    
}

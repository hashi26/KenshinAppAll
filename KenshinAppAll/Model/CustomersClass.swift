//
//  CustomersClass.swift
//  KenshinAppAll
//
//  Created by Takumi Takeuchi on 2019/02/08.
//  Copyright © 2019年 KenshinT. All rights reserved.
//

import Foundation
import CoreData


class CustomersClass {
    var persistentContainer:NSPersistentContainer!
    let context:NSManagedObjectContext!
    
    // 初期化
    init(completionClosure: @escaping () -> ()) {
        persistentContainer = NSPersistentContainer(name: "KenshinCD")
        persistentContainer.loadPersistentStores() { (description, error) in
            if let error = error {
                fatalError("CustomerClass.init()が失敗しました: \(error)")
            }
            completionClosure()
        }
        context = persistentContainer.viewContext
    }
    
    // 全件検索
    func selectCustomers() -> [Customers] {
        let customersFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Customers")
        
        do {
            let fetchedCustomers = try context.fetch(customersFetch) as! [Customers]
            return fetchedCustomers
        } catch {
            fatalError("CustomerClass.selectCustomers()が失敗しました: \(error)")
        }
        return []
    }
    
    // ガスメータ設置場所番号を指定して検索
    func selectCustomersByGmtSetNo(gmt_set_no:String) -> [Customers] {
        let customersFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Customers")

        // 条件指定
        customersFetch.predicate = NSPredicate(format: "gmt_set_no = ’\(gmt_set_no)’")
        
        do {
            let fetchedCustomers = try context.fetch(customersFetch) as! [Customers]
            return fetchedCustomers
        } catch {
            fatalError("CustomerClass.selectCustomersByGmtSetNo()が失敗しました: \(error)")
        }
        return []
    }
    
    // 追加
    func insertCustomers() -> Customers{
        let customer = NSEntityDescription.insertNewObject(forEntityName: "Customers", into: context) as! Customers
        saveCustomers()
        return customer
    }
    
    // 保存
    func saveCustomers() {
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


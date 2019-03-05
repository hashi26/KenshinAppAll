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
    init(){
        //completionClosure: @escaping () -> ()) {
        persistentContainer = NSPersistentContainer(name: "KenshinCD")
        persistentContainer.loadPersistentStores() { (description, error) in
            if let error = error {
                fatalError("CustomerClass.init()が失敗しました: \(error)")
            }
            //completionClosure()
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
        customersFetch.predicate = NSPredicate(format: "gmt_set_no = '\(gmt_set_no)'")
        
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
    
    // 初期データ追加
    // アプリ起動時にjsonからお知らせ一覧を作成し、CoreDataにinsertする
    func initInsertCustomers() {
        do {
            // Insert前にCoreData内にデータが存在するかを確認し、
            // データが存在する場合　：何もしない
            // データが存在しない場合：データをInsertする
            if (selectCustomers()).isEmpty {
                print("*** initInsertCustomers が実行されます。")
                let customersInsertData = try InitCustomers.getInitCustomersData()
                
                // 構造体のプロパティから各変数を作成し、インスタンスを生成
                for obj in customersInsertData!{
                    let insertEntity = NSEntityDescription.insertNewObject(forEntityName: "Customers", into: context)
                    
                    insertEntity.setValue(obj.adrs_banchi, forKey:"adrs_banchi")
                    insertEntity.setValue(obj.adrs_chou, forKey:"adrs_chou")
                    insertEntity.setValue(obj.adrs_gou, forKey:"adrs_goh")
                    insertEntity.setValue(obj.apart_heya_ban_c, forKey:"apart_heya_ban_cana")
                    insertEntity.setValue(obj.b1_kikan, forKey:"b1_kikan")
                    insertEntity.setValue(Int16(obj.b1_ryo), forKey: "b1_ryo")
                    insertEntity.setValue(obj.bb1_kikan, forKey:"bb1_kikan")
                    insertEntity.setValue(Int16(obj.bb1_ryo), forKey:"bb1_ryo")
                    insertEntity.setValue(obj.bb2_kikan, forKey:"bb2_kikan")
                    insertEntity.setValue(Int16(obj.bb2_ryo), forKey:"bb2_ryo")
                    insertEntity.setValue(obj.constract_started_at, forKey:"constract_started_at")
                    insertEntity.setValue(obj.customer_name_c, forKey:"customer_name_cana")
                    insertEntity.setValue(obj.customer_name_j, forKey:"customer_name_kanzi")
                    insertEntity.setValue(obj.flyer_refused, forKey:"flyer_refused")
                    insertEntity.setValue(obj.gmt_set_no, forKey:"gmt_set_no")
                    insertEntity.setValue(obj.gou_ban, forKey:"goh_ban")
                    insertEntity.setValue(obj.heya_ban_c, forKey:"heya_ban_cana")
                    insertEntity.setValue(obj.ichi_code, forKey:"ichi_code")
                    insertEntity.setValue(obj.in_dog, forKey:"in_dog")
                    insertEntity.setValue(obj.in_dog_code, forKey:"in_dog_code")
                    insertEntity.setValue(obj.kaiheisen_code, forKey:"kaiheisen_code")
                    insertEntity.setValue(obj.ken_seq, forKey:"ken_seq")
                    insertEntity.setValue(obj.knsn_method_code, forKey:"knsn_method_code")
                    insertEntity.setValue(obj.knsn_tnt_emp_no, forKey:"knsn_tnt_emp_no")
                    insertEntity.setValue(obj.memo, forKey:"memo")
                    insertEntity.setValue(obj.meter_no, forKey:"meter_no")
                    insertEntity.setValue(obj.mune_ban_c, forKey:"mune_ban_cana")
                    insertEntity.setValue(obj.name_j, forKey:"name_j")
                    insertEntity.setValue(obj.next_date, forKey:"next_date")
                    insertEntity.setValue(Int16(obj.old_gas_siji), forKey:"old_gas_shizi")
                    insertEntity.setValue(obj.opened_at, forKey:"opened_at")
                    insertEntity.setValue(obj.out_dog, forKey:"out_dog")
                    insertEntity.setValue(obj.out_dog_code, forKey:"out_dog_code")
                    insertEntity.setValue(obj.service_info, forKey:"service_info")
                    insertEntity.setValue(obj.tatemono_c, forKey:"tatemono_cana")
                    insertEntity.setValue(obj.tatemono_j, forKey:"tatemono_kanzi")
                    insertEntity.setValue(obj.teirei_date, forKey:"teirei_date")
                    insertEntity.setValue(obj.tel_no, forKey:"tel_no")
                    insertEntity.setValue(obj.wireless_used, forKey:"wireless_used")
                    insertEntity.setValue(obj.yago_c, forKey:"yago_cana")
                    insertEntity.setValue(obj.yago_j, forKey:"yago_kanzi")
                    insertEntity.setValue(obj.yuso_setted, forKey:"yuso_setted")
                    insertEntity.setValue(dateFromString(date: obj.created_at)! as NSDate, forKey: "created_at")
                    if let update_at = dateFromString(date: obj.updated_at){
                        insertEntity.setValue(update_at, forKey: "updated_at")
                    }
                    saveCustomers()
                }
            } else {
                print("*** initInsertNotifications が実行されませんでした。coredataにデータが存在します。 ")
            }
        } catch {
            fatalError("*** NotificationsClass.initInsetNotifications()が失敗しました : \(error)")
        }
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


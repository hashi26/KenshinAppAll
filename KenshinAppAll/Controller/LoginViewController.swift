//
//  VCLogin.swift
//  KenshinAppAll
//
//  Created by 1490402 on 2019/01/31.
//  Copyright © 2019 KenshinT. All rights reserved.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //下記は原田CoreDataテストのため記述
        /*
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context:NSManagedObjectContext = appDelegate.managedObjectContext
        let entity = NSEntityDescription.entity(forEntityName: "Goh", in: context)
        let goh = NSManagedObject(entity:entity!,insertInto:context) as! Goh
        goh.locations_code = "所在地行政区画CD"
        goh.gou_ban        = "号番号１"
        goh.towns_name_c   = "ゴウカナ"
        goh.towns_name_j   = "号漢字"
        goh.created_at     = Date() as NSDate
        goh.updated_at     = Date() as NSDate
        do{
            try context.save()
        }catch{
            print(error)
        }
 */
        
        
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

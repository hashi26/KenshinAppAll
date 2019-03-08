//
//  VCLogin.swift
//  KenshinAppAll
//
//  Created by 1490402 on 2019/01/31.
//  Copyright © 2019 KenshinT. All rights reserved.
//

import UIKit
import CoreData

class LoginViewController: UIViewController,UITextFieldDelegate {
    

    @IBOutlet weak var id: UITextField!
    @IBOutlet weak var pass: UITextField!
    
    var readingPerson_instance: ReadingPersonClass!
    var readingPerson:[Reading_person] = []

    
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
        
        /*
        guard let data1 = try? getJSONData1() else { return }
        //print(data1)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        goh2 = try! decoder.decode([GohClass].self, from: data1!)
 */
//        goh2 = readGohClassJson()
//        
//        print("読み込んだgohデータの値")
//        print(goh2[0].towns_name_c)
//        print(goh2[1].towns_name_j)
//        print(goh2[2].locations_code)
//        
        //goh2 = readGohClass()
        
        
        // Do any additional setup after loading the view.
    }
    
    
    
    
    @IBAction func login(_ sender: Any) {
        
        let id : String = self.id.text ?? ""
        let pass : String = self.pass.text ?? ""

        self.readingPerson_instance = ReadingPersonClass()
        
        readingPerson = self.readingPerson_instance.selectReadingPersonByKnsnTntEmpNo(knsn_tnt_emp_no: id)
        
        //passチェック
        if readingPerson[0].knsn_tnt_pass == pass{
            let storyboard: UIStoryboard = UIStoryboard(name: "Hello", bundle: nil)
            let nextView = storyboard.instantiateInitialViewController()
            present(nextView!, animated: true, completion: nil)
        }
        else{
            
        }
        print(readingPerson[0].knsn_tnt_emp_no)
        
    }
    
 
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    /*
    // GohInfo.json変換用
    func getJSONData1() throws -> Data? {
        guard let path = Bundle.main.path(forResource: "goh", ofType: "json") else { return nil }
        let url = URL(fileURLWithPath: path)
        
        return try Data(contentsOf: url)
    }
 */

}




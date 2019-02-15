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

//ReadingPersonClass用のJCLを読み込むメソッド
func readReadingResultClassJson() -> [ReadingPersonClass]{
    var readingPerson: [ReadingPersonClass] = []
    guard let data1 = try? getJSONData1() else { return readingPerson}
    //print(data1)
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    readingPerson = try! decoder.decode([ReadingPersonClass].self, from: data1!)
    return readingPerson
}

//Reading_resultテーブルからデータを全件取得するメソッド
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

//ReadingResultClassのjsonを読み込むための処理
//forResource:jsonのファイル名
func getReadingPersonJSONData1() throws -> Data? {
    guard let path = Bundle.main.path(forResource: "readingPerson", ofType: "json") else { return nil }
    let url = URL(fileURLWithPath: path)
    
    return try Data(contentsOf: url)
}

//ReadingResultClassからGohへ変換するためのメソッド
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

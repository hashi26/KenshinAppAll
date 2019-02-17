//
//  ReadingPersonJsonInsert.swift
//  KenshinAppAll
//
//  Created by TomonariNonaka on 2019/02/17.
//  Copyright © 2019 KenshinT. All rights reserved.
//

import Foundation

class ReadingPersonJsonInsert: Codable {

    // 基地コード
    let base_code: String
    // 支社コード
    let branch_office_code: String
    // 登録日時
    let created_at: Date
    // 検針担当者番号
    let knsn_tnt_emp_no: String
    // 検針担当者氏名
    let knsn_tnt_name: String
    // 検針担当者パスワード
    let knsn_tnt_pass: String
    // 検針担当者電話番号
    let knsn_tnt_tel_no: String
    //
    let sales_office_code: String
    // 更新日時
    let updated_at: Date
    
    init(base_code : String,
         branch_office_code : String ,
         created_at : Date ,
         knsn_tnt_emp_no : String ,
         knsn_tnt_name : String ,
         knsn_tnt_pass : String ,
         knsn_tnt_tel_no : String ,
         sales_office_code : String ,
         updated_at : Date
         )
    {
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

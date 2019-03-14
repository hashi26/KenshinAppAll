//
//  ContactViewController.swift
//  KenshinAppAll
//
//  Created by 1490402 on 2019/02/07.
//  Copyright © 2019 KenshinT. All rights reserved.
//

import UIKit

class ContactViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var contactTableView: UITableView!
    var readingPerson:ReadingPersonClass = ReadingPersonClass()
    var readingPersons:[Reading_person] = []
    let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var loginPerson:Reading_person!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //担当者の取得
        //appDelegate.loginReadingPerson = readingPerson.selectReadingPersonByKnsnTntEmpNo(knsn_tnt_emp_no: "2010123")[0]
        //loginPerson = appDelegate.loginReadingPerson
        
        print(loginPerson.knsn_tnt_emp_no!)
        
        // 担当者を除いた他メンバー一覧を取得
        //readingPersons = readingPerson.selectReadingPersonExclusionSelf(knsn_tnt_emp_no: loginPerson.knsn_tnt_emp_no!)
        readingPersons = readingPerson.selectReadingPerson()
        
        print("base_code: \(loginPerson.base_code)")
        print("knsn_tnt_emp_no: \(loginPerson.knsn_tnt_emp_no)")
        print("knsn_tnt_name: \(loginPerson.knsn_tnt_name)")
        print("knsn_tnt_tel_no: \(loginPerson.knsn_tnt_tel_no)")
        print("knsn_tnt_pass: \(loginPerson.knsn_tnt_pass)")
        print("branch_office_code: \(loginPerson.branch_office_code)")
        print("sales_office_code: \(loginPerson.sales_office_code)")
        print("base_code: \(loginPerson.base_code)")
        print("created_at: \(loginPerson.created_at)")
        print("updated_at: \(loginPerson.updated_at)")
        
        //セルのサイズ変更
        self.contactTableView.rowHeight = 100.0
        
        contactTableView.register (UINib(nibName: "ContactCell", bundle: nil),forCellReuseIdentifier:"ContactCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return readingPersons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) //新セル
        // セルに表示する値を設定する
        if let cell = cell as? ContactCell {
            cell.setupCell(model: readingPersons[indexPath.row])
        }
        return cell
    }

}

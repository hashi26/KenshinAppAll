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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //担当者の取得
        readingPersons = readingPerson.selectReadingPerson()
        print("readingPersonsの件数",readingPersons.count)
        print("名前：",readingPersons[0].knsn_tnt_emp_no)
        
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

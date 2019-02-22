//
//  ContactViewController.swift
//  KenshinAppAll
//
//  Created by 1490402 on 2019/02/07.
//  Copyright © 2019 KenshinT. All rights reserved.
//

import UIKit

class ContactViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let TableViewCell : UITableViewCell? = nil
        return TableViewCell!
    }
    
/*ß
    // TableViewオブジェクトの宣言
    @IBOutlet weak var contactTableView: UITableView!
    //var contactList: [readingPerson] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // TableViewの高さを100にする
        contactTableView.rowHeight = 100
        
        contactTableView.register (UINib(nibName: "ContactCell", bundle: nil),forCellReuseIdentifier:"ContactCell")

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        let contactList = readingPersonClassToReadingPerson
//        return contactList.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 
        print("セルの取得実行")
        // セルを取得する
        let contactCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath)
        // セルに表示する値を設定する
//        if let cell = contactCell as? ContactCell {
//            cell.setupCell(model: contactList[indexPath.row])
        }
//        return contactCell
 */
    

    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

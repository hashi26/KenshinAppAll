//
//  Customer_OtherViewController.swift
//  KenshinAppAll
//
//  Created by MaiInagaki on 2019/02/28.
//  Copyright © 2019年 KenshinT. All rights reserved.
//

import UIKit

class Customer_OtherViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var otherTable: UITableView!
    var customer:Customers = Customers()
    var otherItem:[String] = []
    let sectionName:[String] = ["開栓年月日"]
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        print("otherTable再表示確認")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //各セクション内のセル数を設定するデリゲートメソッド
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        customer = appDelegate.customerInfo
        insertItem()
        return 1
    }
    
    //セルに値を設定するデータソースメソッド
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルを取得する
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        // セルに表示する値を設定する
        cell.textLabel?.text = otherItem[indexPath.section]
        return cell
    }
    
    // セクション数
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // セクションヘッダ
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?  {
        return sectionName[section]
    }
    
    // サービスに表示する項目
    func insertItem(){
        var item: [String] = []
        item.append(String(customer.constract_started_at!))
        otherItem = item
    }
    
    func reloadTable(){ otherTable.reloadData()}
}



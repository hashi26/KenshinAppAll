//
//  Customer_ServiceViewController.swift
//  KenshinAppAll
//
//  Created by MaiInagaki on 2019/02/28.
//  Copyright © 2019年 KenshinT. All rights reserved.
//

import UIKit

class Customer_ServiceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var service:Customers = Customers()
    var serviceItem:[String] = []
    let sectionName:[String] = ["名前（カナ）","社番","建物名","メモ"]
    //Cell上部に上記のタイトルを表示したいが表示できない
    // 参照：https://tech.pjin.jp/blog/2016/09/06/tableview-12/
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //各セクション内のセル数を設定するデリゲートメソッド
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        service = appDelegate.customerInfo
        insertItem()
        return 1
    }
    
    //セルに値を設定するデータソースメソッド
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルを取得する
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        // セルに表示する値を設定する
        cell.textLabel?.text = serviceItem[indexPath.section]
        return cell
    }
    
    // セクション数
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    // セクションヘッダ
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?  {
        return sectionName[section]
    }
    
    // サービスに表示する項目の件数
    func insertItem(){
        var item: [String] = []
        item.append(String(service.customer_name_cana!))
        item.append(String(service.meter_no!))
        item.append(String(service.tatemono_kanzi!))
        item.append(String(service.memo!))
        serviceItem = item
    }
}

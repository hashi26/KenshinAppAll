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
    let sectionName:[String] = ["社番","建物名"]
    //Cell上部に上記のタイトルを表示したいが表示できない
    // 参照：https://tech.pjin.jp/blog/2016/09/06/tableview-12/
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //セルの個数を指定するデリゲートメソッド
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        service = appDelegate.customerInfo
        //print(service[0].gmt_set_no!)
        
        insertItem()
        return serviceItem.count
        
        //return 1
    }
    
    //セルに値を設定するデータソースメソッド
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルを取得する
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        // セルに表示する値を設定する
        cell.textLabel?.text = serviceItem[indexPath.row]
        return cell
    }
    
    // サービスに表示する項目の件数
    func insertItem(){
        var item: [String] = []
        item.append(String(service.meter_no!))
        item.append(String(service.tatemono_kanzi!))
        serviceItem = item
    }
}

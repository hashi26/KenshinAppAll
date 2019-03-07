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
        //cell.textLabel!.text = service[indexPath.row] as? String
        //cell.textLabel!.text = service.gmt_set_no★
        //print(service[0].gmt_set_no)
        cell.textLabel?.text = serviceItem[indexPath.row]
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // サービスに表示する項目の件数
    func insertItem(){
        var item: [String] = []
        item.append("あ")
        item.append("い")
        item.append(String(service.gmt_set_no!))
        print(item[0])
        print(item[1])
        print(item[2])
        serviceItem = item
    }
    
}


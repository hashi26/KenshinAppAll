//
//  NotificationViewController.swift
//  KenshinAppAll
//
//  Created by 1490402 on 2019/02/07.
//  Copyright © 2019 KenshinT. All rights reserved.
//

import UIKit

class NotificationViewController: UITableViewController {
    
    @IBOutlet var notifications: UITableView!
    
    
    let textArray:NSArray = [ "1","2","3","4","5"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //Table Viewのセルの数を指定
    override func tableView(_ table: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textArray.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    //追加④ セルに値を設定するデータソースメソッド（必須）
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルを取得する
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        // セルに表示する値を設定する
        cell.textLabel!.text = textArray[indexPath.row] as? String
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    

}

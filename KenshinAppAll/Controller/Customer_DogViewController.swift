//
//  Customer_DogViewController.swift
//  KenshinAppAll
//
//  Created by MaiInagaki on 2019/02/28.
//  Copyright © 2019年 KenshinT. All rights reserved.
//


import UIKit

class Customer_DogViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let service = ["犬情報1","犬情報2","犬情報3"]
    
    //セルの個数を指定するデリゲートメソッド
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return service.count
    }
    
    //セルに値を設定するデータソースメソッド
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルを取得する
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        // セルに表示する値を設定する
        cell.textLabel!.text = service[indexPath.row]
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

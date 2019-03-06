//
//  CustomerListViewController.swift
//  KenshinAppAll
//
//  Created by Harada Hiroaki on 2019/03/06.
//  Copyright © 2019 KenshinT. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

class CustomerListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var AreaMapView: MKMapView!
    @IBOutlet weak var customerTableView: UITableView!
    
    var customer:CustomersClass = CustomersClass()
    var goh:GohClass = GohClass()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customerTableView.register(UINib(nibName:"CustomerTableViewCell",bundle: nil),forCellReuseIdentifier:"CustomerTableViewCell")
        
        
        //Customerデータを取得できるか確認
        //var customers:[Customers] = customer.selectCustomers() //CustomerClassでselect関数が実装され次第確認する
        
        //Gohデータを取得できるか確認
        var gohs:[Goh] = goh.selectGoh()
        
        
        print("Gohの件数")
        print(gohs.count)
        print("gohs[0].gou_ban",gohs[0].gou_ban)
        print("gohs[1].towns_name_c",gohs[0].towns_name_c)
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "CustomerTableViewCell", for: indexPath) //新セル
        if let cell = cell as? CustomerTableViewCell {
            cell.samplelogic(ij: indexPath)
        }
        return cell
    }
    
}

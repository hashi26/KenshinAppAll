//
//  VCCustomer.swift
//  KenshinAppAll
//
//  Created by 1490402 on 2019/01/31.
//  Copyright © 2019 KenshinT. All rights reserved.
//

import UIKit
import CoreData

class CustomerViewController: UIViewController{
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var serviceContainer: UIView!
    @IBOutlet weak var dogContainer: UIView!
    @IBOutlet weak var otherContainer: UIView!
    var containers: Array<UIView> = []
    var customer_instance: CustomersClass!
    
    // 画面上部表示項目
    @IBOutlet weak var customerName: UILabel!
    @IBOutlet weak var meterNo: UILabel!
    @IBOutlet weak var knsnHhCd: UILabel!
    @IBOutlet weak var khsnJtCd: UILabel!
    @IBOutlet weak var shrHhCd: UILabel!
    
    var customers:[Customers] = []
    var cust:CustomersClass!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // コンテナ定義
        containers = [serviceContainer,dogContainer,otherContainer]
        containerView.bringSubviewToFront(serviceContainer)
        
        // お客さま情報表示
        self.customer_instance = CustomersClass()
        customers = self.customer_instance.selectCustomersByGmtSetNo(gmt_set_no: "10010010010")
        print(customers[0].name_j)
        customerName.text = customers[0].name_j
        meterNo.text = customers[0].gmt_set_no
        knsnHhCd.text = customers[0].knsn_method_code
        khsnJtCd.text = customers[0].knsn_method_code
        print("お客さま情報表示完了")
    }
 
    
    @IBAction func changeContainerView(_ sender: UISegmentedControl) {
        let currentContainerView = containers[sender.selectedSegmentIndex]
        containerView.bringSubviewToFront(currentContainerView)
    }
    
    /*
     おそらく、下記メソッドは画面表示の際に３コンテナ分動いてしまっている
     なぜ３回呼ばれているのかなぞ。
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("セグエ値渡しメソッド動いているか")
        // お客さま情報表示
        self.customer_instance = CustomersClass()
        customers = self.customer_instance.selectCustomersByGmtSetNo(gmt_set_no: "10010010010")
        if segue.identifier == "toService" {
            let nextScene = segue.destination as? Customer_ServiceViewController
            nextScene?.service = customers
            nextScene?.test = "テスト"

        }
    }
}

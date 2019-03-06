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
    var gmtSetNoList:[String]!
    var idx:Int!
    var cust:CustomersClass!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
         お試しでデータInsert
        */
        //ここは丸写しで良い
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        //インスタンス化をする
        //let task = Customers(context: context)
        //task.gmt_set_no = "10010010010"
        //task.name_j = "あいうえお"
        //保存する ※どんどん追加されちゃうのでコメントアウト
        //(UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        /*
         お試しでデータInsert
         */
        //self.cust = CustomersClass()
        //cust.initInsertCustomers()
        
        // コンテナ定義
        containers = [serviceContainer,dogContainer,otherContainer]
        containerView.bringSubviewToFront(serviceContainer)
        
        // テスト　Custmer全件取得して表示 できた！
        self.customer_instance = CustomersClass() //以下のメソッド確認のため残す
        //customers = self.customer_instance.selectCustomers()
        //print(customers.count)
        //print(customers[0].name_j)
        //customerName.text = customers[0].name_j
        
        // テスト　ガスメータ設置場所番号：10010010010　の氏名を取得して表示
        customers = self.customer_instance.selectCustomersByGmtSetNo(gmt_set_no: "10010010010")
        //print(customers[0].name_j)
//        customerName.text = customers[0].name_j
//        meterNo.text = customers[0].gmt_set_no
//        knsnHhCd.text = customers[0].knsn_method_code
//        khsnJtCd.text = customers[0].knsn_method_code
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
        if segue.identifier == "toService" {
            let nextScene = (segue.destination as? Customer_ServiceViewController)
                nextScene?.service = customers
            
        }
    }
}


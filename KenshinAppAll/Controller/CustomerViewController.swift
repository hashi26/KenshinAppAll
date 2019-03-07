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
        
        // 1XXに紐づくお客さま情報取得
        self.customer_instance = CustomersClass()
        // テスト　ガスメータ設置場所番号：10010010010　の氏名を取得して表示
        customers = self.customer_instance.selectCustomersByGmtSetNo(gmt_set_no: "10010010010")//★将来的に渡された値を代入
        customerName.text = customers[0].name_j
        meterNo.text = customers[0].gmt_set_no
        knsnHhCd.text = checkKensnMethod(String(customers[0].knsn_method_code!))
        khsnJtCd.text = checkKaihei(String(customers[0].kaiheisen_code!))
    }
    
    @IBAction func changeContainerView(_ sender: UISegmentedControl) {
        let currentContainerView = containers[sender.selectedSegmentIndex]
        containerView.bringSubviewToFront(currentContainerView)
    }
    
    func checkKaihei(_ code: String) -> String {
        var method: String = ""
        if(code == "0"){
            method = "閉栓中"
        }else if(code == "1"){
            method = "開栓中"
        }else{
            method = ""
            //この場合は発生しないはずだがブランクを表示する
        }
        return method
    }
    
    func checkKensnMethod(_ code: String) -> String {
        var method: String = ""
        switch code {
        case "11":
            method = "電話"
        case "12":
            method = "スマメ"
        case "21":
            method = "はこ"
        default:
            print("その他")
        }
        return method
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppearの実行")
        super.viewWillAppear(animated)
        let appDelegagte = UIApplication.shared.delegate as! AppDelegate
        appDelegagte.customerInfo = customers[0] //★将来的にここに適した値を入れる
        /*
         画面フリック時にテーブルの再読み込みが必要。この辺りが必要かも？
         */
    }
}


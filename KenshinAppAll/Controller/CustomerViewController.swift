//
//  VCCustomer.swift
//  KenshinAppAll
//
//  Created by 1490402 on 2019/01/31.
//  Copyright © 2019 KenshinT. All rights reserved.
//

/*
    お客さま一覧画面にて選択されたお客さま情報を表示する
    Customerオブジェクト全件（30件）と、何番目のお客さまかという値を受け取る
    同様に、検針画面に上記の情報を渡す
*/

import UIKit
import CoreData

class CustomerViewController: UIViewController{
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var serviceContainer: UIView!
    @IBOutlet weak var dogContainer: UIView!
    @IBOutlet weak var otherContainer: UIView!
    var containers: Array<UIView> = []
    
    var customers:[Customers] = []
    var selectionNumber: Int = 0
    var viewCount: Int = 0
    
    // 他クラスインスタンス用変数
    var customer_instance: CustomersClass!
    var servise_instance: Customer_ServiceViewController!
    var other_instance  : Customer_OtherViewController!
    var dog_instance    : Customer_DogViewController!
    
    
    // 画面上部表示項目
    @IBOutlet weak var customerName: UILabel!
    @IBOutlet weak var meterNo: UILabel!
    @IBOutlet weak var knsnHhCd: UILabel!
    @IBOutlet weak var khsnJtCd: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // コンテナ定義
        containers = [serviceContainer,dogContainer,otherContainer]
        containerView.bringSubviewToFront(serviceContainer)
        
        // スワイプ定義
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
        rightSwipe.direction = .right
        view.addGestureRecognizer(rightSwipe)
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
        leftSwipe.direction = .left
        view.addGestureRecognizer(leftSwipe)
        
        /*
        // CusromerClassインスタンス生成
        self.customer_instance = CustomersClass()
        // テスト　ガスメータ設置場所番号：10010010010　の氏名を取得して表示
        customers = self.customer_instance.selectCustomersByGmtSetNo(gmt_set_no: "10010010010")//★将来的に渡された値を代入
        */
        
        self.customer_instance = CustomersClass()
        //self.servise_instance = Customer_ServiceViewController()
        customers = self.customer_instance.selectCustomers() //前画面からObject受け取り実装完了次第不要
        
        customerName.text = customers[selectionNumber].name_j
        meterNo.text = customers[selectionNumber].gmt_set_no
        knsnHhCd.text = checkKensnMethod(String(customers[selectionNumber].knsn_method_code!))
        khsnJtCd.text = checkKaihei(String(customers[selectionNumber].kaiheisen_code!))
        
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
    
    @objc final func handleSwipe(sender: UISwipeGestureRecognizer) {
    
        switch sender.direction{
            case .right:
                print("前のお客さま")
                selectionNumber = selectionNumber - 1
                
                if selectionNumber >= 0 {
                    //　画面上部
                    viewDidLoad() //画面上部しか変わらない
                    
                    // 画面下部。動かない！
                    viewWillAppear(true)
                    self.servise_instance.reloadTable()
                    self.dog_instance.reloadTable()
                    self.other_instance.reloadTable()
                } else {
                    selectionNumber = 0
                    
                    /* 最初のお客様である処理を追加する */
                }
            case .left:
                print("次のお客さま")
                selectionNumber = selectionNumber + 1
                
                if selectionNumber < customers.count {
                    //　画面上部
                    viewDidLoad()
                    
                    // 画面下部。動かない！
                    viewWillAppear(true)
                    self.servise_instance.reloadTable()
                    self.dog_instance.reloadTable()
                    self.other_instance.reloadTable()
                } else {
                    selectionNumber = customers.count-2
                    /* 最後のお客様である処理を追加する */
                }
            default:
                break
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppearの実行")
        super.viewWillAppear(animated)
        let appDelegagte = UIApplication.shared.delegate as! AppDelegate
        appDelegagte.customerInfo = customers[selectionNumber]
        /*
         画面フリック時にテーブルの再読み込みが必要。この辺りが必要かも？
         */
        print("viewWillAppear動いているか")
        print(selectionNumber)
        //self.servise_instance = Customer_ServiceViewController()
        
        if viewCount > 0 {
            //servise_instance.appDelegate.reloadInputViews()
            //appDelegate.reloadInputViews()
            //self.servise_instance.serviceTable.reloadData()
            //serviceContainer.reloadInputViews()
        }
        viewCount = viewCount + 1
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
       // (segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let C_SVC = segue.destination as? Customer_ServiceViewController { self.servise_instance = C_SVC }
        if let C_OVC = segue.destination as? Customer_OtherViewController   { self.other_instance   = C_OVC }
        if let C_DVC = segue.destination as? Customer_DogViewController     { self.dog_instance     = C_DVC }
        
    
    }
    
}


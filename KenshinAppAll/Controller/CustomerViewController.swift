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
    var customer_instance: CustomersClass!
    
    // 画面上部表示項目
    @IBOutlet weak var customerName: UILabel!
    @IBOutlet weak var meterNo: UILabel!
    @IBOutlet weak var knsnHhCd: UILabel!
    @IBOutlet weak var khsnJtCd: UILabel!
    @IBOutlet weak var shrHhCd: UILabel!
    
    var customers:[Customers] = []
    var cust:CustomersClass!
    var selectionNumver: Int = 0
    
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
        customers = self.customer_instance.selectCustomers() //前画面からObject受け取り実装完了次第不要
        
        customerName.text = customers[selectionNumver].name_j
        meterNo.text = customers[selectionNumver].gmt_set_no
        knsnHhCd.text = checkKensnMethod(String(customers[selectionNumver].knsn_method_code!))
        khsnJtCd.text = checkKaihei(String(customers[selectionNumver].kaiheisen_code!))
        
        print(customers[2].name_j)
        
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
                selectionNumver = selectionNumver - 1
                viewDidLoad() //画面上部しか変わらない
            case .left:
                print("次のお客さま")
                selectionNumver = selectionNumver + 1
                viewDidLoad() //画面上部しか変わらない
            default:
                break
        }
        
        /*
        if sender.state == .ended {
            switch sender.direction {
            case .right:
                print("前のお客さま")
                
                //selectObjectの添え字がマイナスになならないように調整
                if appDelegate.num! == 0{
                    appDelegate.num! = appDelegate.selectObjects!.count-1
                }
                else{
                    appDelegate.num! -= 1
                }
                print("\(appDelegate.num!)")
                
                //count = count - 1
                //print(count)
                // 画面遷移
                
                //let storyboard = UIStoryboard(name: "Detail", bundle: nil)
                //let nextView = storyboard.instantiateViewController(withIdentifier: "VCDatail-ID")
                //self.present(nextView, animated: true, completion: nil)
                
                
            case .left:
                print("次のお客さま")
                
                //selectObjectの配列の添え字が最大個数を超えないように調整
                if appDelegate.num! == appDelegate.selectObjects!.count-1{
                    appDelegate.num! = 0
                }
                else{
                    appDelegate.num! += 1
                }
                
                //count = count + 1
                //print(count)
                // 画面遷移
                
                //let storyboard = UIStoryboard(name: "Detail", bundle: nil)
                //let nextView = storyboard.instantiateViewController(withIdentifier: "VCDatail-ID")
            //self.present(nextView, animated: true, completion: nil)
            default:
                break
            }
            
            //結果を更新
            
            //お客様名格納
            custName.text = String(appDelegate.selectObjects![appDelegate.num!].name)
            //社番格納
            meterNo.text = String(appDelegate.selectObjects![appDelegate.num!].syaban)
            
        }
        */
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppearの実行")
        super.viewWillAppear(animated)
        let appDelegagte = UIApplication.shared.delegate as! AppDelegate
        appDelegagte.customerInfo = customers[selectionNumver] //★将来的にここに適した値を入れる
        /*
         画面フリック時にテーブルの再読み込みが必要。この辺りが必要かも？
         */
    }
}


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
    
    @IBOutlet weak var customerName: UILabel!
    
    var customers:[Customers] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // コンテナ定義
        containers = [serviceContainer,dogContainer,otherContainer]
        containerView.bringSubviewToFront(serviceContainer)
        
        // テスト　ガスメータ設置場所番号：10010010010　の氏名を取得して表示
        self.customer_instance = CustomersClass()
        customers = self.customer_instance.selectCustomers()
        print(customers.count)
        
        /*
        // Customersのname_j
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.managedObjectContext
        
        print("検索する")
        let fetchRequestSearch: NSFetchRequest<Customers> = Customers.fetchRequest()
        let predicate = NSPredicate(format: "%K = %@","gmt_set_no","10010010010")
        fetchRequestSearch.predicate = predicate
    
        print("fetch定義完了")
        
        let fetchData = try!context.fetch(fetchRequestSearch)
        print(fetchData)
        //customers = CustomersClass.selectCustomers()
        //他クラスメソッドの呼び出しがうまくできない
        
        
        print("tryした")
        if(!fetchData.isEmpty){
            print("検索結果あり")
            for i in 0..<fetchData.count{
                print(fetchData[i].name_j!)
            }
        }else{
            print("データなし")
        }
 */
    }
 
    
    @IBAction func changeContainerView(_ sender: UISegmentedControl) {
        let currentContainerView = containers[sender.selectedSegmentIndex]
        containerView.bringSubviewToFront(currentContainerView)
    }
    
}

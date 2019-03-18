//
//  CustomerNavigationController.swift
//  KenshinAppAll
//
//  Created by MaiInagaki on 2019/03/18.
//  Copyright © 2019年 KenshinT. All rights reserved.
//

import UIKit

class CustomerNavigationController: UINavigationController{
    
    var customers:[Customers] = []
    var selectionNumber: Int = 0
    
   
    
    //遷移先の画面を取り出す
    override func prepare(for segue:UIStoryboardSegue, sender: Any?){
        print("次画面呼び出し実行 MAP→お客さま")
        //次の画面を取り出す
        let viewController = segue.destination as! CustomerViewController
        viewController.customers = self.customers
        viewController.selectionNumber = self.selectionNumber
        print("選択配列番号：")
        print(selectionNumber)
    }
}

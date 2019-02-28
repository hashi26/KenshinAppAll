//
//  VCCustomer.swift
//  KenshinAppAll
//
//  Created by 1490402 on 2019/01/31.
//  Copyright © 2019 KenshinT. All rights reserved.
//

import UIKit

class CustomerViewController: UIViewController{
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var serviceContainer: UIView!
    @IBOutlet weak var dogContainer: UIView!
    @IBOutlet weak var otherContainer: UIView!
    var containers: Array<UIView> = []
    
    @IBOutlet weak var customerName: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        containers = [serviceContainer,dogContainer,otherContainer]
        containerView.bringSubviewToFront(serviceContainer)
        
        
    }
    
    @IBAction func changeContainerView(_ sender: UISegmentedControl) {
        let currentContainerView = containers[sender.selectedSegmentIndex]
        containerView.bringSubviewToFront(currentContainerView)
    }
    
    // テスト　ガスメータ設置場所番号：10010010010　の氏名を取得して表示
    
    
    
    

}

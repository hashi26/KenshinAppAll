//
//  CustomerTableViewCell.swift
//  KenshinAppAll
//
//  Created by Harada Hiroaki on 2019/03/06.
//  Copyright © 2019 KenshinT. All rights reserved.
//

import UIKit

class CustomerTableViewCell: UITableViewCell {
    @IBOutlet weak var gmtsetNo: UILabel!
    @IBOutlet weak var customerName: UILabel!
    
    
    func samplelogic(model: Customers){
        self.gmtsetNo.text = model.gmt_set_no
        self.customerName.text = model.customer_name_kanzi
    }
    
    /*
    func setupCell(model:Customers){
        gmtsetNo.text = model.gmt_set_no
    }*/
}

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
    
    
    func samplelogic(ij: IndexPath){
        self.gmtsetNo.text = String((ij.row)+1)
    }
    
    /*
    func setupCell(model:Customers){
        gmtsetNo.text = model.gmt_set_no
    }*/
}

//
//  ContactCell.swift
//  KenshinAppAll
//
//  Created by Harada Hiroaki on 2019/03/07.
//  Copyright © 2019 KenshinT. All rights reserved.
//

import UIKit

class ContactCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var base: UILabel!
    
    func setupCell(model:Reading_person ) {
        print("setupCell関数の呼び出し")
        //名前
        name.text = model.knsn_tnt_name
        
        //拠点
        base.text = model.knsn_tnt_tel_no
        
    }

    
}

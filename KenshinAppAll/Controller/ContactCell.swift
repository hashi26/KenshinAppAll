//
//  ContactCell.swift
//  KenshinAppAll
//
//  Created by Harada Hiroaki on 2019/03/07.
//  Copyright © 2019 KenshinT. All rights reserved.
//

import UIKit
import CallKit

class ContactCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var readingPersonImageView: UIImageView!
    @IBOutlet weak var callButton: UIButton!
    var telNo:String!
    
    
    func setupCell(model:Reading_person ) {
        print("setupCell関数の呼び出し")
        
        self.readingPersonImageView.image = UIImage(named: "pattyo")
        //名前
        self.name.text = model.knsn_tnt_name
        self.telNo = model.knsn_tnt_tel_no
        
        
    }

    @IBAction func pushCall(_ sender: Any) {
//        let ActionSheet: UIAlertController = UIAlertController(title: "お願い", message: "お手元に会員番号をご用意ください", preferredStyle:  UIAlertController.Style.actionSheet)
//
//        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
//            (action: UIAlertAction!) -> Void in
//            print("OK")
//        })
//
//        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler:{
//            (action: UIAlertAction!) -> Void in
//            print("Cancel")
//        })
        
//        ActionSheet.addAction(cancelAction)
//        ActionSheet.addAction(defaultAction)
        let callNo = "tel://" + self.telNo!
        print("*** コールボタンが押されました。 callNO: \(callNo) ***")
        UIApplication.shared.open(NSURL(string: callNo)! as URL)
        
    }
    
}

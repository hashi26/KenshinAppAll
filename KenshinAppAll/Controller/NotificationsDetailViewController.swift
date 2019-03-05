//
//  NotificationsDetailTableViewController.swift
//  KenshinAppAll
//
//  Created by Takumi Takeuchi on 2019/03/04.
//  Copyright © 2019年 KenshinT. All rights reserved.
//

import UIKit

class NotificationsDetailViewController: UIViewController {


    @IBOutlet weak var senderNameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var supervisorNameLabel: UILabel!
    @IBOutlet weak var telNoLabel: UILabel!
    
    var receiveData:Notifications?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if receiveData?.updated_at != nil {
            dateLabel.text = dateToString(date: receiveData?.updated_at as! NSDate)
        } else {
            dateLabel.text = dateToString(date: receiveData?.created_at as! NSDate)
        }
        titleLabel.text = receiveData?.title
        titleLabel.sizeToFit()
        detailLabel.text = receiveData?.contents
        detailLabel.sizeToFit()
        senderNameLabel.text = receiveData?.sender_name
        supervisorNameLabel.text = receiveData?.supervisor_name
        telNoLabel.text = receiveData?.contact_tel_no
        
    }

    func dateToString(date:NSDate) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:MM" // ここでフォーマットを選択
        
        let str = formatter.string(from: date as Date)
        
        return str
    }
    

}

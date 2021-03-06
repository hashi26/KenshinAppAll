//
//  NotificationsTableViewController.swift
//  KenshinAppAll
//
//  Created by Takumi Takeuchi on 2019/03/04.
//  Copyright © 2019年 KenshinT. All rights reserved.
//

import UIKit

class NotificationsTableViewController: UITableViewController {

    @IBOutlet weak var notificationsTableView: UITableView!
    
    var notificationsClassDao:NotificationsClass!
    var notificationsList:[Notifications] = []
    var sectionTitle:[String] = []
    var dataArray:[String]!
    var sectionTitleArray: [String] = []
    var sectionDataArray: [[String]] = []
    var sendData:Notifications!
    var activityIndicatorView:UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notificationsTableView.delegate = self
        notificationsTableView.dataSource = self
        
        self.notificationsClassDao = NotificationsClass()
        notificationsList = self.notificationsClassDao.selectNotifications()
        
        activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.center = view.center
//        activityIndicatorView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
//        activityIndicatorView.style = UIActivityIndicatorView.Style.whiteLarge
//
//        activityIndicatorView.backgroundColor = UIColor.black
        self.activityIndicatorView.hidesWhenStopped = true
        self.view.addSubview(activityIndicatorView)
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return notificationsList.count
    }

    // セル生成
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let cellData = notificationsList[(indexPath as NSIndexPath).row]
        //let cellData = notificationsList[(indexPath as NSIndexPath).row]
        cell.textLabel?.text = cellData.title
        cell.detailTextLabel?.text = "差出人：\(cellData.sender_name!)"
        cell.textLabel?.font = UIFont.systemFont(ofSize: 20)
        return cell
    }
    
    // Sectionのタイトル
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return stringFromDate(date: notificationsList[section].created_at! as Date)
//
//    }
    
    // String -> Date 変換
    func stringFromDate(date: Date) -> String {
        let formatter: DateFormatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = "yyyy/MM/dd hh:mm"
        return formatter.string(from: date)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Segue" {
            if let indexPath = self.tableView.indexPathForSelectedRow{
                let sendObj:Notifications = notificationsList[(indexPath as NSIndexPath).row]
                (segue.destination as! NotificationsDetailTableViewController).receiveData = sendObj
            }
        }
    }
    
//    @IBAction func reloadTableView(_ sender: Any) {
//        self.activityIndicatorView.hidesWhenStopped = false
//        self.activityIndicatorView.startAnimating()
//        self.view.addSubview(activityIndicatorView)
//        self.view.bringSubviewToFront(activityIndicatorView)
//        
//        // 3秒後にアニメーションを停止させる
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
//            self.activityIndicatorView.stopAnimating()
//            self.activityIndicatorView.hidesWhenStopped = true
//        })
//    }
}

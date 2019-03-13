//
//  NotificationDetailTableViewController.swift
//  KenshinAppAll
//
//  Created by Takumi Takeuchi on 2019/03/08.
//  Copyright © 2019年 KenshinT. All rights reserved.
//

import UIKit

class NotificationsDetailTableViewController: UITableViewController {

    @IBOutlet weak var tableview: UITableView!
    
    var receiveData:Notifications?
    var sectionTitle:[String] = ["差出人","タイトル","日付","内容","担当者","連絡先"]
    var inSectionContents:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.estimatedRowHeight = 90 //セルの高さ
        self.tableView.rowHeight = UITableView.automaticDimension //自動設定
        var item:[String] = []
        item.append(receiveData!.sender_name!)
        item.append(receiveData!.title!)
        item.append(dateToString(date: receiveData!.created_at! as Date))
        item.append(receiveData!.contents!)
        item.append(receiveData!.supervisor_name!)
        item.append(receiveData!.contact_tel_no!)
        inSectionContents = item
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitle.count
    }

    // Sectioのタイトル
    override func tableView(_ tableView: UITableView,                   titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? DetailCell else {
            return UITableViewCell()
        }

        cell.detailLabel.text = inSectionContents[indexPath.section]
        return cell
        
        
    }
    
    // String -> Date 変換
    func dateToString(date: Date!) -> String {
        let formatter: DateFormatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = "yyyy/MM/dd hh:mm"
        return formatter.string(from: date)
    }
    
    /*
     セルの高さを設定
     */
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//
//        tableView.estimatedRowHeight = 90 //セルの高さ
//        return UITableView.automaticDimension //自動設定
//    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

class DetailCell : UITableViewCell {
    @IBOutlet weak var detailLabel: UILabel!
    
}

//
//  VCLogin.swift
//  KenshinAppAll
//
//  Created by 1490402 on 2019/01/31.
//  Copyright © 2019 KenshinT. All rights reserved.
//

import UIKit
import CoreData

class LoginViewController: UIViewController,UITextFieldDelegate {
    

    @IBOutlet weak var id: UITextField!
    @IBOutlet weak var pass: UITextField!
    
    var readingPerson_instance: ReadingPersonClass!
    var readingPerson:[Reading_person] = []
    //var sendData:Reading_person!

    var alert:UIAlertController!
    var alert2:UIAlertController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //アラートコントローラーを作成する。
        alert = UIAlertController(title: "注意！！", message: "ID,またはPassが入力されていません", preferredStyle: UIAlertController.Style.alert)
        
        alert2 = UIAlertController(title: "注意！！", message: "入力されたID,またはPassが誤っています", preferredStyle: UIAlertController.Style.alert)
        
        //alertのアラートアクションを作成する。
        let alertAction = UIAlertAction(
            title: "OK",
            style: UIAlertAction.Style.default,
            handler: nil
        )

        //アラートアクションを追加する。
        alert.addAction(alertAction)
        alert2.addAction(alertAction)
    }
    
    
    
    
    @IBAction func login(_ sender: Any) {
        
        let id : String = self.id.text ?? ""
        let pass : String = self.pass.text ?? ""

        self.readingPerson_instance = ReadingPersonClass()
        
        //入力有無チェック
        if id == "" || pass == ""{
            //アラートコントローラーを表示する。
            self.present(alert, animated: true, completion:nil)
            return
        }
        else{
            //入力されたIDで検索
            readingPerson = self.readingPerson_instance.selectReadingPersonByKnsnTntEmpNo(knsn_tnt_emp_no: id)
            //IDでマッチングなし
            if readingPerson.isEmpty {
                self.present(alert2, animated: true, completion:nil)
                print("ログイン失敗（ID対象なし）")
                return
            }
            //一致するIDありかつPassも一致
            else if readingPerson[0].knsn_tnt_pass == pass{
                print("ログイン成功")
                //print(next?.readingPerson[0].knsn_tnt_emp_no)
                
                //present(next!, animated: true, completion: nil)
            }
                //ID一致するもPass不一致
            else {
                self.present(alert2, animated: true, completion:nil)
                print("ログイン失敗（PASS誤り）")
                return
            }
            
        }
        
    }
    
    @IBAction func returnToLogin(segue: UIStoryboardSegue) {
        id.text = ""
        pass.text = ""
    }
 
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    /*
    // GohInfo.json変換用
    func getJSONData1() throws -> Data? {
        guard let path = Bundle.main.path(forResource: "goh", ofType: "json") else { return nil }
        let url = URL(fileURLWithPath: path)
        
        return try Data(contentsOf: url)
    }
 */

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toHello" {
                //let sendObj:Notifications = notificationsList[(indexPath as NSIndexPath).row]
            //(segue.destination as! NotificationsDetailTableViewController).receiveData = sendObj
            //ユーティリティエリアで設定したStoryBoardIDをwithIdentifierに設定
            let next = segue.destination as! HelloViewController
            next.recievedPerson = self.readingPerson[0]
            
            }
        }
}




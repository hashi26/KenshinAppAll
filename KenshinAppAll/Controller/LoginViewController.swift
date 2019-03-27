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
        //フォーカスをidへ
        //self.id.becomeFirstResponder()
    }
    
    @IBAction func login(_ sender: Any) {
        
        let id : String = self.id.text ?? ""
        let pass : String = self.pass.text ?? ""

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

        self.readingPerson_instance = ReadingPersonClass()
        
        //入力有無チェック
        if id == "" || pass == ""{
            //アラートコントローラーを表示する。
            self.present(alert, animated: true, completion:nil)
            self.id.text = ""
            self.pass.text = ""
        

            return
        }
        else{
            //入力されたIDで検索
            readingPerson = self.readingPerson_instance.selectReadingPersonByKnsnTntEmpNo(knsn_tnt_emp_no: id)
            //IDでマッチングなし
            if readingPerson.isEmpty {
                self.present(alert2, animated: true, completion:nil)
                print("ログイン失敗（ID対象なし）")
                self.id.text = ""
                self.pass.text = ""
                
                return
            }
            //一致するIDありかつPassも一致
            else if readingPerson[0].knsn_tnt_pass == pass{
                print("ログイン成功")
                (UIApplication.shared.delegate as! AppDelegate).loginReadingPerson = self.readingPerson[0]
                
              }
                //ID一致するもPass不一致
            else {
                self.present(alert2, animated: true, completion:nil)
                print("ログイン失敗（PASS誤り）")
                //self.id.text = ""
                self.pass.text = ""
                
                return
            }
        }
    }
    
    @IBAction func returnToLogin(segue: UIStoryboardSegue) {
        id.text = ""
        pass.text = ""
    }

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




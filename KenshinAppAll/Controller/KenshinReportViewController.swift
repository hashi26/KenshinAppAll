//
//  VCKenshinReport.swift
//  KenshinAppAll
//
//  Created by 1490402 on 2019/01/31.
//  Copyright © 2019 KenshinT. All rights reserved.
//

import UIKit
import Foundation
import AudioToolbox
import AVFoundation
import CoreData

class KenshinReportViewController: UIViewController,UINavigationControllerDelegate {
    
    @IBOutlet weak var meterNo: UILabel!
    @IBOutlet weak var oldGasSiji: UILabel!
    @IBOutlet weak var b1Ryo: UILabel!
    @IBOutlet weak var gmtSijiSu: UITextField!
    @IBOutlet weak var gasUsage: UILabel!
    @IBOutlet weak var resultCancel: UIButton!
    @IBOutlet weak var nextMetr: UIButton!
    @IBOutlet weak var gouSelect: UIButton!
    @IBOutlet weak var cameraLightButton: UIBarButtonItem!
    
    var gmtSetNo:String = ""
    
    var customer_instance: CustomersClass!
    var customers:[Customers] = []
    var selectionNumber: Int = 0
    
    var result_instance: ReadingResultClass!
    var results:[Reading_results] = []
    
    
    var kaikiFlg:Int? = 0           //回帰フラグ
    var cameraLightStatus:Bool = true   // カメラのライト状態

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.delegate = self
        
        self.customer_instance = CustomersClass()
        self.result_instance = ReadingResultClass()
        
        // ガスメータ設置場所番号を引数に各情報を取得して表示(お客さまテーブル)
        customers = self.customer_instance.selectCustomers() //前画面からObject受け取り実装完了次第不要
        
        
        //ラベル初期値設定
        meterNo.text = customers[selectionNumber].meter_no
        oldGasSiji.text = customers[selectionNumber].old_gas_siji.description
        b1Ryo.text = customers[selectionNumber].b1_ryo.description
        gasUsage.text   = "0" // 今回使用量　descriptionでStringに変換
        self.gmtSetNo = customers[selectionNumber].gmt_set_no!.description
        
        self.gmtSijiSu.keyboardType = UIKeyboardType.numberPad//キーボードは数字入力固定
        resultCancel.layer.cornerRadius = 5  //取消ボタンを丸角にする
        
        //今回指示数が初期値なら、入力欄をブランク
        if( gmtSijiSu.text == "0" ){ gmtSijiSu.text = nil }
        
        //キーボードを開く
        self.openCancelBar()
        gmtSijiSu.becomeFirstResponder()
        
        //今回指示数の文字数チェック
        NotificationCenter.default.addObserver(self,selector: #selector(textFieldDidChange),
                                               name: UITextField.textDidChangeNotification,object: gmtSijiSu)

        //検針済かチェックして各処理行う。
        self.checkResult()

    }
    
    //キーボードの「登録」ボタン押下時の処理
    @objc func pushDone(_ sender: UIButton){
        //キーボード閉じる
        //self.openCancelBar()
        self.gmtSijiSu.resignFirstResponder()
        //指示数確認アラートの定義
        let shijisuAlert = UIAlertController(
            title: gmtSijiSu.text, message:"よろしいですか？", preferredStyle: .alert)
        //アラートキャンセルボタン押下時の処理
        shijisuAlert.addAction(UIAlertAction(title:"キャンセル",style:.cancel,handler: { action in self.gmtSijiSu.text = nil}))
        //アラートOKボタン押下時の処理
        shijisuAlert.addAction(UIAlertAction(title:"OK",style:.default,
                                             handler: { action in
                                                //今回指示数が前回指示数未満の時
                                                if(Int(self.gmtSijiSu.text!)! < Int(self.oldGasSiji.text!)!){
                                                    self.checkKaiki()
                                                    self.kenshinResult()
                                                    //今回指示数が前回指示数以上の時
                                                }else{
                                                    self.kenshinResult()
                                                }
        }))
        //指示数確認アラートの出力
        self.present(shijisuAlert, animated: true, completion: nil)
        
        //次回キーボードが開かれた時に、Doneボタンを表示させないために必要。
        self.openCancelBar()
    }
    
    //今回指示数の文字数チェック。4文字までしか入力させない
    @objc private func textFieldDidChange(notification: NSNotification) {
        let textFieldString = notification.object as! UITextField
        if let text = textFieldString.text {
            
            print("文字数：",text.count)
            
            if text.count > 3 {
                print("text.count > 3 合致")
                self.gmtSijiSu.resignFirstResponder()
                self.openCancelDoneBar()
                self.gmtSijiSu.becomeFirstResponder()
                gmtSijiSu.text = text.substring(to: text.index(text.startIndex, offsetBy: 4))
            }else{
                print("text.count > 3 合致しない")
                self.gmtSijiSu.resignFirstResponder()
                self.openCancelBar()
                self.gmtSijiSu.becomeFirstResponder()
            }
        }
    }
    
    
    //キーボードの「キャンセル」ボタン押下時の処理
    @objc func pushCancel(_ sender: UIButton){
        gmtSijiSu.text = nil

        //キーボードを閉じる
        self.openCancelBar()
        self.gmtSijiSu.resignFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //検針済かチェックし、各処理を行う。
    func checkResult(){
        
        //対象のメーターの情報取得
        results = self.result_instance.selectReadingResultByGmtSetNo(gmt_set_no: gmtSetNo)

        //検針済なら・・・
        if (results != []) {
            //指示数入力欄を灰色にして非活性化
            print("結果テーブル対象あり")
            self.gmtSijiSu.text = results[0].gmt_sizi_su.description // 今回指示数
            self.gasUsage.text = results[0].gas_usage.description // 今回使用量
            self.gmtSijiSu.isEnabled = false
            self.gmtSijiSu.backgroundColor = UIColor.lightGray
            //取消ボタンを赤色にして活性化
            self.resultCancel.isEnabled = true
            self.resultCancel.backgroundColor = UIColor.red
            self.cameraLightButton.isEnabled = false
        }else{
            //未検針なら
            print("結果テーブル対象なし")
            //指示数入力欄を白色にして活性化
            self.gmtSijiSu.isEnabled = true
            self.gmtSijiSu.backgroundColor = UIColor.white
            //取消ボタンを灰色にして非活性化
            self.resultCancel.isEnabled = false
            self.resultCancel.backgroundColor = UIColor.lightGray
            self.cameraLightButton.isEnabled = true
        }
    }
    
    //アクションシートを表示し、回帰か確認を求める
    func checkKaiki() {
        let kaikiAlert = UIAlertController(
            title: "前回指示数を下回っています。", message:"", preferredStyle: .actionSheet)
        //回帰が押された場合
        kaikiAlert.addAction(UIAlertAction(title:"回帰",style:.default,handler: { action in
            self.kaikiFlg = 1
            self.kenshinResult()
        }))
        //マイナス使用量が押された場合
        kaikiAlert.addAction(UIAlertAction(title:"マイナス使用量",style:.destructive,handler: { action in self.kaikiFlg = 0}))
        //キャンセルが押された時
        kaikiAlert.addAction(UIAlertAction(title:"キャンセル",style:.cancel,handler: { action in self.reset()}))
        
        // バイブレーション
        AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        
        //回帰確認アクションシートの出力
        self.present(kaikiAlert, animated: true, completion: nil)
    }
    
    //３桁以下入力時点のツールバー
    func openCancelBar(){
        //↓↓↓数字キーボードの上に「Cancel」を挿入する↓↓↓
        let toolBar:UIToolbar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.sizeToFit()
        let cancelButton:UIBarButtonItem = UIBarButtonItem(title: "キャンセル", style: UIBarButtonItem.Style.plain, target: self, action: #selector(pushCancel(_:)))
        let toolBarItems = [cancelButton]
        toolBar.setItems(toolBarItems, animated: true)
        gmtSijiSu.inputAccessoryView = toolBar
        //↑↑↑数字キーボードの上に「Cancel」を挿入する↑↑↑
    }
    
    //４桁入力後のツールバー
    func openCancelDoneBar(){
        //↓↓↓数字キーボードの上に「Done」「Cancel」を挿入する↓↓↓
        let toolBar:UIToolbar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.sizeToFit()
        let cancelButton:UIBarButtonItem = UIBarButtonItem(title: "キャンセル", style: UIBarButtonItem.Style.plain, target: self, action: #selector(pushCancel(_:)))
        let spacer:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        let setButton:UIBarButtonItem = UIBarButtonItem(title: "登録", style: UIBarButtonItem.Style.plain, target: self, action: #selector(pushDone(_:)))
        let toolBarItems = [cancelButton,spacer,setButton]
        
        toolBar.setItems(toolBarItems, animated: true)
        gmtSijiSu.inputAccessoryView = toolBar
        //↑↑↑数字キーボードの上に「Done」「Cancel」を挿入する↑↑↑
    }
    
    //取消ボタン押下時
    @IBAction func resultCancel(_ sender: Any) {
        //アラートの定義
        let resultCancelAlert = UIAlertController(title: "検針結果取消", message:"よろしいですか？", preferredStyle: .alert)
        //アラートキャンセルボタン押下時の処理
        resultCancelAlert.addAction(UIAlertAction(title:"キャンセル",style:.cancel,handler:nil))
        //アラートOKボタン押下時の処理
        resultCancelAlert.addAction(UIAlertAction(title:"OK",style:.default,handler: { action in self.resetResult()}))
        //指示数確認アラートの出力
        self.present(resultCancelAlert, animated: true, completion: nil)
    }
    

    //検針結果登録、画面表示
    func kenshinResult(){
    
        // 今回ガス使用量を算出
        // 回帰の場合は、今回ガスメータ指示数に10000を足してから引く
        var tempGasUsage:Int = 0
        if(kaikiFlg == 1){
            tempGasUsage = Int(gmtSijiSu.text!)! + 10000 - Int(oldGasSiji.text!)!
        } else{
            tempGasUsage = Int(gmtSijiSu.text!)! - Int(oldGasSiji.text!)!
        }
        gasUsage.text   = tempGasUsage.description
        
        //　本日日付の取得
        let f = DateFormatter()
        f.dateFormat = "yyyyMMdd"
        print("日付：",f.string(from: Date()))
        let date = f.string(from: Date())
        let datedate:NSDate = NSDate();
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedObjectContext = appDelegate.managedObjectContext
        let Reading_results = NSEntityDescription.insertNewObject(forEntityName: "Reading_results", into: managedObjectContext) as! Reading_results
 
        //配列の要素定義
        Reading_results.gmt_set_no = self.gmtSetNo
        Reading_results.constract_started_at = customers[selectionNumber].constract_started_at
        Reading_results.gas_usage = Int16(tempGasUsage)
        Reading_results.gmt_sizi_su = Int16(self.gmtSijiSu.text!)!
        Reading_results.is_opend = customers[selectionNumber].kaiheisen_code
        Reading_results.knsn_method = customers[selectionNumber].knsn_method_code
        Reading_results.knsn_tnt_emp_no = customers[selectionNumber].knsn_tnt_emp_no
        Reading_results.knsn_ymd = date
        Reading_results.readed_at = datedate
        Reading_results.updated_at = datedate
        Reading_results.created_at = datedate

        self.result_instance.insertReadingResult(otifications: Reading_results)
        self.checkResult()

    }
    
    //リセット(キャンセルした時)
    func reset(){
        self.gmtSijiSu.text = nil // 今回指示数をブランクに。
        self.gasUsage.text = String(0)   // 今回使用量を0に。
        kaikiFlg = 0                           //回帰フラグを初期値に変更
        
        //検針済かチェックして各処理行う。
        self.checkResult()
    }
    
    //検針結果取消(検針済の結果を取り消すとき時)
    func resetResult(){
        self.gmtSijiSu.text = nil // 今回指示数をブランクに。
        self.gasUsage.text = String(0)   // 今回使用量を0に。
        kaikiFlg = 0                           //回帰フラグを初期値に変更
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedObjectContext = appDelegate.managedObjectContext
        let Reading_results = NSEntityDescription.insertNewObject(forEntityName: "Reading_results", into: managedObjectContext) as! Reading_results
        
        Reading_results.gmt_set_no = self.gmtSetNo
        
        print("deleteReadingResult前")
        self.result_instance.deleteReadingResult(delObj: Reading_results)
        print("deleteReadingResult後")
        
        //検針済かチェックして各処理行う。
        self.checkResult()
    }
        
    //「次のお客さま」or「お客さま一覧（MAP）」に遷移
    override func prepare(for segue:UIStoryboardSegue, sender: Any?){
        if segue.identifier == "toNextCustomer"{
            print("toNextCustomer呼び出し")
            
            let nav = segue.destination as! UINavigationController
            let customerView = nav.topViewController as! CustomerViewController
            customerView.customers = self.customers
            customerView.selectionNumber = self.selectionNumber + 1
            
        }else if segue.identifier == "toMap"{
            print("toMap呼び出し")
            //map画面に何か渡すなら記述。
        }
    }

    // カメラのライトボタンを押された時の動作
    @IBAction func cameraLight(_ sender: Any) {

        if(cameraLightStatus){
            lightOnOff(flg: true)
            cameraLightStatus = false
        }
        else{
            lightOnOff(flg: false)
            cameraLightStatus = true
        }
    }
    
    // カメラのライトのON・OFF
    func lightOnOff(flg:Bool) {
        if let avDevice = AVCaptureDevice.default(for: AVMediaType.video){
            
            if avDevice.hasTorch {
                do {
                    // torch device lock on
                    try avDevice.lockForConfiguration()
                    
                    if (flg){
                        // flash LED ON
                        avDevice.torchMode = AVCaptureDevice.TorchMode.on
                    } else {
                        // flash LED OFF
                        avDevice.torchMode = AVCaptureDevice.TorchMode.off
                    }
                    
                    // torch device unlock
                    avDevice.unlockForConfiguration()
                    
                } catch {
                    print("Torch could not be used")
                }
            } else {
                print("Torch is not available")
            }
        }
    }
    
}

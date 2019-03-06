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
    
    var containers: Array<UIView> = []
    var customer_instance: CustomersClass!
    var customers:[Customers] = []
    var cust:CustomersClass!
    
    var result_instance: ReadingResultClass!
    var results:[Reading_results] = []
    
    //var customerData:KenshinData?   // お客さま情報詳細を確認する＆検針をするお客さまデータ
    //var adrs:(gyo:Int, retsu:Int)?  // 検針データリストから特定のお客さまを選択するために使用するアドレスを格納する
    var kaikiFlg:Int? = 0           //回帰フラグ
    //var countMax:Int? //対象号の配列のMAX値
    var cameraLightStatus:Bool = true   // カメラのライト状態
    
    /*
    必要なデータ操作。
     ・お客様テーブルの参照・・・起動時画面表示→途中
     ・結果テーブルの参照・・・起動時画面表示→未　1ペケからの参照メソッドが今の所ない。
     ・結果テーブルのレコード挿入・・・検針結果登録→未
     ・結果テーブルのレコード削除・・・検針結果取消→未
     ・号の最後のお客様かチェック・・・画面遷移先の変更→未
    */

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.delegate = self
        
        self.customer_instance = CustomersClass()
        
        
        //テスト用データ
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        // テスト　ガスメータ設置場所番号：10010010010　の各情報を取得して表示
        customers = self.customer_instance.selectCustomersByGmtSetNo(gmt_set_no: "10010010010")
        //meterNo.text = customers[0].meter_no
        //oldGasSiji.text = customers[0].old_gas_shizi.description //0になっちゃう。。。。
        //b1Ryo.text = customers[0].b1_ryo.description //0になっちゃう。。。。
        //gmtSijiSu.text   = customerData?.getNowGasShiji().description // 今回指示数　descriptionでStringに変換
        //gasUsage.text   = customerData?.getNowGasRyo().description // 今回使用量　descriptionでStringに変換
        
        
        // テスト　ガスメータ設置場所番号：10010010010　のデータが存在するか確認。
        customers = self.customer_instance.selectCustomersByGmtSetNo(gmt_set_no: "10010010010")
        
        

        print("建物名",customers[0].tatemono_cana)
        print(customers[0].adrs_banchi)
        print(customers[0].adrs_chou)
        print(customers[0].adrs_goh)
        print(customers[0].apart_heya_ban_cana)
        print(customers[0].b1_kikan)
        print(customers[0].b1_ryo)
        print(customers[0].bb1_kikan)
        print(customers[0].bb1_ryo)
        print(customers[0].bb2_kikan)
        print(customers[0].bb2_ryo)
        print(customers[0].constract_started_at)
        print(customers[0].created_at)
        print(customers[0].customer_name_cana)
        print(customers[0].customer_name_kanzi)
        print(customers[0].flyer_refused)
        print(customers[0].gmt_set_no)
        print(customers[0].goh_ban)
        print(customers[0].heya_ban_cana)
        print(customers[0].ichi_code)
        print(customers[0].in_dog)
        print(customers[0].in_dog_code)
        print(customers[0].kaiheisen_code)
        print(customers[0].ken_seq)
        print(customers[0].knsn_method_code)
        print(customers[0].knsn_tnt_emp_no)
        print(customers[0].memo)
        print(customers[0].meter_no)
        print(customers[0].mune_ban_cana)
        print(customers[0].name_j)
        print(customers[0].next_date)
        print(customers[0].old_gas_shizi)
        print(customers[0].opened_at)
        print(customers[0].out_dog)
        print(customers[0].out_dog_code)
        print(customers[0].service_info)
        print(customers[0].tatemono_cana)
        print(customers[0].tatemono_kanzi)
        print(customers[0].teirei_date)
        print(customers[0].tel_no)
        print(customers[0].updated_at)
        print(customers[0].wireless_used)
        print(customers[0].yago_cana)
        print(customers[0].yago_kanzi)
        print(customers[0].yuso_setted)
        
        
        
        
        
        
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
        
        
        /*
        //号の最後のお客さまかチェック。「次のお客さま」を非活性にする。
        if( countMax == adrs!.retsu + 1){
            print("一致！")//後で消す
            self.nextMetr.isEnabled = false //次ボタンを非活性化
            //self.gouSelect.isEnabled = true //号選択ボタンを活性化
        }else{
            print("不一致！")//後で消す
            //self.nextMetr.isEnabled = true //次ボタンを活性化
            //self.gouSelect.isEnabled = false //号選択ボタンを非活性化
        }
        */

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
        
        /*
        //今回指示数欄を登録済みの検針結果に戻す。
        if( customerData?.getNowGasShiji() == 0 ){
        */
            gmtSijiSu.text = nil
        /*
        }else{
            gmtSijiSu.text   = customerData?.getNowGasShiji().description
        }
        */
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
        
        /*
        //検針済なら・・・
        if (customerData?.getSumiFlg() == 1) {
            //指示数入力欄を灰色にして非活性化
            self.gmtSijiSu.isEnabled = false
            self.gmtSijiSu.backgroundColor = UIColor.lightGray
            //取消ボタンを赤色にして活性化
            self.resultCancel.isEnabled = true
            self.resultCancel.backgroundColor = UIColor.red
            self.cameraLightButton.isEnabled = false
            //未検針なら
        }else{
            //指示数入力欄を白色にして活性化
            self.gmtSijiSu.isEnabled = true
            self.gmtSijiSu.backgroundColor = UIColor.white
            //取消ボタンを灰色にして非活性化
            self.resultCancel.isEnabled = false
            self.resultCancel.backgroundColor = UIColor.lightGray
            self.cameraLightButton.isEnabled = true
        }
        */

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
        resultCancelAlert.addAction(UIAlertAction(title:"OK",style:.default,handler: { action in self.reset()}))
        //指示数確認アラートの出力
        self.present(resultCancelAlert, animated: true, completion: nil)
    }
    

    //検針結果登録、画面表示
    func kenshinResult(){
        
        /*
        KenshinInfoController.setKenshinResult(kenshinData: self.customerData!, nowGasShiji: Int(self.gmtSijiSu.text!)!,kaikiFlg:self.kaikiFlg!, gyo: self.adrs!.gyo, retsu: self.adrs!.retsu)
        self.gasUsage.text   = self.customerData?.getNowGasRyo().description
        self.checkResult()
        */
    }
    
    //リセット(キャンセルした時とかに呼ばれる)
    func reset(){
        self.gmtSijiSu.text = nil // 今回指示数をブランクに。
        self.gasUsage.text = String(0)   // 今回使用量を0に。
        kaikiFlg = 0                           //回帰フラグを初期値に変更
        /*
        KenshinInfoController.setKenshinresultCancel(kenshinData: self.customerData!, gyo: self.adrs!.gyo, retsu: self.adrs!.retsu)
        */
        //検針済かチェックして各処理行う。
        self.checkResult()
        
    }
    
    /*
    //ナビゲーションバーで戻った時の処理
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if viewController is JizenInfoTsutiViewController {
            //挿入したい処理
            self.adrs!.retsu = adrs!.retsu - 1
            viewController.viewDidLoad()
        }
    }
    */
    
    
    /*
    //次のお客様に遷移
    @IBAction func nextMetr(_ sender: Any) {
        print("nextMetr()も呼ばれてる。")//後で消す
        
    }
    */
    
    
    /*
    //「次のお客様」or「号選択」に遷移
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "nextJizenInfoTsuti" {
            self.adrs!.retsu = adrs!.retsu + 1 //列番号をカウントアップして、次のメーターの番号を設定前
            (segue.destination as! JizenInfoTsutiViewController).adrs = adrs
            (segue.destination as! JizenInfoTsutiViewController).countMax = self.countMax
        }else if segue.identifier == "toGouSelect" {//号選択に遷移
        }
    }
    */
    
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

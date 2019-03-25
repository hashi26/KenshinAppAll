//
//  VCHello.swift
//  KenshinAppAll
//
//  Created by 1490402 on 2019/01/31.
//  Copyright © 2019 KenshinT. All rights reserved.
//

import UIKit
import CoreMotion //歩数カウントのため

class HelloViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

  @IBOutlet weak var UserImage: UIImageView!
  @IBOutlet weak var healthTableView: UITableView!
  @IBOutlet weak var UserName: UILabel!
  
  var motion = [Motion]()
  //var reading_person:[Reading_person] = []
  var reading_person:Reading_person!
  let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
  //Loginより受け取ったreadingPerson
  //使用例：recievedPerson?.knsn_tnt_name
  var recievedPerson:Reading_person?
  
  // 他クラスインスタンス用変数
  var person_instance: ReadingPersonClass!
  
  // class wide constant !!
  let pedometer = CMPedometer()
  
  override func viewDidLoad() {
      
    super.viewDidLoad()
    
    // ログイン画面には戻れないようにする
    self.navigationItem.hidesBackButton = true
    
    //プロフィール画像を取得
    if UserDefaults.standard.object(forKey:"profileImage") != nil{
      let object = UserDefaults.standard.object(forKey: "profileImage") as? NSData
      UserImage.image = UIImage(data: object! as Data)
      UserImage.contentMode = .scaleAspectFit
      UserImage.clipsToBounds = true
    }else{
      //未設定であれば初期画像を表示
      UserImage.image  = UIImage(named:"no_image")
      UserImage.contentMode = .scaleAspectFit
      UserImage.clipsToBounds = true
    }
    
    // ReadingPersonClassインスタンス生成
    self.person_instance = ReadingPersonClass()
    //担当者の取得
    reading_person = appDelegate.loginReadingPerson
    // テスト　検針担当者：10010010010　の氏名を取得して表示
    //self.person_instance.selectReadingPersonByKnsnTntEmpNo(knsn_tnt_emp_no: "2010123")//★将来的に渡された値を代入
    UserName.text = reading_person.knsn_tnt_name
  
    //motionに初期値を格納
    motion.append(Motion(category: "歩数", result1: 0, result2: 0.0)) //motion[0]に歩数を登録
    motion.append(Motion(category: "距離", result1: 0, result2: 0.0)) //motion[1]に距離を登録
    motion.append(Motion(category:"平均速度", result1: 0, result2: 0.0)) //motion[2]に平均速度を登録
    
    //カスタムセルを利用するためにビューに登録
    healthTableView.register (UINib(nibName: "HealthCustomViewCell", bundle: nil),forCellReuseIdentifier:"HealthCustomViewCell")
    
    /**********************************
     万歩計の実装
     **********************************/
    
    // CMPedometerの確認
    if(CMPedometer.isStepCountingAvailable()){
      print("CMPedometerの実行")
      self.pedometer.startUpdates(from: NSDate() as Date) {
        (data: CMPedometerData?, error) -> Void in
        DispatchQueue.main.async(execute: { () -> Void in
          print("来た")
          if(error == nil){
            // 歩数 NSNumber?
            let steps = data!.numberOfSteps
            
            self.motion[0].result1 = steps.intValue
            
            // 距離 NSNumber?
            let distance = data!.distance!.doubleValue
            
            
            self.motion[1].result1 = Int(distance)
          
            // 平均ペース NSNumber?
            let averageActivePace = data!.averageActivePace
            let averageActivePace2 = round(averageActivePace!.doubleValue * 3.6 * 10)/10
            
            //self.motion[2].healthValue2 = averageActivePace!.doubleValue
            self.motion[2].result2 = averageActivePace2
            
            //テーブルビューデータをリロードする
            self.healthTableView.reloadData()
           }
         })
        
        }
     }
        // Do any additional setup after loading the view.
    }
  
  
  
  /// セルの個数を指定するデリゲートメソッド（必須）
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return motion.count
  }
  /// セルに値を設定するデータソースメソッド（必須）
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    // セルを取得する
    let cell = tableView.dequeueReusableCell(withIdentifier: "HealthTableViewCell") as! HealthCustomViewCell
    //let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "HealthCustomViewCell", for: indexPath) //新セル
    // セルに表示する値を設定する
      cell.setupCell(model: motion[indexPath.row])
   // }
    return cell
  }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

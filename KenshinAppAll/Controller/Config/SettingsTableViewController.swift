//
//  SettingsTableViewController.swift
//  SampleApp05
//
//  Created by iNET TG on 2019/02/20.
//  Copyright © 2019年 iNET TG. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    @IBOutlet weak var fontLabel: UILabel!
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var imageLabel: UILabel!
    @IBOutlet weak var manualLabel: UILabel!
    @IBOutlet weak var fqLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(userDefaultsDidChange), name: UserDefaults.didChangeNotification, object: nil)
        
        if let version: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String{
            versionLabel.text = version
        }

        if let systemFontSize = UserDefaults.standard.value(forKey: "systemFontSize") as? Int{
            fontLabel.text = "\(systemFontSize)"
        }else{
            fontLabel.text = "\(UIFont.systemFontSize)"
        }

        //fontLabel.text = "\(UIFont.systemFontSize)"
        //fontLabel.text = "\(UILabel.appearance().defaultFont)"
        
        
        /*
        if let name = UserDefaults.standard.value(forKey: "name") as? String{
            fontLabel.text = name
        }
        */
    }
    
    //セクションの数を返す
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    //セクションごとのセルの数を返す
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return 3
        default:
            return 0
        }
    }
    
    //セルが押された時の処理
    /*
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0{
            switch indexPath.row{
            case 0:
                performSegue(withIdentifier: "Font", sender: nil)
            case 1:
                performSegue(withIdentifier: "Profile", sender: nil)
            default:
                print("aaaa")
            }
        }else{
            switch indexPath.row{
            case 0:
                print("version")
            case 1:
                performSegue(withIdentifier: "Manual", sender: nil)
            case 2:
                performSegue(withIdentifier: "FAQ", sender: nil)
            default:
                print("aaaa")
            }

        }
    }
     */
    
    
    @objc func userDefaultsDidChange(_ notification: Notification){
        if let systemFontSize = UserDefaults.standard.value(forKey: "systemFontSize") as? Int{
            fontLabel.text = "\(systemFontSize)"
        }else{
            fontLabel.text = "\(UIFont.systemFontSize)"
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self,name: UserDefaults.didChangeNotification,object:nil)
    }
    
}

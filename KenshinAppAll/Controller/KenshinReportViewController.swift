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

class KenshinReportViewController: UIViewController,UINavigationControllerDelegate {
    
    @IBOutlet weak var meterNo: UILabel!
    @IBOutlet weak var oldGasSiji: UILabel!
    @IBOutlet weak var b1Ryo: UILabel!
    @IBOutlet weak var gmtSijiSu: UITextField!
    @IBOutlet weak var gasUsage: UILabel!
    @IBOutlet weak var resultCancel: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

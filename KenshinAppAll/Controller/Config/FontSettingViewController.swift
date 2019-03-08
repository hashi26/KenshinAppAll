//
//  FontSettingViewController.swift
//  SampleApp05
//
//  Created by iNET TG on 2019/02/28.
//  Copyright © 2019年 iNET TG. All rights reserved.
//

import UIKit

class FontSettingViewController: UIViewController {

    @IBOutlet weak var fontSizeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var fontSizeSlider: UISlider!
    
    @IBAction func sliderDidChangeValue(_ sender: UISlider) {
        let fontSize = Int(sender.value)
        fontSizeLabel.text = "フォントサイズ：\(fontSize)"
        fontSizeLabel.font = UIFont.systemFont(ofSize: CGFloat(fontSize))
        descriptionLabel.font = UIFont.systemFont(ofSize: CGFloat(fontSize))
        
        UserDefaults.standard.set(fontSize, forKey: "systemFontSize")
        //UILabel.appearance().defaultFont = UIFont.systemFont(ofSize: CGFloat(fontSize))
        //UILabel.appearance().font = UIFont(name: "Gills Sans", size: CGFloat(sender.value))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let systemFontSize = UserDefaults.standard.value(forKey: "systemFontSize") as? Int{
            fontSizeLabel.text = "フォントサイズ：\(systemFontSize)"
            fontSizeLabel.font = UIFont.systemFont(ofSize: CGFloat(systemFontSize))
            descriptionLabel.font = UIFont.systemFont(ofSize: CGFloat(systemFontSize))
            fontSizeSlider.value = Float(systemFontSize)
        }else{
            fontSizeLabel.text = "フォントサイズ：\(UIFont.systemFontSize)"
            fontSizeSlider.value = Float(UIFont.systemFontSize)
        }
        
        
        

        // Do any additional setup after loading the view.
        //descriptionLabel.numberOfLines = 0
        //descriptionLabel.sizeToFit()
        
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

/*
extension UILabel{
    var defaultFont: UIFont{
        get{
            return self.font
        }
        set{
            self.font = newValue
        }
    }
}
 */

extension UISlider{
    override open func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        return true
    }
}

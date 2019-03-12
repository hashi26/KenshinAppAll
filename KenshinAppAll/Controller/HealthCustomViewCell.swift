//
//  HelthCustomViewCell.swift
//  KenshinAppAll
//
//  Created by M_HASHIZUME on 2019/03/05.
//  Copyright © 2019 KenshinT. All rights reserved.
//

import UIKit

class HealthCustomViewCell: UITableViewCell {

  @IBOutlet weak var CategoryImage: UIImageView!
  @IBOutlet weak var Category: UILabel!
  @IBOutlet weak var Result2: UILabel!
  @IBOutlet weak var Result1: UILabel!
  var image3 = UIImage()
  
  func setupCell(model:Motion ) {
    //項目名
    Category.text = model.category
    
    //項目値1
    Result1.text = String(model.result1)
    
    //項目値2
    //mをKmに変換
    Result2.text = String(model.result2)
    
    
    
    //画像
    //画像のアスペクト比を調整（Aspect Fit = 縦横の比率はそのままで長い辺を基準に全体を表示する）
    CategoryImage.contentMode = UIView.ContentMode.scaleAspectFit
    if(model.category == "歩数"){
      CategoryImage.image = UIImage(named: "walking")
      Result1.text = String(model.result1) + " 歩"
      Result2.alpha = 0
    }else if(model.category == "距離"){
      CategoryImage.image = UIImage(named:"distance")
      Result1.text = String(model.result1) + " m"
      Result2.alpha = 0
    }else{
      CategoryImage.image  = UIImage(named:"ave_speed")
      Result2.text = String(model.result2) + " Km/時"
      Result1.alpha = 0
    }
    
  }
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

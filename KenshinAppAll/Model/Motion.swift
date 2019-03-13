//
//  File.swift
//  KenshinAppAll
//
//  Created by M_HASHIZUME on 2019/03/05.
//  Copyright © 2019 KenshinT. All rights reserved.
//

import Foundation

class Motion: Codable{
  //項目名
  var category: String
  
  //項目値(Int)
  var result1: Int
  
  //項目値(Double)
  var result2: Double
  
  //項目値（TimeInterval)
  //var result3: TimeInterval
  
  init(category: String, result1: Int, result2: Double){
    self.category = category
    self.result1 = result1
    self.result2 = result2
  }
}


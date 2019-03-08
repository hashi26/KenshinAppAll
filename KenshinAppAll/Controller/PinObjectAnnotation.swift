//
//  PinObjectAnnotation.swift
//  KenshinAppAll
//
//  Created by Harada Hiroaki on 2019/03/08.
//  Copyright © 2019 KenshinT. All rights reserved.
//

import Foundation
import UIKit
import MapKit

//Mapのクラスタリング機能を利用するためのクラスを定義
class PinObjectAnnotation: NSObject, MKAnnotation {
    
    static let clusteringIdentifier = "GohObject"
    
    let coordinate: CLLocationCoordinate2D
    
    let glyphText: String
    
    let glyphTintColor: UIColor
    
    let markerTintColor: UIColor
    
    let title: String?
    
    init(_ coordinate: CLLocationCoordinate2D, glyphText: String, glyphTintColor: UIColor, markerTintColor: UIColor,title:String) {
        print("PinObjectAnnotationの初期化")
        self.coordinate = coordinate
        self.glyphText = glyphText
        self.glyphTintColor = glyphTintColor
        self.markerTintColor = markerTintColor
        self.title = title
        
        
    }
    
}

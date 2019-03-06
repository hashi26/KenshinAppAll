//
//  CustomerListViewController.swift
//  KenshinAppAll
//
//  Created by Harada Hiroaki on 2019/03/06.
//  Copyright © 2019 KenshinT. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

class CustomerListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,MKMapViewDelegate,CLLocationManagerDelegate,UIGestureRecognizerDelegate {
    @IBOutlet weak var AreaMapView: MKMapView!
    @IBOutlet weak var customerTableView: UITableView!
    
    //アノテーションをクラスタリングさせるための変数
    var annotation:[GohObjectAnnotation] = []
    var locationManager: CLLocationManager!//位置情報の機能を管理するためのインスタンス
    
    var customer:CustomersClass = CustomersClass()
    var goh:GohClass = GohClass()
    
    //経路を表示させるための変数
    var userLocation: CLLocationCoordinate2D!
    var destLocation: CLLocationCoordinate2D!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customerTableView.register(UINib(nibName:"CustomerTableViewCell",bundle: nil),forCellReuseIdentifier:"CustomerTableViewCell")
        
        
        //Customerデータを取得できるか確認
        //var customers:[Customers] = customer.selectCustomers() //CustomerClassでselect関数が実装され次第確認する
        
        //初期動作をお客さま一覧画面にしているため、AppDelegateが思うような順番で動いていない。
        //そのため、下記にCoreData挿入ロジックを入れ無理矢理データを存在させる対応とする。
        if (goh.selectGoh()).isEmpty {
        goh.initInsertGoh()
        }
        
        if (customer.selectCustomers()).isEmpty {
        customer.initInsertCustomers()
        }
        
        //Gohデータを取得できるか確認
        var gohs:[Goh] = goh.selectGoh()
        var customers:[Customers] = customer.selectCustomers()
        
        print("customerの件数")
        print(customers.count)
        
        print("Gohの件数")
        print(gohs.count)
        print("gohs[0].gou_ban",gohs[0].gou_ban)
        print("gohs[1].towns_name_c",gohs[0].towns_name_c)
        
        
        
        
        
        /****************************
         ここから地図表示
         ****************************/
        //locationManagerオブジェクトの初期化
        setupLocationManager()
        
        //自分の現在地座標を登録
        let ano1 = GohObjectAnnotation(CLLocationCoordinate2D(latitude: 35.635531, longitude: 139.706093), glyphText:"現在地", glyphTintColor: .white, markerTintColor: .blue,title: "現在地")
        
        //近くのハローメイトを登録
        let ano2 = GohObjectAnnotation(CLLocationCoordinate2D(latitude: 35.639831, longitude: 139.709593), glyphText:"橋爪", glyphTintColor: .white, markerTintColor: .blue,title: "橋爪")
        let ano3 = GohObjectAnnotation(CLLocationCoordinate2D(latitude: 35.633231, longitude: 139.700593), glyphText:"野中", glyphTintColor: .white, markerTintColor: .blue,title: "野中")
        
        AreaMapView.addAnnotation(ano1)
        AreaMapView.addAnnotation(ano2)
        AreaMapView.addAnnotation(ano3)
        
        self.userLocation = CLLocationCoordinate2DMake(35.635531, 139.706093)
        
        //表示範囲
        let span = MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
        
        //中心座標と表示範囲をマップに登録する。
        let region = MKCoordinateRegion(center: self.userLocation, span: span)
        self.AreaMapView.setRegion(region, animated:false)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "CustomerTableViewCell", for: indexPath) //新セル
        if let cell = cell as? CustomerTableViewCell {
            cell.samplelogic(ij: indexPath)
        }
        return cell
    }
    
    func setupLocationManager() {
        print("setupLocationManagerの実行")
        locationManager = CLLocationManager()
        guard let locationManager = locationManager else { return }
        locationManager.requestWhenInUseAuthorization()
        
        let status = CLLocationManager.authorizationStatus()
        if status == .authorizedWhenInUse {
            locationManager.delegate = self
            locationManager.distanceFilter = 10
            locationManager.startUpdatingLocation()
        }
    }
    
    //Mapクラスタリンク用に作成
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier, for: annotation)
        
        guard let markerAnnotationView = annotationView as? MKMarkerAnnotationView,
            let gohObjectAnnotation = annotation as? GohObjectAnnotation else { return annotationView }
        
        markerAnnotationView.clusteringIdentifier = GohObjectAnnotation.clusteringIdentifier
        markerAnnotationView.glyphText = gohObjectAnnotation.glyphText
        markerAnnotationView.glyphTintColor = gohObjectAnnotation.glyphTintColor
        markerAnnotationView.markerTintColor = gohObjectAnnotation.markerTintColor
        
        return markerAnnotationView
    }
    
}

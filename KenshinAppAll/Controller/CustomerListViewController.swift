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
    @IBOutlet weak var customerSearchBar: UISearchBar!
    @IBOutlet weak var nextButton: UIButton!
    
    //アノテーションをクラスタリングさせるための変数
    var annotation:[GohObjectAnnotation] = []
    var locationManager: CLLocationManager!//位置情報の機能を管理するためのインスタンス
    
    var customer:CustomersClass = CustomersClass()
    var goh:GohClass = GohClass()
    var gohs:[Goh] = []
    var customers:[Customers] = []
    var selectedNumber:Int = 0
    
    //検索結果配列
    var searchResult = [Customers]()
    var resultNumber:[Int] = [] //customerからどのデータがsearchResultに格納されたのか保管する配列
    
    //経路を表示させるための変数
    var userLocation: CLLocationCoordinate2D!
    var destLocation: CLLocationCoordinate2D!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //nextButtonの非活性化
        nextButton.alpha = 0
        nextButton.isEnabled = false
        
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
        gohs = goh.selectGoh()
        customers = customer.selectCustomers()
        
        /****************************
         地図表示の実装
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
        
        
        /****************************
         検索バーの実装
         ****************************/
        //デリゲート先を自分に設定する。
        customerSearchBar.delegate = self
        
        //何も入力されていなくてもReturnキーを押せるようにする。
        customerSearchBar.enablesReturnKeyAutomatically = false
        
        //検索結果配列にデータをコピーする。
        searchResult = self.customers
        
        for (index,_) in searchResult.enumerated(){
            resultNumber.append(index)
        }
        
        //キャンセルボタンの追加
        customerSearchBar.showsCancelButton = true
        
        //プレースホルダの指定
        customerSearchBar.placeholder = "検索文字列を入力してください"
        
    }
    
    //検索ボタン押下時の呼び出しメソッド
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("検索ボタン押下時メソッドが実行されるか")
        customerSearchBar.endEditing(true)
        
        //検索結果配列を空にする。
        searchResult.removeAll()
        resultNumber.removeAll()
        
        if(customerSearchBar.text == "") {
            //検索文字列が空の場合はすべてを表示する。
            searchResult = self.customers
            for (index,_) in searchResult.enumerated(){
                resultNumber.append(index)
            }
        }else{
            //検索文字列を含むデータを検索結果配列に追加する。
            for (index,data) in self.customers.enumerated() {
                //配列（data)の中に検索入力内容を含むデータがあるか調べる
                if data.customer_name_kanzi!.contains(customerSearchBar.text!){
                    searchResult.append(data)
                    resultNumber.append(index)
                }
                
                if data.gmt_set_no!.contains(customerSearchBar.text!) {
                    searchResult.append(data)
                    resultNumber.append(index)
                }
                
            }
        }
        
        //テーブルを再読み込みする
        customerTableView.reloadData()
        
        //キーボードを閉じる
        self.view.endEditing(true)
    }
    
    // Cell が選択された場合
    func tableView(_ tableView: UITableView,didSelectRowAt indexPath: IndexPath) {
        print("Cellの選択")
        //nextButtonを表示させる
        nextButton.alpha = 100
        nextButton.isEnabled = true
        
        //選択した列を変数に格納
        self.selectedNumber = resultNumber[indexPath.row]
        
        //選択されたセルから住所を割り出す
        
        //let ax = addressIdentify(gohx gohx:gohs[0], customerx: resultNumber[selectedNumber])
        //print("選択されたセルの住所：",ax)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("tableViewの実行")
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "CustomerTableViewCell", for: indexPath) //新セル
        if let cell = cell as? CustomerTableViewCell {
            cell.samplelogic(model: searchResult[indexPath.row])
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
    
    //住所作成用関数
    func addressIdentify(gohx: Goh ,customerx: Customers) -> String!{
        let city = gohx.towns_name_j!
        var chou  = self.customers[selectedNumber].adrs_chou!
        var banti = self.customers[selectedNumber].adrs_banchi!
        var goh   = self.customers[selectedNumber].adrs_goh!
        
        //Jsonファイルは先頭に0が含まれるので緯度、経度を求める前に事前削除しておく
        chou = chou.replacingOccurrences(of:"0",with:"")
        banti = banti.replacingOccurrences(of:"0",with:"")
        goh = goh.replacingOccurrences(of:"0",with:"")
        
        let street = chou + "-" + banti + "-" + goh
        let addressForLocation = city + street
        
        return addressForLocation
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

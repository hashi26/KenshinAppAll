//
//  ContactViewController.swift
//  KenshinAppAll
//
//  Created by 1490402 on 2019/02/07.
//  Copyright © 2019 KenshinT. All rights reserved.
//

import UIKit

class ContactViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var contactTableView: UITableView!
    @IBOutlet weak var ContactSearchBar: UISearchBar!
    
    var readingPerson:ReadingPersonClass = ReadingPersonClass()
    var readingPersons:[Reading_person] = []
    let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var loginPerson:Reading_person!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contactTableView.delegate = self
        contactTableView.dataSource = self
        
        ContactSearchBar.delegate = self
        //何も入力されていなくてもReturnキーを押せるようにする。
        ContactSearchBar.enablesReturnKeyAutomatically = false
        //キャンセルボタンの追加
        ContactSearchBar.showsCancelButton = true
        //プレースホルダの指定
        ContactSearchBar.placeholder = "氏名で検索ができます"

        //担当者の取得
        appDelegate.loginReadingPerson = readingPerson.selectReadingPersonByKnsnTntEmpNo(knsn_tnt_emp_no: "2059066")[0]
        loginPerson = appDelegate.loginReadingPerson
        
        // 担当者を除いた他メンバー一覧を取得
        readingPersons = readingPerson.selectReadingPersonExclusionSelf(knsn_tnt_emp_no: loginPerson.knsn_tnt_emp_no!)
        //readingPersons = readingPerson.selectReadingPerson()
        
        //セルのサイズ変更
        self.contactTableView.rowHeight = 75.0
        
        self.contactTableView.register (UINib(nibName: "ContactCell", bundle: nil),forCellReuseIdentifier:"ContactCell")
        
        self.contactTableView.reloadData()
        //self.contactTableView.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return readingPersons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as! ContactCell//新セル
        // セルに表示する値を設定する
        if let cell = cell as? ContactCell {
            cell.setupCell(model: readingPersons[indexPath.row])
        }
        return cell
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("検索ボタン押下時メソッドが実行されるか")
        ContactSearchBar.endEditing(true)
        
        if(ContactSearchBar.text == "") {
            //検索文字列が空の場合はすべてを表示する。
            readingPersons =  readingPerson.selectReadingPersonExclusionSelf(knsn_tnt_emp_no: loginPerson.knsn_tnt_emp_no!)
        }else{
            //検索文字列を含むデータを検索結果配列に追加する。
            print(searchBar.text! as String)
            readingPersons = readingPerson.selectReadingPersonByName(name: searchBar.text! as String, knsn_tnt_emp_no:loginPerson.knsn_tnt_emp_no!)
        }
        
        //テーブルを再読み込みする
        contactTableView.reloadData()
        //キーボードを閉じる
        self.view.endEditing(true)
    }
    
    // SearchBarのデリゲードメソッド
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // キャンセルされた場合、検索は行わない。
        searchBar.text = ""
        self.view.endEditing(true)
    }

}

//
//  FAQViewController.swift
//  SampleApp05
//
//  Created by iNET TG on 2019/03/04.
//  Copyright © 2019年 iNET TG. All rights reserved.
//

import UIKit

class FAQViewController: UITableViewController {

    @IBOutlet var FAQTableView: UITableView!
    
    var foldingFlug1 = true
    var foldingFlug2 = true
    var foldingFlug3 = true
    var foldingFlug4 = true

    var section1:Dictionary = [String:String]()
    var section2:Dictionary = [String:String]()
    var section3:Dictionary = [String:String]()
    var section4:Dictionary = [String:String]()
    
    var sections:Array = [Dictionary<String,String>]()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        section1 = ["Q1:どうするの":"A1:こうするの"]
        section2 = ["Q2:どうやるの":"A2:こうやるの"]
        section3 = ["Q3:どうしよう":"A3:こうしよう"]
        section4 = ["Q4:こんなとき":"A4:これでよし"]
        
        sections.append(section1)
        sections.append(section2)
        sections.append(section3)
        sections.append(section4)

        FAQTableView.delegate = self
        FAQTableView.dataSource = self
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.sections.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title = ""
        for (key) in sections[section].keys{
            title = key
        }
        return title
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return foldingFlug1 ? 0 : 1
        case 1:
            return foldingFlug2 ? 0 : 1
        case 2:
            return foldingFlug3 ? 0 : 1
        case 3:
            return foldingFlug4 ? 0 : 1
        default:
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath)

        for(value) in sections[indexPath.section].values{
            cell.textLabel?.text = value
        }
        

        return cell
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let myView:UIView = UIView()
        let label:UILabel = UILabel()
        for(key) in sections[section].keys{
            label.text = key
        }
        label.sizeToFit()
        label.textColor = UIColor.black
        myView.addSubview(label)
        
        myView.tag = section
        myView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tapHeader(gestureRecognizer:))))
        
        return myView
    }
    
    @objc func tapHeader(gestureRecognizer:UITapGestureRecognizer){
        guard let section = gestureRecognizer.view?.tag as Int! else{
            return
        }
        
        switch section {
        case 0:
            foldingFlug1 = foldingFlug1 ? false : true
        case 1:
            foldingFlug2 = foldingFlug2 ? false : true
        case 2:
            foldingFlug3 = foldingFlug3 ? false : true
        case 3:
            foldingFlug4 = foldingFlug4 ? false : true
        default:
            break
        }
        
        FAQTableView.reloadSections(NSIndexSet(index: section) as IndexSet,with:.none)
    }

}

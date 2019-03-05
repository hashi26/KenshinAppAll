//
//  ManualViewController.swift
//  SampleApp05
//
//  Created by iNET TG on 2019/03/04.
//  Copyright © 2019年 iNET TG. All rights reserved.
//

import UIKit
import PDFKit

class ManualViewController: UIViewController {

    @IBOutlet weak var pdfView: PDFView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let documentURL = Bundle.main.url(forResource: "kensin_handbook", withExtension: "pdf"){
            if let document = PDFDocument(url: documentURL){
                pdfView.autoScales = true
                pdfView.displaysPageBreaks = true
                pdfView.document = document
            }
        }

    }

}

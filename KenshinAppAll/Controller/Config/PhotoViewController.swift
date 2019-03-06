//
//  PhotoViewController.swift
//  SampleApp05
//
//  Created by iNET TG on 2019/03/05.
//  Copyright © 2019年 iNET TG. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
    
    var image:UIImage?

    @IBOutlet weak var profileImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImageView.image = image
        profileImageView.contentMode = UIView.ContentMode.scaleAspectFit

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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

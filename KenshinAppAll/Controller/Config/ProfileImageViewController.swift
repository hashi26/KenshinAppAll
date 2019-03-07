//
//  ProfileImageViewController.swift
//  SampleApp05
//
//  Created by iNET TG on 2019/03/05.
//  Copyright © 2019年 iNET TG. All rights reserved.
//

import UIKit

class ProfileImageViewController: UIViewController ,UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    @IBOutlet weak var profileLabel: UILabel!
    @IBOutlet weak var cameraView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileLabel.text = "tap button"
        
        defaultImage()

        // Do any additional setup after loading the view.
    }
    
    //カメラの撮影開始
    @IBAction func startCamera(_ sender: AnyObject) {
        let sourceType:UIImagePickerController.SourceType = UIImagePickerController.SourceType.camera
        
        UIImagePickerController.SourceType.camera
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            self.present(cameraPicker, animated: true, completion: nil)
        }else{
            profileLabel.text = "error"
        }
    }
    
    //写真を保存する。
    @IBAction func savePicture(_ sender: AnyObject) {
        let image:UIImage! = cameraView.image
        
        /*
        if image != nil{
            UIImageWriteToSavedPhotosAlbum(image, self, #selector(ProfileImageViewController.image(_:didFinishSavingWithError:contextInfo:)), nil)
        }else{
            profileLabel.text = "image Failed"
        }
         */
        let data = image.pngData() as NSData?
        if let imageData = data{
            UserDefaults.standard.set(imageData, forKey: "profileImage")
            //UserDefaults.standard.synchronize()
            profileLabel.text = "Save Succeeded"
        }
    }

    //アルバムを表示する。
    @IBAction func showAlbum(_ sender: AnyObject) {
        let sourceType:UIImagePickerController.SourceType = UIImagePickerController.SourceType.photoLibrary
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            self.present(cameraPicker, animated: true, completion: nil)
            
            profileLabel.text = "tap button"
        }else{
            profileLabel.text = "error"
        }
    }
    
    //撮影完了時に呼ばれる
    func imagePickerController(_ imagePicker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            cameraView.contentMode = .scaleAspectFit
            cameraView.image = pickedImage
        }
        
        //閉じる処理
        imagePicker.dismiss(animated: true, completion: nil)
        profileLabel.text = "tap button"
    }
    
    //撮影がキャンセルされた時に呼ばれる
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        profileLabel.text = "Canceled"
    }
    
    //書き込み完了結果の受け取り
    @objc func image(_ image:UIImage,didFinishSavingWithError error:NSError!,contextInfo: UnsafeMutableRawPointer){
        if error != nil{
            print(error.code)
            profileLabel.text = "Save Failed"
        }else{
            profileLabel.text = "Save Succeeded"
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func defaultImage(){
        if UserDefaults.standard.object(forKey:"profileImage") != nil{
            let object = UserDefaults.standard.object(forKey: "profileImage") as? NSData
            cameraView.image = UIImage(data: object! as Data)
            cameraView.contentMode = .scaleAspectFill
            cameraView.clipsToBounds = true
        }
    }
    
}

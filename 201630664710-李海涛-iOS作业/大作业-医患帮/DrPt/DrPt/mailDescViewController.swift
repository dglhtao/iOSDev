//
//  mailDescViewController.swift
//  TableView
//
//  Created by 李海涛 on 2019/11/6.
//  Copyright © 2019年 李海涛. All rights reserved.
//

import UIKit

class mailDescViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate {

    var mailForEdit: mail?
    
    
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var mailText: UITextView!
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    

    @IBAction func cameraButtonToTakePhoto(_ sender: UIBarButtonItem) {
        
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        
    }
    
    
    @IBAction func tapImage(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary
        //edit after take a pictrue
        //imagePickerController.allowsEditing = true
        //Make sure ViewController is notified when the user picks an image.
        imagePickerController.allowsEditing = true
        imagePickerController.delegate = self
        present(imagePickerController,animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //mailText.borderStyle = UITextField.BorderStyle.roundedRect

        // Do any additional setup after loading the view.
        navigationItem.title = mailForEdit?.name
        nameText.text = mailForEdit?.name
        mailText.text = mailForEdit?.mail
        photoView.image = mailForEdit?.photo
        
        if(photoView.image == nil){

            let image0 =  UIImage(imageLiteralResourceName:"ic_launcher")
            photoView.image = image0
        }
        
//        updateSaveButton()
    }
    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        // Hide the keyboard.
//        textField.resignFirstResponder()   //输入结束后 点击任意界面 隐藏键盘
//        return true
//    }
//
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        // Disable the Save button while editing.
//        saveButton.isEnabled = false
//    }
//
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        updateSaveButton()
//        navigationItem.title = textField.text
//    }

    
    // MARK: - Navigation

    //用于实现点击save后，信息的保存
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "save" {
            print("save")
            mailForEdit=mail(inputName: self.nameText.text!, inputMail: self.mailText.text!, inputPhoto: self.photoView.image!)
        }
        
        //self.photoView.image!
        if segue.identifier == "cancel" {
            print("cancel")
        }
    }
    
    // 选照片或者照照片之后，使手机识别到选了照片这一动作，并获得对应照片
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        //Set photoImageView to display the selected image.
        self.photoView.image = selectedImage
        
        //Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
//    func updateSaveButton() {
//        let text = nameText.text ?? ""
//        saveButton.isEnabled = !text.isEmpty
//    }
}

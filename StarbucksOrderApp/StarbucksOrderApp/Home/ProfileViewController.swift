//
//  ProfileViewController.swift
//  StarbucksOrderApp
//
//  Created by 양유진 on 2021/09/15.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var EditButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var levelTextField: UITextField!
    
    let info = userInfo.shared
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        levelTextField.isEnabled = true
        EditButton.setTitleColor(UIColor(red: 3/255, green: 102/255, blue: 53/255, alpha: 1), for: .normal)
        EditButton.backgroundColor = .white
        EditButton.layer.borderColor = UIColor(red:3/255, green:102/255, blue:53/255, alpha: 1).cgColor
        EditButton.layer.borderWidth = 1.0
        EditButton.layer.cornerRadius = 10

        nameTextField.text = info.username
        phoneTextField.text = info.phonenumber

    }
    
    @IBAction func clickToEdit(_ sender: Any) {
        
        if nameTextField.text == ""{
            print("again")
            let alert = UIAlertController(title: "알림", message: "이름은 필수 항목입니다.", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                return
            }
            alert.addAction(okAction)
            present(alert, animated: false, completion: nil)
        }else{
            print("ok")
            info.username = nameTextField.text!
            info.phonenumber = phoneTextField.text!
            
            navigationController?.popToRootViewController(animated: true)
        }
    }


    

}

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
            return
        }else{
            print("ok")
            info.username = nameTextField.text!
            info.phonenumber = phoneTextField.text!
            
            navigationController?.popToRootViewController(animated: true)
        }
    }


    

}

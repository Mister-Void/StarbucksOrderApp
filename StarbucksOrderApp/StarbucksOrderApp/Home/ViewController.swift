//
//  ViewController.swift
//  StarbucksOrderApp
//
//  Created by 양유진 on 2021/09/11.
//

import UIKit

class ViewController: UIViewController {
    
    let info = userInfo.shared
    
    @IBOutlet weak var nameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        nameLabel.text = "\(info.username)님, 안녕하세요!"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        nameLabel.text = "\(info.username)님, 안녕하세요!"
    }

    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }

    @IBAction func profileButton(_ sender: Any) {
        guard let profileVC = storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController else { return }
        self.navigationController!.pushViewController(profileVC, animated: true)
    }
    

}

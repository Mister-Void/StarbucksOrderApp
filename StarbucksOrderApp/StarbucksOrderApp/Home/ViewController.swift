//
//  ViewController.swift
//  StarbucksOrderApp
//
//  Created by 양유진 on 2021/09/11.
//

import UIKit
import StoreKit

class ViewController: UIViewController {
    
    let info = userInfo.shared
    
    @IBOutlet weak var nameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad - VC")
        // Do any additional setup after loading the view.
        nameLabel.text = "\(info.username)님, 안녕하세요!"
        
        // 앱 리뷰
        var count = UserDefaults.standard.integer(forKey: UserDefaultsKeys.processCompletedCountKey)
        count += 1
        print(count)
        UserDefaults.standard.set(count, forKey: UserDefaultsKeys.processCompletedCountKey)
        if count == 1{
            let twoSecondsFromNow = DispatchTime.now() + 1.0
            DispatchQueue.main.asyncAfter(deadline: twoSecondsFromNow) {
                if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
                    SKStoreReviewController.requestReview(in: scene)
                }
            }
        }
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

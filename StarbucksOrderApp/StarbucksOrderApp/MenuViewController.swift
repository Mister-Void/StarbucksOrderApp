//
//  MenuViewController.swift
//  StarbucksOrderApp
//
//  Created by 양유진 on 2021/09/13.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var orderButton: UIButton!
    
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false

    }


    

//MARK:- item 클릭 시 상세 뷰로 이동
    
    @IBAction func item1Clicked(_ sender: Any) {
        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
        detailVC.currentModel = 0
        self.navigationController!.pushViewController(detailVC, animated: true)
    }
    
    @IBAction func item2Clicked(_ sender: Any) {
        // 다음 컨트롤러에 대한 인스턴스 생성
        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
        detailVC.currentModel = 1
        self.navigationController!.pushViewController(detailVC, animated: true)
    }
    
    @IBAction func item3Clicked(_ sender: Any) {

        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
        detailVC.currentModel = 2
        self.navigationController!.pushViewController(detailVC, animated: true)
    }
    
    @IBAction func item4Clicked(_ sender: Any) {

        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
        detailVC.currentModel = 3
        self.navigationController!.pushViewController(detailVC, animated: true)
    }
    
    @IBAction func item5Clicked(_ sender: Any) {

        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
        detailVC.currentModel = 4
        self.navigationController!.pushViewController(detailVC, animated: true)
    }
    
}

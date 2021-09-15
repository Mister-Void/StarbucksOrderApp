//
//  DetailViewController.swift
//  StarbucksOrderApp
//
//  Created by 양유진 on 2021/09/13.
//

import UIKit

class DetailViewController: UIViewController {
    
    struct menuModel {
        let name: String
        let engName: String
        let caption: String
        let price: Int
        var cnt: Int
    }

    var menu: Array = [menuModel(name: "아이스 아메리카노", engName: "Iced Americano", caption: "진한 에스프레소에 시원한 정수물과 얼음을 더하여 스타벅스의 깔끔하고 강렬한 에스프레소를 가장 부드럽고 시원하게 즐길 수 있는 커피", price: 4100, cnt: 0),
                menuModel(name: "아이스 카페라떼", engName: "Iced Caffe Latte", caption: "풍부하고 진한 농도의 에스프레소가 시원한 우유와 얼음을 만나 고소함과 시원함을 즐길 수 있는 대표적인 커피 라떼", price: 4600, cnt: 0),
                menuModel(name: "카페 아메리카노", engName: "Caffe Americano", caption: "진한 에스프레소와 뜨거운 물을 섞어 스타벅스의 깔끔하고 강렬한 에스프레소를 가장 부드럽게 잘 느낄 수 있는 커피", price: 4100, cnt: 0),
                menuModel(name: "아이스 돌체라떼", engName: "Iced Dolce Latte", caption: "스타벅스의 다른커피 음료보다 더욱 깊은 커피의 맛과 향에 깔끔한 무지방 우유와 부드러운 돌체 시럽이 들어간 음료로 달콤하고 진한 커피 라떼", price: 5600, cnt: 0),
                menuModel(name: "자몽 허니 블랙티", engName: "Grapefruit Honey Black Tea", caption: "새콤한 자몽과 달콤한 꿀이 깊고 그윽한 풍미의 스타벅스 티바나 블랙티의 조화", price: 5300, cnt: 0)]
    
    @IBOutlet weak var cartButton: UIButton!
    @IBOutlet weak var cntLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var engNameLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var modifiedModel:Int = 0 // 현재 선택 model(수정 ver)
    var newModel: Int = 0 // 현재 선택 model(new ver)
    var thisismodify:Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        cartButton.layer.borderColor = UIColor(red:3/255, green:102/255, blue:53/255, alpha: 1).cgColor
        cartButton.layer.borderWidth = 1.0
        cartButton.layer.cornerRadius = 10
        
        let cart = CART.shared

        // UI 채우기
        if !thisismodify{
            switch newModel {
            case 0:
                img.image = UIImage(named: "1_item")
                nameLabel.text = menu[0].name
                engNameLabel.text = menu[0].engName
                captionLabel.text = menu[0].caption
                priceLabel.text = "\(String(menu[0].price)) 원"
            case 1:
                img.image = UIImage(named: "2_item")
                nameLabel.text = menu[1].name
                engNameLabel.text = menu[1].engName
                captionLabel.text = menu[1].caption
                priceLabel.text = "\(String(menu[1].price)) 원"
            case 2:
                img.image = UIImage(named: "3_item")
                nameLabel.text = menu[2].name
                engNameLabel.text = menu[2].engName
                captionLabel.text = menu[2].caption
                priceLabel.text = "\(String(menu[2].price)) 원"
            case 3:
                img.image = UIImage(named: "4_item")
                nameLabel.text = menu[3].name
                engNameLabel.text = menu[3].engName
                captionLabel.text = menu[3].caption
                priceLabel.text = "\(String(menu[3].price)) 원"
            case 4:
                img.image = UIImage(named: "5_item")
                nameLabel.text = menu[4].name
                engNameLabel.text = menu[4].engName
                captionLabel.text = menu[4].caption
                priceLabel.text = "\(String(menu[4].price)) 원"
            default:
                img.image = UIImage(named: "1_item")
                nameLabel.text = menu[0].name
                engNameLabel.text = menu[0].engName
                captionLabel.text = menu[0].caption
                priceLabel.text = "\(String(menu[0].price)) 원"
            }
        }else{
            nameLabel.text = cart.menuArray[modifiedModel]
            var i = 0
            for _ in menu{
                if nameLabel.text == menu[i].name{
                    modifiedModel = i
                }
                i += 1
            }
            img.image = UIImage(named: "\(modifiedModel+1)_item")
            nameLabel.text = menu[modifiedModel].name
            engNameLabel.text = menu[modifiedModel].engName
            captionLabel.text = menu[modifiedModel].caption
            priceLabel.text = "\(String(menu[modifiedModel].price)) 원"
        }

        
        // Stepper 관련 코드
        stepper.wraps = true
        stepper.autorepeat = true
        stepper.maximumValue = 100
        
    }

    override func viewDidAppear(_ animated: Bool) {
        // 뷰가 처음 시작할 때는 무조건 0개이므로 카트에 담을 수 없음
        cartButton.isEnabled = false
    }
    
    @IBAction func stepperValueChanged(sender: UIStepper)
    {
        cntLabel.text = Int(sender.value).description
        
        // 0개이면 카트에 담을 수 없음
        if cntLabel.text == "0"{
            cartButton.isEnabled = false
        }else{
            cartButton.isEnabled = true
        }
    }
    
    @IBAction func AddToCart(_ sender: Any) {
        let cart = CART.shared
        let cnt = cntLabel.text
        let price = priceLabel.text!.components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: "")
        
        if thisismodify{
            let index = cart.menuArray.firstIndex(of: nameLabel.text!)
            print(nameLabel.text as Any)
            print(index as Any)
            cart.countArray![index!] = Int(cnt!)!
            cart.totalPriceArray![index!] = Int(cnt!)! * Int(price)!
        }else{
            cart.menuArray.append(nameLabel.text!)
            cart.countArray?.append(Int(cnt!)!)
            cart.totalPriceArray?.append(Int(cnt!)! * Int(price)!)
        }
        
        // 현재 카트 상황
        print(cart.menuArray)
        print(cart.countArray as Any)
        print(cart.totalPriceArray as Any)

        backToCart(cartButton)
    }

    @objc func backToCart(_:UIButton){
//        print("DetailVC -> MenuVC")
        navigationController?.popToRootViewController(animated: true)
    }
    
}

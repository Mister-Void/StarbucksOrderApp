//
//  MenuViewController.swift
//  StarbucksOrderApp
//
//  Created by 양유진 on 2021/09/13.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var orderButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        orderButton.layer.cornerRadius = 10
        stackView.subviews.last!.tag = 1 // 버튼 tag 표시
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        
        let cart = CART.shared;
        if !cart.menuArray.isEmpty{
            for (index, num) in cart.menuArray.enumerated() {
                addEntry(menu: num, count: cart.countArray![index], total: cart.totalPriceArray![index])
            }
        }

    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
        let nextEntryIndex = stackView.arrangedSubviews.count - 1
        if nextEntryIndex == 0 {
//            print("카트가 비어있음")
        }else{
            for subview in stackView.subviews as [UIView]
            {
                if (subview.tag != 1) {
                    subview.isHidden = true
                    subview.removeFromSuperview()
                }
            }
        }
    }
//MARK:- 목록 추가
    func addEntry(menu : String?, count : Int?, total : Int?){
        // stack view에 있는 button을 가져옴
        guard let addButtonContainerView = stackView.arrangedSubviews.last else {
            fatalError("Expected at least one arranged view in the stack view")
        }
        
        // add button 한 칸 앞 index를 가져 온다
        let nextEntryIndex = stackView.arrangedSubviews.count - 1
//        print(nextEntryIndex)
        // scrollview의 스크롤이 이동할 위치계산 - 현 위치에서 add button의 높이 만큼 이동
        let offset = CGPoint(x: scrollView.contentOffset.x, y: scrollView.contentOffset.y + addButtonContainerView.bounds.size.height)

        // stackview를 만들어서 안 보이게 처리
        let newEntryView = createEntryView(menu: menu, count: count, total: total)
        newEntryView.isHidden = true
        
        // 만들어진 stack view를 add button앞에다가 추가
        stackView.insertArrangedSubview(newEntryView, at: nextEntryIndex)

        // 0.2초 동안 추가된 뷰가 보이게 하면서 scrollview의 스크롤 이동
        UIView.animate(withDuration: 0.2) {
            newEntryView.isHidden = false
            self.scrollView.contentOffset = offset

        }
    }

//MARK:- 목록에 들어갈 Cell(수평 스택뷰) 생성
    private func createEntryView(menu : String?, count : Int?, total : Int?) -> UIView {


        let name = menu! // 음료명
        let cnt = "수량: \(String(count!))" // 수량
        let price = "\(String(total!)) 원" // 음료 총 가격
        
        // 스택뷰를 만들고 속성 설정
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = 8

        let nameLabel = UILabel()
        nameLabel.text = name
        nameLabel.font = UIFont.preferredFont(forTextStyle: .body)

        nameLabel.setContentHuggingPriority(UILayoutPriority.defaultLow - 5.0, for: .horizontal)
        nameLabel.setContentCompressionResistancePriority(UILayoutPriority.defaultHigh - 5.0, for: .horizontal)

        let cntLabel = UILabel()
        cntLabel.text = cnt
        cntLabel.font = UIFont.preferredFont(forTextStyle: .body)

        let priceLabel = UILabel()
        priceLabel.text = price
        priceLabel.font = UIFont.preferredFont(forTextStyle: .body)

        //수정 버튼
        let modifyButton = UIButton(type: .roundedRect)
        modifyButton.frame.size = CGSize(width: 100.0, height: 20.0)
        modifyButton.setTitle("수정", for: .normal)
        modifyButton.setTitleColor(UIColor(red: 3/255, green: 102/255, blue: 53/255, alpha: 1), for: .normal)
        modifyButton.backgroundColor = .white
        modifyButton.layer.borderColor = UIColor(red:3/255, green:102/255, blue:53/255, alpha: 1).cgColor
        modifyButton.layer.borderWidth = 1.0
        modifyButton.layer.cornerRadius = 10
        
        // 수정버튼 클릭 시 modifyStackView() 호출
        modifyButton.addTarget(self, action: #selector(modifyStackView(sender:)), for: .touchUpInside)
        
        // 삭제버튼
        let deleteButton = UIButton(type: .roundedRect)

        deleteButton.setTitle(" 삭제 ", for: .normal)
        deleteButton.setTitleColor(.white, for: .normal)
        deleteButton.backgroundColor = UIColor(red: 3/255, green: 102/255, blue: 53/255, alpha: 1)
        deleteButton.layer.borderColor = UIColor(red:3/255, green:102/255, blue:53/255, alpha: 1).cgColor
        deleteButton.layer.borderWidth = 1.0
        deleteButton.layer.cornerRadius = 10
        
        // 삭제버튼 클릭 시 deleteStackView() 호출
        deleteButton.addTarget(self, action: #selector(deleteStackView(sender:)), for: .touchUpInside)
        
        //stack 뷰에 차례대로 쌓는다.
        stack.addArrangedSubview(nameLabel)
        stack.addArrangedSubview(cntLabel)
        stack.addArrangedSubview(priceLabel)
        stack.addArrangedSubview(modifyButton)
        stack.addArrangedSubview(deleteButton)

        return stack

    }
    
    @objc func deleteStackView(sender: UIButton) {

        // 클릭 했을 때 버튼의 슈퍼뷰, 즉 버튼이 속해있는 stack view를 가지고 온다
        guard let entryView = sender.superview else { return }

        // view 계층구조에서 제거하면 stackviewe에 arragedSubview에서도 자동적으로 제거됨
        let superview = entryView.superview
        let cart = CART.shared
        
        var index = -1
        for product in superview!.subviews{
            if entryView === product as? UIStackView {
                break
            }
            index += 1
        }

        // cart 객체에서도 삭제 !!
        cart.countArray?.remove(at: index)
        cart.menuArray.remove(at: index)
        cart.totalPriceArray?.remove(at: index)
        
        // 0.25동안 그 스택뷰를 안 보이게 하고 완료하면 view 계층구조에서 제거한다
        // view 계층구조에서 제거하면 장바구니에서도 자동적으로 제거됨
        UIView.animate(withDuration: 0.25, animations: {
            entryView.isHidden = true
        }, completion: { _ in
            entryView.removeFromSuperview()
        })
        
        

    }
    
    @objc func modifyStackView(sender: UIButton) {

        // 클릭 했을 때 버튼의 슈퍼뷰, 즉 버튼이 속해있는 stack view를 가지고 온다
        guard let entryView = sender.superview else { return }
        let superview = entryView.superview

        var index = -1
        for product in superview!.subviews{
            if entryView === product as? UIStackView {
                break
            }
            index += 1
        }
        
        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
        detailVC.modifiedModel = index
        detailVC.thisismodify = true // 수정 flag
        self.navigationController!.pushViewController(detailVC, animated: true)

    }
    
//MARK:- 결제
    
    @IBAction func clickToBuy(_ sender: Any) {
        let cart = CART.shared
        let info = userInfo.shared
        let alert = UIAlertController(title: "결제", message: "결제 하시겠습니까?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "취소", style: .default) { action in
            print("취소")
        })
        alert.addAction(UIAlertAction(title: "확인", style: .default) { action in
            print("결제")
            cart.menuArray.removeAll()
            cart.countArray?.removeAll()
            cart.totalPriceArray?.removeAll()
            let alert = UIAlertController(title: "성공", message: "\(info.username)님, 결제되었습니다!", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                
            }
            alert.addAction(okAction)
            self.present(alert, animated: false, completion: nil)
        })
        self.present(alert, animated: true, completion: nil)
    }
    //MARK:- 새로운 menuModel 장바구니에 추가
    
    @IBAction func item1Clicked(_ sender: Any) {
        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
        detailVC.newModel = 0
        self.navigationController!.pushViewController(detailVC, animated: true)
    }
    
    @IBAction func item2Clicked(_ sender: Any) {
        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
        detailVC.newModel = 1
        self.navigationController!.pushViewController(detailVC, animated: true)
    }
    
    @IBAction func item3Clicked(_ sender: Any) {

        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
        detailVC.newModel = 2
        self.navigationController!.pushViewController(detailVC, animated: true)
    }
    
    @IBAction func item4Clicked(_ sender: Any) {

        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
        detailVC.newModel = 3
        self.navigationController!.pushViewController(detailVC, animated: true)
    }
    
    @IBAction func item5Clicked(_ sender: Any) {

        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
        detailVC.newModel = 4
        self.navigationController!.pushViewController(detailVC, animated: true)
    }
    
}

//
//  MySingleton.swift
//  StarbucksOrderApp
//
//  Created by 양유진 on 2021/09/14.
//

import Foundation

class CART {
    static let shared = CART()
    var menuArray: [String] = []
    var countArray: [Int]? = []
    var totalPriceArray: [Int]? = []
}

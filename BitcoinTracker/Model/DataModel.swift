//
//  DataModel.swift
//  BitcoinTracker
//
//  Created by Ahmed ibrahim on 4/17/19.
//  Copyright © 2019 Ahmed ibrahim. All rights reserved.
//

import Foundation

class DataModel {
    
    init() {
    }
    
    private var bitcoinPrice: Double = 0.00
    
    //setter
    func setBitcoinPrice(price: Double){
        bitcoinPrice = price
    }
    
    //getter
    func getBitcoinPrice() -> Double{
        return bitcoinPrice

    }
}

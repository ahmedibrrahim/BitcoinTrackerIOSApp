//
//  ViewController.swift
//  BitcoinTracker
//
//  Created by Ahmed ibrahim on 4/14/19.
//  Copyright © 2019 Ahmed ibrahim. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {


    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var priceLabel: UILabel!
    
    //declare an empty array to hold the view picker data.
    var pickerData: [String] = [String]()
    
    let APIURL = "https://api.coindesk.com/v1/bpi/currentprice/"
    let dataModel = DataModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        picker.delegate = self
        picker.dataSource = self
        pickerData = ["USD", "EUR", "EGP"]
    }
    
    
    //sending an Alamofire request to the API URL, to get the API response.
    func getBitcoinPrice(URL: String, currency: String){
        Alamofire.request(URL + currency + ".json", method: .get).responseJSON{
            response in
            
            response.result.ifSuccess {
                print("success")
                let data = JSON(response.result.value!)
                
                //calling the updateDataModel func to update the model values.
                self.updateDataModel(json: data, currency: currency)
            }
            response.result.ifFailure {
                print("sending request failed!")
            }
        }
    }
    
    
    //updating the data model values.
    func updateDataModel(json: JSON, currency: String){
        //updating the data model.
        if let price = json["bpi"][currency]["rate_float"].double{
        dataModel.setBitcoinPrice(price: price)
        updateTheUI()
        }
    }
    
    
    func updateTheUI(){
        priceLabel.text = String(dataModel.getBitcoinPrice())
    }
    

 //initializing the picker view
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    //getting the the selected row value in the picker view.
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //print(pickerData[row])
        getBitcoinPrice(URL: APIURL, currency: pickerData[row])
    }
    
    //changing the row elements color to orange.
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = pickerData[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSAttributedString.Key.foregroundColor: UIColor.orange])
        return myTitle
    }
 //END of initializing the picker view
    
    
    
}


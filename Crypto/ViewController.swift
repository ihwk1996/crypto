//
//  ViewController.swift
//  Crypto
//
//  Created by Ivan on 15/2/18.
//  Copyright © 2018 Ivan. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class ViewController: UIViewController {
    let firstURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTCUSD"
    let secondURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/ETHUSD"
    let thirdURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/LTCUSD"
    let fourthURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/XMRUSD"
    
    var priceJSON1: JSON?
    var priceJSON2: JSON?
    var priceJSON3: JSON?
    var priceJSON4: JSON?
    
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var priceLabel1: UILabel!
    @IBOutlet weak var priceLabel2: UILabel!
    @IBOutlet weak var priceLabel3: UILabel!
    @IBOutlet weak var priceLabel4: UILabel!
    @IBOutlet weak var changeLabel1: UILabel!
    @IBOutlet weak var changeLabel2: UILabel!
    @IBOutlet weak var changeLabel3: UILabel!
    @IBOutlet weak var changeLabel4: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPriceData1(url: firstURL)
        getPriceData2(url: secondURL)
        getPriceData3(url: thirdURL)
        getPriceData4(url: fourthURL)
        //getPriceData(url: theURL)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func getButton(_ sender: UIButton) {
        getPriceData1(url: firstURL)
        getPriceData2(url: secondURL)
        getPriceData3(url: thirdURL)
        getPriceData4(url: fourthURL)
    }
    
    func getPriceData1(url: String) {
        
        Alamofire.request(url).responseJSON { response in
            if response.result.isSuccess {
                print("Success got data")
                self.priceJSON1 = JSON(response.result.value!)
                print(self.priceJSON1!)
                self.updatePriceData1(json: self.priceJSON1!)
            } else {
                print("error")
            }
        }
        
    }
    
    func getPriceData2(url: String) {
        
        Alamofire.request(url).responseJSON { response in
            if response.result.isSuccess {
                print("Success got data")
                self.priceJSON2 = JSON(response.result.value!)
                print(self.priceJSON2!)
                self.updatePriceData2(json: self.priceJSON2!)
            } else {
                print("error")
            }
        }
        
    }
    func getPriceData3(url: String) {
        
        Alamofire.request(url).responseJSON { response in
            if response.result.isSuccess {
                print("Success got data")
                self.priceJSON3 = JSON(response.result.value!)
                print(self.priceJSON3!)
                self.updatePriceData3(json: self.priceJSON3!)
            } else {
                print("error")
            }
        }
        
    }
    func getPriceData4(url: String) {
        
        Alamofire.request(url).responseJSON { response in
            if response.result.isSuccess {
                print("Success got data")
                self.priceJSON4 = JSON(response.result.value!)
                print(self.priceJSON4!)
                self.updatePriceData4(json: self.priceJSON4!)
            } else {
                print("error")
            }
        }
        
    }
    
    func updatePriceData1(json: JSON) {
        if var price = json["ask"].double {
            price = (round(price*10)) / 10.0;
            priceLabel1.text = "$\(price)"
        }
        if var change = json["changes"]["percent"]["day"].double {
            change = (round(change*100)) / 100.0;
            if change < 0 {
                change = abs(change)
                changeLabel1.textColor = hexStringToUIColor(hex: "f22613")
                changeLabel1.text = "▼\(change)%"
            } else {
                changeLabel1.textColor = hexStringToUIColor(hex: "00e640")
                changeLabel1.text = "▲\(change)%"
            }
            
        }
    }
    
    func updatePriceData2(json: JSON) {
        if var price = json["ask"].double {
            price = (round(price*100)) / 100.0;
            priceLabel2.text = "$\(price)"
        }
        if var change = json["changes"]["percent"]["day"].double {
            change = (round(change*100)) / 100.0;
            if change < 0 {
                change = abs(change)
                changeLabel2.textColor = hexStringToUIColor(hex: "f22613")
                changeLabel2.text = "▼\(change)%"
            } else {
                changeLabel2.textColor = hexStringToUIColor(hex: "00e640")
                changeLabel2.text = "▲\(change)%"
            }
        }
    }
    
    func updatePriceData3(json: JSON) {
        if var price = json["ask"].double {
            price = (round(price*100)) / 100.0;
            priceLabel3.text = "$\(price)"
        }
        if var change = json["changes"]["percent"]["day"].double {
            change = (round(change*100)) / 100.0;
            if change < 0 {
                change = abs(change)
                changeLabel3.textColor = hexStringToUIColor(hex: "f22613")
                changeLabel3.text = "▼\(change)%"
            } else {
                changeLabel3.textColor = hexStringToUIColor(hex: "00e640")
                changeLabel3.text = "▲\(change)%"
            }
        }
    }
    func updatePriceData4(json: JSON) {
        if var price = json["ask"].double {
            price = (round(price*100)) / 100.0;
            priceLabel4.text = "$\(price)"
        }
        if var change = json["changes"]["percent"]["day"].double {
            change = (round(change*100)) / 100.0;
            if change < 0 {
                change = abs(change)
                changeLabel4.textColor = hexStringToUIColor(hex: "f22613")
                changeLabel4.text = "▼\(change)%"
            } else {
                changeLabel4.textColor = hexStringToUIColor(hex: "00e640")
                changeLabel4.text = "▲\(change)%"
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose crypto" {
            let mvc = segue.destination as! ViewController1
            if (sender as? UIButton)?.currentTitle == "B1" {
                mvc.json = self.priceJSON1!
                mvc.name = "Bitcoin"
                mvc.img = #imageLiteral(resourceName: "B")
                mvc.bgColor = hexStringToUIColor(hex: "1e8bc3")
                
            }
            if (sender as? UIButton)?.currentTitle == "B2" {
                mvc.json = self.priceJSON2!
                mvc.name = "Ether"
                mvc.img = #imageLiteral(resourceName: "E")
                mvc.bgColor = hexStringToUIColor(hex: "3a539b")
            }
            if (sender as? UIButton)?.currentTitle == "B3" {
                mvc.json = self.priceJSON3!
                mvc.name = "Litecoin"
                mvc.img = #imageLiteral(resourceName: "L")
                mvc.bgColor = hexStringToUIColor(hex: "1f3a93")
            }
            if (sender as? UIButton)?.currentTitle == "B4" {
                mvc.json = self.priceJSON4!
                mvc.name = "Monero"
                mvc.img = #imageLiteral(resourceName: "M")
                mvc.bgColor = hexStringToUIColor(hex: "2574a9")
            }
        }
    }
    
    // HEX TO COLOR
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

}


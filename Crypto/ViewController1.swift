//
//  ViewController1.swift
//  Crypto
//
//  Created by Ivan on 19/2/18.
//  Copyright © 2018 Ivan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController1: UIViewController {
    
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var imageLabel: UIImageView!
    @IBOutlet weak var changeLabel: UILabel!
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var label5: UILabel!
    @IBOutlet weak var label6: UILabel!
    
    var json: JSON?
    var name: String?
    var img: UIImage?
    var bgColor: UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getData() {
        
        nameLabel.text = name
        imageLabel.image = img
        background.backgroundColor = bgColor
        
        if var price = json!["ask"].double {
            price = (round(price*100)) / 100.0;
            priceLabel.text = "\(price)"
        }
        if var price = json!["changes"]["percent"]["day"].double {
            price = (round(price*100)) / 100.0;
            if price < 0 {
                changeLabel.textColor = hexStringToUIColor(hex: "f22613")
                price = abs(price)
                changeLabel.text = "▼\(price)%"
            } else {
                changeLabel.textColor = hexStringToUIColor(hex: "00e640")
                changeLabel.text = "▲\(price)%"
            }

        }
        if var price = json!["open"]["day"].double {
            price = (round(price*100)) / 100.0;
            label1.text = "$\(price)"
        }
        if var price = json!["high"].double {
            price = (round(price*100)) / 100.0;
            label2.text = "$\(price)"
        }
        if var price = json!["low"].double {
            price = (round(price*100)) / 100.0;
            label3.text = "$\(price)"
        }
        if var price = json!["changes"]["price"]["day"].double {
            price = (round(price*100)) / 100.0;
            if price < 0 {
                price = abs(price)
                label4.text = "-$\(price)"
            } else {
                label4.text = "+$\(price)"
            }
        }
        if var price = json!["averages"]["day"].double {
            price = (round(price*100)) / 100.0;
            label5.text = "$\(price)"
        }
        if var price = json!["averages"]["week"].double {
            price = (round(price*100)) / 100.0;
            label6.text = "$\(price)"
        }
    }
    /*OTHERSSS
    func getPriceData1(url: String) {
        
        Alamofire.request(url).responseJSON { response in
            if response.result.isSuccess {
                print("Success got data")
                let priceJSON = JSON(response.result.value!)
                print(priceJSON)
                self.updatePriceData1(json: priceJSON)
            } else {
                print("error")
            }
        }
        
    }
    
    func updatePriceData1(json: JSON) {
        if var price = json["ask"].double {
            price = (round(price*10)) / 10.0;
            priceLabel.text = "$\(price)"
        }
    }*/
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

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

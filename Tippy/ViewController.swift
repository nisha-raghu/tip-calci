//
//  ViewController.swift
//  Tippy
//
//  Created by Nisha on 3/3/17.
//  Copyright © 2017 Nisha. All rights reserved.
//

import UIKit
//import SettingsViewController

class ViewController: UIViewController {

    var dateFormatString = "yyyy-MM-dd HH:mm:ss"
    let dateHelper = DateFormatter()
    var duration:Int = 10
    var bill: Double = 0.0
    let numberFormatter = NumberFormatter()
    let defaults = UserDefaults.standard
    @IBOutlet var firstView: UIView!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billfield: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.firstView.alpha = 0
        UIView.animate(withDuration: 3, animations: {
            self.firstView.alpha = 1
            //When user opens app, keyboard becomes activated
            self.billfield.becomeFirstResponder()
            self.restore()
        })
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool){
        
        let defaults = UserDefaults.standard
        let percentSetting = defaults.integer(forKey: "tip_percent")
        
        tipControl.selectedSegmentIndex = percentSetting
        self.calcTip(self)
    }
        
    @IBAction func calcTip(_ sender: AnyObject) {
    
        numberFormatter.numberStyle = .currency  //gives comma separator for the currency
        numberFormatter.locale = NSLocale.current
        

        let tipPercentages = [0.18,0.2,0.25]
        bill=Double(billfield.text!) ?? 0
        let tip=bill*tipPercentages[tipControl.selectedSegmentIndex]
        let total=bill + tip
        
        tipLabel.text=String(format: "$%.2f",tip)
        totalLabel.text = numberFormatter.string(from:
        NSNumber.init( value: Double(String(Double(total)))!))
    }

    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        let defaults = UserDefaults.standard
        defaults.set(Int(tipControl.selectedSegmentIndex),forKey: "tip_percent")
        defaults.synchronize()
        storeValues()

    }
    
    func storeValues(){
        defaults.set(Double(bill),forKey: "bill")
        dateHelper.dateFormat = dateFormatString
        let futureDate = Date(timeInterval: TimeInterval(600), since: Date())
        defaults.set(String(dateHelper.string(from: futureDate)), forKey: "duration")
        defaults.synchronize()
    }
    
    //helps in restoring user values < 10 mins
    func restore(){
        dateHelper.dateFormat = dateFormatString
        
        let duration = defaults.string(forKey: "duration")
        if duration == nil{return}
        let futureDate =  dateHelper.date(from:duration!)!
        if Date() < futureDate {
            billfield.text = String(defaults.double(forKey: "bill"))
        }
    }
}


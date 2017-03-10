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

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billfield: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
        let tipPercentages = [0.18,0.2,0.25]
        let bill=Double(billfield.text!) ?? 0
        let tip=bill*tipPercentages[tipControl.selectedSegmentIndex]
        let total=bill + tip
        
        tipLabel.text=String(format: "$%.2f",tip)
        totalLabel.text=String(format: "$%.2f",total)
    }

    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        let defaults = UserDefaults.standard
    defaults.set(Int(tipControl.selectedSegmentIndex),forKey: "tip_percent")
        defaults.synchronize()

    }

}


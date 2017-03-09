//
//  SettingsViewController.swift
//  Tippy
//
//  Created by Student on 3/4/17.
//  Copyright © 2017 Student. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var tipPercent: UISegmentedControl!

    //@IBOutlet weak var tipPercentControl: UISegmentedControl!
    
    @IBAction func changeDefaultPercent(_ sender: Any) {
        print("Change 1")
        let defaults = UserDefaults.standard
        let index = tipPercent.selectedSegmentIndex
        defaults.set(Int(index),forKey: "tip_percent")
        defaults.synchronize()

        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        _=defaults.integer(forKey: "tip_percent")
        tipPercent.selectedSegmentIndex = defaults.integer(forKey: "tip_percent")
        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

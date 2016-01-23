//
//  GameNumberViewController.swift
//  Lazar
//
//  Created by Gurnoor Singh on 1/23/16.
//  Copyright © 2016 Cyberician. All rights reserved.
//

import UIKit

class GameNumberViewController: UIViewController {

    @IBOutlet var submit: UIButton!
    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
            if (segue.identifier == "segueTest") {
                let svc = segue.destinationViewController as! ViewController;
                
                svc.toPass = textField.text
                
            }
    }


}

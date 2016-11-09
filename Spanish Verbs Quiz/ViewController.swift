//
//  ViewController.swift
//  Spanish Verbs Quiz
//
//  Created by Normand Martin on 16-06-19.
//  Copyright © 2016 Normand Martin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var arrayVerbe: NSArray = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let plistPath = Bundle.main.path(forResource: "arr5", ofType: "plist"),
            let verbArray = NSArray(contentsOfFile: plistPath){
            arrayVerbe = verbArray
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "transmitArrayAgain"{
            let controller = segue.destination as! quizTableViewController
            controller.arrayVerbe = arrayVerbe
        }
        if segue.identifier == "transmitArray"{
            let controller = segue.destination as! verbListViewController
            controller.arrayVerbe = arrayVerbe
        }
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
    }

}


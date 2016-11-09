//
//  tiempoModalViewController.swift
//  Spanish Verbs Quiz
//
//  Created by Normand Martin on 16-07-09.
//  Copyright © 2016 Normand Martin. All rights reserved.
//

import UIKit

class tiempoModalViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func `return`(_ sender: UIBarButtonItem) {
        self.dismiss(animated: false, completion: nil)
    }



}

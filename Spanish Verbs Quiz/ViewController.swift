//
//  ViewController.swift
//  Spanish Verbs Quiz
//
//  Created by Normand Martin on 16-06-19.
//  Copyright © 2016 Normand Martin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var nombre: Int = 0
    var randomVerb: Int = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let plistPath = NSBundle.mainBundle().pathForResource("Conjug", ofType: "plist"),
            verbArray = NSArray(contentsOfFile: plistPath){
            nombre = verbArray.count
            aleatoire(nombre)
            let allVerbs = VerbeEspagnol(verbArray: verbArray, n: randomVerb )
            let testYo = allVerbs.verbo
            print(testYo)

        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func aleatoire(nombre: Int) -> Int {
        randomVerb = Int(arc4random_uniform(UInt32(nombre)))
        return randomVerb
    }


}


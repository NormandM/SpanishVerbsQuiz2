//
//  DataStructure.swift
//  Spanish Verbs Quiz
//
//  Created by Normand Martin on 16-06-20.
//  Copyright © 2016 Normand Martin. All rights reserved.
//

import Foundation
struct VerbeEspagnol{
    let verbo: String
    let modo: String
    let tiempo: String
    let yo: String
    let tu: String
    let el: String
    let nosotros: String
    let vosotros: String
    let ellos: String
    var verbeChoisi = NSArray()
    let n: Int
    init(verbArray: NSArray, n: Int){
        self.n = n
        verbeChoisi = verbArray[n] as! NSArray
        verbo = verbeChoisi[1] as! String
        modo = verbeChoisi[2] as! String
        tiempo = verbeChoisi[3] as! String
        yo = verbeChoisi[4] as! String
        tu = verbeChoisi[5] as! String
        el = verbeChoisi[6] as! String
        nosotros = verbeChoisi[7] as! String
        vosotros = verbeChoisi[8] as! String
        ellos = verbeChoisi[9] as! String
        
    }
    
}



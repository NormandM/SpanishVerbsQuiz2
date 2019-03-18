//
//  ChoixDu Pronom.swift
//  Spanish Verbs Quiz
//
//  Created by Normand Martin on 2019-02-25.
//  Copyright © 2019 Normand Martin. All rights reserved.
//

import Foundation
struct ChoixDuPronom {
    let mode: String
    let temps: String
    let infinitif: String
    let conjugatedVerb: String
    let personne: String
    let pronom: String
    
    init(mode: String, temps: String, infinitif: String, personne: String, conjugatedVerb: String) {
        self.mode = mode
        self.temps = temps
        self.infinitif = infinitif
        self.personne = personne
        self.conjugatedVerb = conjugatedVerb
        var pronomTrans = String()
        switch personne {
        case "1":
            if mode == "Subjuntivo"{
                pronomTrans = "que yo"
            }else if mode == "Imperativo"{
                pronomTrans = ""
            }else {pronomTrans = "yo"}
        case "2":
            if mode == "Subjuntivo"{
                pronomTrans = "que tu"
            }else if mode == "Imperativo"  && temps == "Positivo"{
                pronomTrans = "(tu)"
            }else if mode == "Imperativo" && temps == "Negativo"{
                pronomTrans = "(tu) no"
            }else{
                pronomTrans = "tu"
            }
        case "3":
            if mode == "Subjuntivo"{
                pronomTrans = "que Ud/el"
            }else if mode == "Imperativo"  && temps == "Positivo"{
                pronomTrans = "((Ud))"
            }else if mode == "Imperativo" && temps == "Negativo"{
                pronomTrans = "(Ud) no"
            }else{
                pronomTrans = "Ud/el"
            }
        case "4":
            if mode == "Subjuntivo"{
                pronomTrans = "que nosotros"
            }else if mode == "Imperativo"  && temps == "Positivo"{
                pronomTrans = "(nosotros)"
            }else if mode == "Imperativo" && temps == "Negativo"{
                pronomTrans = "(nosotros) no"
            }else{
                pronomTrans = "nosotros"
            }
        case "5":
            if mode == "Subjuntivo"{
                pronomTrans = "que vosotros"
            }else if mode == "Imperativo"  && temps == "Positivo"{
                pronomTrans = "(vosotros)"
            }else if mode == "Imperativo" && temps == "Negativo"{
                pronomTrans = "(vosotros) no"
            }else{
                pronomTrans = "vosotros"
            }
        case "6":
            if mode == "Subjuntivo"{
                pronomTrans = "que Uds/ellos"
            }else if mode == "Imperativo"  && temps == "Positivo"{
                pronomTrans = "(Uds)"
            }else if mode == "Imperativo" && temps == "Negativo"{
                pronomTrans = "(Uds) no"
            }else{
                pronomTrans = "Uds/ellos"
            }
            
        default:
            break
        }
        pronom = pronomTrans
    }
}

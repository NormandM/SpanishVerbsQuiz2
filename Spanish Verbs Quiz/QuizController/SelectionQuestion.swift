//
//  SelectionQuestion.swift
//  French Verbs Quiz
//
//  Created by Normand Martin on 17-09-19.
//  Copyright © 2017 Normand Martin. All rights reserved.
//

import Foundation
class Selection {
    var noDeverbe = 0
    var indexDesVerbes: [Int] = []
    var isSecondSubjontivo: Bool = false
    var infinitifVerb: Int = 0
    var listeVerbe: [String] = []
    var verbeChoisi: String = ""
    var tempsChoisi: String = ""
    var modeChoisi: String = ""
    var noPersonne: Int = 0
    var noItem: Int = 0
    var choixPersonne: String = ""
    var reponseBonne: String = ""
    var reponseBonneSubj2: String = ""
    var verbeFinal: String = ""
    var modeFinal: String = ""
    var tempsFinal: String = ""
    var tempsEtMode: [[String]] = []
    var allInfoList: [[String]] = []

// verbes spécifiés
    func questionSpecifique(arraySelection: [String], arrayVerbe: [[String]], verbeInfinitif: [String]) -> ([[String]],[Int], [[String]]){
        // Selecting verb tense
        tempsEtMode = choixTempsEtMode(arraySelection: arraySelection)
        listeVerbe = verbeInfinitif
        if allInfoList.count == 0 {
        for arrayVerbes in arrayVerbe {
            if listeVerbe.contains(arrayVerbes[2]){
                for tempsEtModes in tempsEtMode {
                    if tempsEtModes.contains(arrayVerbes[0]) && tempsEtModes.contains(arrayVerbes[1]){
                        if arrayVerbes[3] != "" {allInfoList.append([arrayVerbes[0], arrayVerbes[1], arrayVerbes[2], arrayVerbes[3], "1"])}
                        if arrayVerbes[4] != "" {allInfoList.append([arrayVerbes[0], arrayVerbes[1], arrayVerbes[2], arrayVerbes[4], "2"])}
                        if arrayVerbes[5] != "" {allInfoList.append([arrayVerbes[0], arrayVerbes[1], arrayVerbes[2], arrayVerbes[5], "3"])}
                        if arrayVerbes[6] != "" {allInfoList.append([arrayVerbes[0], arrayVerbes[1], arrayVerbes[2], arrayVerbes[6], "4"])}
                        if arrayVerbes[7] != "" {allInfoList.append([arrayVerbes[0], arrayVerbes[1], arrayVerbes[2], arrayVerbes[7], "5"])}
                        if arrayVerbes[8] != "" {allInfoList.append([arrayVerbes[0], arrayVerbes[1], arrayVerbes[2], arrayVerbes[8], "6"])}
                    }
                }
            }
        }
            
            var n = 0
            var i = 0
            for list in allInfoList{
                if list[0] == "Subjuntivo" && (list[1] == "Imperfecto" || list[1] == "Pluscuamperfecto")  {
                    i = i + 1
                    allInfoList[n].append(String(i))
                }else{
                    allInfoList[n].append("")
                }
                n = n + 1
                if i == 12 {i = 0}
            }
        let randomNumber = RandomNumber()
        noDeverbe = allInfoList.count
        indexDesVerbes = randomNumber.generate(from: 0, to: noDeverbe - 1, quantity: nil)
        }
        return (allInfoList, indexDesVerbes, tempsEtMode)
    }
    
    
/////////Tous les verbes
    func questionAleatoire(arraySelection: [String], arrayVerbe: [[String]]) -> ([Any], [[String]], Bool, String){
            listeVerbe = []
            infinitifVerb = 0
            var tempsEtModeChoisi: [Any] = []
            tempsEtMode = choixTempsEtMode(arraySelection: arraySelection)
            let noTempsChoisi = tempsEtMode.count
            let indexTempsChoisi = Int(arc4random_uniform(UInt32(noTempsChoisi)))
            tempsChoisi = tempsEtMode[indexTempsChoisi][0]
            modeChoisi = tempsEtMode[indexTempsChoisi][1]
            
            let i = arrayVerbe.count
            while infinitifVerb < i {
                let allVerbs = VerbeItalien(verbArray: arrayVerbe, n: infinitifVerb)
                if modeChoisi == "Imperativo" && (allVerbs.verbe == "nevar" || allVerbs.verbe == "dovere"){
                    // not appending
                }else{
                    listeVerbe.append(allVerbs.verbe)
                }
                infinitifVerb = infinitifVerb + 21
            }
            let noDeverbe = listeVerbe.count
            let indexVerbeChoisi = Int(arc4random_uniform(UInt32(noDeverbe)))
            verbeChoisi = listeVerbe[indexVerbeChoisi]
            var n = 0
            
            //Selecting person for question
            for verb in arrayVerbe {
                if verb[0] == modeChoisi && verb[1] == tempsChoisi && verb[2] == verbeChoisi{
                    noItem = n
                    break
                }
                n = n + 1
            }
            var noPossiblePersonne = 0
            if modeChoisi == "Imperativo"{
                noPossiblePersonne = 5
            }else{
                noPossiblePersonne = 6
            }
            noPersonne = Int(arc4random_uniform(UInt32(noPossiblePersonne))) + 1
            if modeChoisi == "Imperativo"{
                if noPersonne == 1 {
                    noPersonne = 2
                }else if noPersonne == 2 {
                    noPersonne = 3
                }else if noPersonne == 3 {
                    noPersonne = 4
                }else if noPersonne == 4 {
                    noPersonne = 5
                }else if noPersonne == 5 {
                    noPersonne = 6
                }
                
                
            }
            let question = Question()
        
            let verbeFrancais = VerbeItalien(verbArray: arrayVerbe, n: noItem)
            let verbFrançaisSubj2 = VerbeItalien(verbArray: arrayVerbe, n: noItem + 1)
            let personneVerbe = Personne(verbArray: verbeFrancais)
            let verbeConjugue = question.finaleAleatoire(noPersonne: noPersonne, verbeFrancais: verbeFrancais, verbFrançaisSubj2: verbFrançaisSubj2, personneVerbe: personneVerbe)

            verbeFinal = verbeFrancais.verbe
            modeFinal = verbeFrancais.mode
            tempsFinal = verbeFrancais.temps
            choixPersonne = verbeConjugue[0]
            let personneChoisi = verbeConjugue[1]
            reponseBonne = verbeConjugue[2]
            if modeFinal == "Subjuntivo" && (tempsFinal == "Imperfecto" || tempsFinal == "Pluscuamperfecto")  {
                isSecondSubjontivo = true
                reponseBonneSubj2 = verbeConjugue[3]
            }else{
                isSecondSubjontivo = false
            }
        
            let helper = Helper()
        tempsEtModeChoisi = [helper.capitalize(word: verbeFinal), helper.capitalize(word: modeFinal), helper.capitalize(word: tempsFinal), choixPersonne, personneChoisi, reponseBonne]
        return (tempsEtModeChoisi, tempsEtMode, isSecondSubjontivo, reponseBonneSubj2)
    }
    func choixTempsEtMode(arraySelection: [String]) -> [[String]]{
        for arraySelections in arraySelection{
            var n = 0
            tempsChoisi  = arraySelections
            while tempsChoisi.last == " "{
                tempsChoisi = String(tempsChoisi.dropLast(1))
                n = n + 1
            }
            switch n {
            case 0: modeChoisi = "Indicativo"
            case 1: modeChoisi = "Subjuntivo"
            case 2: modeChoisi = "Condicional"
            case 3: modeChoisi = "Imperativo"
            default: modeChoisi = ""
            }
            tempsEtMode.append([tempsChoisi, modeChoisi])
            
        }
        return tempsEtMode
    }
}

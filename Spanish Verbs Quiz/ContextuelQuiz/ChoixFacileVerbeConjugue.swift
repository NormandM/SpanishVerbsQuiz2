//
//  ChoixFacileVerbeConjugue.swift
//  French Verbs Quiz
//
//  Created by Normand Martin on 2018-11-28.
//  Copyright © 2018 Normand Martin. All rights reserved.
//

import UIKit
class ChoixFacileVerbeConjugue {
    class func verbeConjugue(arrayVerbe: [[String]], infinitif: String, tempsDuVerbe: String, modeDuverbe: String, verbHintButton: [UIButton], hintMenuAction: () -> Void, reponseBonne: String) {
        var verbeChoisiEtConjugue = [String]()
        var auxiliereArray = [String]()
        var infinitifMutate = infinitif.lowercased()
        var isNotPassiveVerb = Bool()
        for verb in arrayVerbe{
            if verb.contains(infinitifMutate)  && verb.contains(tempsDuVerbe)  && verb.contains(modeDuverbe.capitalizingFirstLetter()) {
                verbeChoisiEtConjugue.append(verb[3])
                verbeChoisiEtConjugue.append(verb[4])
                verbeChoisiEtConjugue.append(verb[5])
                verbeChoisiEtConjugue.append(verb[6])
                verbeChoisiEtConjugue.append(verb[7])
                verbeChoisiEtConjugue.append(verb[8])
                break
            }
        }
        if verbeChoisiEtConjugue == [] {
            infinitifMutate = infinitifMutate.removingReflexivePronomInfinitif()
        }
        var mutateReponseBonne = reponseBonne
        hintMenuAction()
        for verb in arrayVerbe{
            if verb.contains(infinitifMutate)  && verb.contains(tempsDuVerbe)  && verb.contains(modeDuverbe.capitalizingFirstLetter()) &&  verbeChoisiEtConjugue == []{
                verbeChoisiEtConjugue.append(verb[3])
                verbeChoisiEtConjugue.append(verb[4])
                verbeChoisiEtConjugue.append(verb[5])
                verbeChoisiEtConjugue.append(verb[6])
                verbeChoisiEtConjugue.append(verb[7])
                verbeChoisiEtConjugue.append(verb[8])
                break
            }
        }
        let auxiliere =  AuxiliereAvoirToEtre.auxiliereFromAvoirToEtre(reponseBonne: reponseBonne, verbeChoisiEtConjugue: verbeChoisiEtConjugue, mode: modeDuverbe, temps: tempsDuVerbe, infinitif: infinitif)
        verbeChoisiEtConjugue = auxiliere.0
        isNotPassiveVerb = auxiliere.1
        var participe = verbeChoisiEtConjugue[0].components(separatedBy: .whitespaces).last!
        for n in 0...5{
            auxiliereArray.append(verbeChoisiEtConjugue[n].components(separatedBy: .whitespaces).first!)
        }
        let terminaison = mutateReponseBonne.detectFeminin(participe: participe, isNotPassiveVerb: isNotPassiveVerb)
        let nbVerbe = verbeChoisiEtConjugue[0].components(separatedBy: .whitespaces)
        participe = String(participe.dropLast())
        if nbVerbe.count >= 2{
            verbeChoisiEtConjugue[0] = auxiliereArray[0] + " " + participe + terminaison.0
            verbeChoisiEtConjugue[1] = auxiliereArray[1] + " " +  participe + terminaison.1
            verbeChoisiEtConjugue[2] = auxiliereArray[2] + " " +  participe + terminaison.2
            verbeChoisiEtConjugue[3] = auxiliereArray[3] + " " +  participe + terminaison.3
            verbeChoisiEtConjugue[4] = auxiliereArray[4] + " " +  participe + terminaison.4
            verbeChoisiEtConjugue[5] = auxiliereArray[5] + " " +  participe + terminaison.5
        }
        if(infinitif.caseInsensitiveCompare(infinitifMutate) != .orderedSame){
            verbeChoisiEtConjugue[0] = "me \(verbeChoisiEtConjugue[0])"
            verbeChoisiEtConjugue[1] = "te \(verbeChoisiEtConjugue[1])"
            verbeChoisiEtConjugue[2] = "se \(verbeChoisiEtConjugue[2])"
            verbeChoisiEtConjugue[5] = "se \(verbeChoisiEtConjugue[5])"
            verbeChoisiEtConjugue[3] = "nos \(verbeChoisiEtConjugue[3])"
            verbeChoisiEtConjugue[4] = "os \(verbeChoisiEtConjugue[4])"
        }
        mutateReponseBonne = reponseBonne
        for n in 0...5{
            if verbeChoisiEtConjugue[n].components(separatedBy: .whitespaces).first! == mutateReponseBonne.components(separatedBy: .whitespaces).first! {
                verbeChoisiEtConjugue[n] = reponseBonne
                break
            }
        }
        verbeChoisiEtConjugue = verbeChoisiEtConjugue.filter {$0 != ""}
        verbeChoisiEtConjugue = Array(Set(verbeChoisiEtConjugue))
        let noItem = verbeChoisiEtConjugue.count
        switch noItem {
        case 1:
            verbHintButton[0].setTitle(verbeChoisiEtConjugue[0], for: .normal)
            verbHintButton[1].isHidden = true
            verbHintButton[2].isHidden = true
            verbHintButton[3].isHidden = true
            verbHintButton[4].isHidden = true
            verbHintButton[5].isHidden = true
        case 2:
            verbHintButton[0].setTitle(verbeChoisiEtConjugue[0], for: .normal)
            verbHintButton[1].setTitle(verbeChoisiEtConjugue[1], for: .normal)
            verbHintButton[2].isHidden = true
            verbHintButton[3].isHidden = true
            verbHintButton[4].isHidden = true
            verbHintButton[5].isHidden = true
            
        case 3:
            verbHintButton[0].setTitle(verbeChoisiEtConjugue[0], for: .normal)
            verbHintButton[1].setTitle(verbeChoisiEtConjugue[1], for: .normal)
            verbHintButton[2].setTitle(verbeChoisiEtConjugue[2], for: .normal)
            verbHintButton[3].isHidden = true
            verbHintButton[4].isHidden = true
            verbHintButton[5].isHidden = true
        case 4:
            verbHintButton[0].setTitle(verbeChoisiEtConjugue[0], for: .normal)
            verbHintButton[1].setTitle(verbeChoisiEtConjugue[1], for: .normal)
            verbHintButton[2].setTitle(verbeChoisiEtConjugue[2], for: .normal)
            verbHintButton[3].setTitle(verbeChoisiEtConjugue[3], for: .normal)
            verbHintButton[4].isHidden = true
            verbHintButton[5].isHidden = true

        case 5:
            verbHintButton[0].setTitle(verbeChoisiEtConjugue[0], for: .normal)
            verbHintButton[1].setTitle(verbeChoisiEtConjugue[1], for: .normal)
            verbHintButton[2].setTitle(verbeChoisiEtConjugue[2], for: .normal)
            verbHintButton[3].setTitle(verbeChoisiEtConjugue[3], for: .normal)
            verbHintButton[4].setTitle(verbeChoisiEtConjugue[4], for: .normal)
            verbHintButton[5].isHidden = true
        case 6:
            verbHintButton[0].setTitle(verbeChoisiEtConjugue[0], for: .normal)
            verbHintButton[1].setTitle(verbeChoisiEtConjugue[1], for: .normal)
            verbHintButton[2].setTitle(verbeChoisiEtConjugue[2], for: .normal)
            verbHintButton[3].setTitle(verbeChoisiEtConjugue[3], for: .normal)
            verbHintButton[4].setTitle(verbeChoisiEtConjugue[4], for: .normal)
            verbHintButton[5].setTitle(verbeChoisiEtConjugue[5], for: .normal)

        default:
            break
        }
    }

}
extension String {
    mutating func removingReflexivePronom() -> String{
        if  self.contains("'"){
            self  = String(self.dropFirst())
            self = String(self.dropFirst())
        }else{
            let arrayVerb = self.components(separatedBy: .whitespaces)
            if arrayVerb[0] == "me" || arrayVerb[0] == "te" || arrayVerb[0] == "se" || arrayVerb[0] == "nos" || arrayVerb[0] == "os"{
                if arrayVerb.count > 2 {
                    self = arrayVerb[1] + " " +  arrayVerb[2]
                }else{
                    self = arrayVerb[1]
                }
            }
        }
        return self
    }

    mutating func removingReflexivePronomInfinitif() -> String{
            while self.last != "r" {
                self.removeLast()
            }
        return self
    }
}
extension String {
    mutating func detectFeminin(participe: String, isNotPassiveVerb: Bool) -> (String, String, String, String, String, String){
        var verbeConjugue = ("", "", "", "", "", "")
        var verbArray = [String]()
        var arrayOfLastLetters = [Character]()
        var verbeMutated = String()
        verbArray = self.components(separatedBy: .whitespaces)
        verbeMutated = verbArray.last!
        if  verbArray.count >= 2 {
            let participeMutaded = participe.dropLast()
            while participeMutaded != verbeMutated{
                arrayOfLastLetters.append(verbeMutated.removeLast())
                _ = String(verbeMutated.dropLast())
            }
        }
        if arrayOfLastLetters.contains("a") || arrayOfLastLetters.contains("e"){
            verbeConjugue = ("a", "a", "a","e","e","e")
        }else  if arrayOfLastLetters.contains("i"){
            verbeConjugue = ("o", "o", "o","i","i","i")
        }else{
            verbeConjugue = ("o", "o", "o","o","o","o")
        }
        return verbeConjugue
    }
}

extension String {
    mutating func premiereLettreIsVoyelle() -> Bool {
        let firstLetter = self.removeFirst()
        var firstLetterIsVoyelle = Bool()
        if firstLetter == "i" || firstLetter == "a" || firstLetter == "e" || firstLetter == "i" || firstLetter == "o" || firstLetter == "u" || firstLetter == "y"{
            firstLetterIsVoyelle = true
        }
        return firstLetterIsVoyelle
    }
}

class AuxiliereAvoirToEtre {
    class func auxiliereFromAvoirToEtre(reponseBonne: String, verbeChoisiEtConjugue: [String], mode: String, temps: String, infinitif: String) -> ([String], Bool){
        var mutateReponseBonne = reponseBonne
        var verbeChoisi = [String]()
        var auxiliereEtre = [String]()
        var isNotPassiveVerb = Bool()
        mutateReponseBonne = mutateReponseBonne.removingReflexivePronom()
        let auxiliereReponseBonne = mutateReponseBonne.components(separatedBy: .whitespaces).first!
        let participe = verbeChoisiEtConjugue[0].components(separatedBy: .whitespaces).last!
        var infinitifSansPronom = infinitif
        infinitifSansPronom = infinitifSansPronom.removingReflexivePronomInfinitif()
        var verbeAComparerArray = verbeChoisiEtConjugue
        var otraForma = ""
        if mode.caseInsensitiveCompare("SUBJUNTIVO") == .orderedSame && temps.caseInsensitiveCompare("Imperfecto") == .orderedSame {
            otraForma = OtraFormaVerbSelector.otraForma(mode: mode, temp: temps, infinitif: infinitifSansPronom, verbeConjugue: auxiliereReponseBonne)
        }

        for n in 0...5 {
            var verbeAcomparer = verbeAComparerArray[n].removingReflexivePronom()
            verbeAcomparer = verbeAcomparer.components(separatedBy: .whitespaces).first!
            if (verbeAcomparer.caseInsensitiveCompare(auxiliereReponseBonne) == .orderedSame) || (verbeAcomparer.caseInsensitiveCompare(otraForma) == .orderedSame){
                isNotPassiveVerb = true
                break
            }
        }
        if isNotPassiveVerb == false {
            let dicAuxiliere = Auxiliere.getDict()
            for dic in dicAuxiliere{
                if dic.key == verbeChoisiEtConjugue[0].components(separatedBy: .whitespaces).first!{
                    auxiliereEtre = dic.value
                }
            }
            verbeChoisi.append(auxiliereEtre[0] + " " + participe)
            verbeChoisi.append(auxiliereEtre[1] + " " + participe)
            verbeChoisi.append(auxiliereEtre[2] + " " + participe)
            verbeChoisi.append(auxiliereEtre[3] + " " + participe)
            verbeChoisi.append(auxiliereEtre[4] + " " + participe)
            verbeChoisi.append(auxiliereEtre[5] + " " + participe)
        }else{
            verbeChoisi = verbeChoisiEtConjugue
        }
        return (verbeChoisi, isNotPassiveVerb)
    }
}

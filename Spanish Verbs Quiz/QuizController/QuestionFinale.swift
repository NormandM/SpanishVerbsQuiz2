//
//  QuestionFinale.swift
//  French Verbs Quiz
//
//  Created by Normand Martin on 17-09-19.
//  Copyright © 2017 Normand Martin. All rights reserved.
//

import Foundation
class Question {
    var choixPersonne: String = ""
    var personneChoisi: String = ""
    func finaleSpecifique (noPersonne: Int, personneVerbe: PersonneTrie) -> [String] {
        if noPersonne == 1{
            choixPersonne = "premier"
            personneChoisi = personneVerbe.first
        }else if noPersonne == 2 {
            choixPersonne = "deuxieme"
            personneChoisi = personneVerbe.second
        }else if noPersonne == 3 {
            choixPersonne = "troisieme"
            personneChoisi = personneVerbe.third
        }else if noPersonne == 4 {
            choixPersonne = "quatrieme"
            personneChoisi = personneVerbe.fourth
        }else if noPersonne == 5 {
            choixPersonne = "cinquieme"
            personneChoisi = personneVerbe.fifth
        }else if noPersonne == 6 {
            choixPersonne = "sixieme"
            personneChoisi = personneVerbe.sixth
        }
        return [choixPersonne, personneChoisi]
    }
// tous les verbes
    func finaleAleatoire(noPersonne:Int,verbeFrancais: VerbeItalien, verbFrançaisSubj2: VerbeItalien, personneVerbe: Personne) -> [String]{

        var reponseBonne: String = ""
        var reponseBonneSubj2: String = ""
        var personneChoisi: String = ""
        if noPersonne == 1{
            choixPersonne = "premier"
            personneChoisi = personneVerbe.first
            reponseBonne = verbeFrancais.premier
            reponseBonneSubj2 = verbFrançaisSubj2.premier
        }else if noPersonne == 2 {
            choixPersonne = "deuxieme"
            personneChoisi = personneVerbe.second
            reponseBonne = verbeFrancais.deuxieme
            reponseBonneSubj2 = verbFrançaisSubj2.deuxieme
        }else if noPersonne == 3 {
            choixPersonne = "troisieme"
            personneChoisi = personneVerbe.third
            reponseBonne = verbeFrancais.troisieme
            reponseBonneSubj2 = verbFrançaisSubj2.troisieme
        }else if noPersonne == 4 {
            choixPersonne = "quatrieme"
            personneChoisi = personneVerbe.fourth
            reponseBonne = verbeFrancais.quatrieme
            reponseBonneSubj2 = verbFrançaisSubj2.quatrieme
        }else if noPersonne == 5 {
            choixPersonne = "cinquieme"
            personneChoisi = personneVerbe.fifth
            reponseBonne = verbeFrancais.cinquieme
            reponseBonneSubj2 = verbFrançaisSubj2.cinquieme
        }else if noPersonne == 6 {
            choixPersonne = "sixieme"
            personneChoisi = personneVerbe.sixth
            reponseBonne = verbeFrancais.sixieme
            reponseBonneSubj2 = verbFrançaisSubj2.sixieme
        }
        return [choixPersonne, personneChoisi, reponseBonne, reponseBonneSubj2]
    }
    
}

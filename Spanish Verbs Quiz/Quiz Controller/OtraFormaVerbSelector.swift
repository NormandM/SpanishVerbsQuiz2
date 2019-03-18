//
//  OtraFormaVerbSelector.swift
//  Spanish Verbs Quiz
//
//  Created by Normand Martin on 2019-03-12.
//  Copyright © 2019 Normand Martin. All rights reserved.
//

import Foundation
struct OtraFormaVerbSelector{
    static func otraForma (mode: String, temp: String, infinitif: String, verbeConjugue: String) -> String{
        var verbConjugueOtraForma = String()
        let chosenVerb = ChosenVerb(infinitif: infinitif, mode: mode, temp: temp)
        let verb = chosenVerb.conjugatedVerb
        let verbOtraForma = chosenVerb.conjugateVerbOtraForma
        if verbeConjugue == verb.firstPersonVerb{
            verbConjugueOtraForma = verbOtraForma.firstPersonVerb
        }else if verbeConjugue == verbOtraForma.firstPersonVerb{
            verbConjugueOtraForma = verb.firstPersonVerb
        }
        if verbeConjugue == verb.secondPersonVerb{
            verbConjugueOtraForma = verbOtraForma.secondPersonVerb
        }else if verbeConjugue == verbOtraForma.secondPersonVerb{
            verbConjugueOtraForma = verb.secondPersonVerb
        }
        if verbeConjugue == verb.thirdPersonVerb{
            verbConjugueOtraForma = verbOtraForma.thirdPersonVerb
        }else if verbeConjugue == verbOtraForma.thirdPersonVerb{
            verbConjugueOtraForma = verb.thirdPersonVerb
        }
        if verbeConjugue == verb.fourthPersonVerb{
            verbConjugueOtraForma = verbOtraForma.fourthPersonVerb
        }else if verbeConjugue == verbOtraForma.fourthPersonVerb{
            verbConjugueOtraForma = verb.fourthPersonVerb
        }
        if verbeConjugue == verb.fifthPersonVerb{
            verbConjugueOtraForma = verbOtraForma.fifthPersonVerb
        }else if verbeConjugue == verbOtraForma.fifthPersonVerb{
            verbConjugueOtraForma = verb.fifthPersonVerb
        }
        if verbeConjugue == verb.sixthPersonVerb{
            verbConjugueOtraForma = verbOtraForma.sixthPersonVerb
        }else if verbeConjugue == verbOtraForma.sixthPersonVerb{
            verbConjugueOtraForma = verb.sixthPersonVerb
        }
        return verbConjugueOtraForma
    }
        
}

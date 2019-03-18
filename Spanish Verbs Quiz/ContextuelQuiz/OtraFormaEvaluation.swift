//
//  OtraFormaEvaluation.swift
//  Spanish Verbs Quiz
//
//  Created by Normand Martin on 2019-03-16.
//  Copyright © 2019 Normand Martin. All rights reserved.
//

import Foundation
class OtraFormaEvaluation {
    class func trnasform(rightAnswer: String, infinitif: String, modeVerb: String, tempsVerb: String) -> String{
        var rightAnswerNoPronoum = rightAnswer
        rightAnswerNoPronoum = rightAnswerNoPronoum.removingReflexivePronom()
        var infinitifNoPronoum = infinitif
        infinitifNoPronoum = infinitifNoPronoum.removingReflexivePronomInfinitif()
        var arrayRightAnswer = rightAnswer.components(separatedBy: .whitespaces)
        var otraForma = OtraFormaVerbSelector.otraForma(mode: modeVerb, temp: tempsVerb, infinitif: infinitifNoPronoum, verbeConjugue: rightAnswerNoPronoum)
        if arrayRightAnswer[0] == "me" || arrayRightAnswer[0] == "te" || arrayRightAnswer[0] == "se" || arrayRightAnswer[0] == "nos" || arrayRightAnswer[0] == "os" {
            otraForma = arrayRightAnswer[0] + " " + otraForma
        }
        if (modeVerb.caseInsensitiveCompare("SUBJUNTIVO") == .orderedSame) && tempsVerb == "Imperfecto" {
            otraForma = " o \(otraForma)"
        }else{
            otraForma = ""
        }
        return otraForma
    }
}

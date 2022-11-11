//
//  Speak.swift
//  QuizVerbesItaliens
//
//  Created by Normand Martin on 2022-10-30.
//  Copyright © 2022 Normand Martin. All rights reserved.
//

import UIKit
import AVFoundation
class Speak {
    static func text(text: String){
        let synthVM = SynthViewModel()
        var restOfSentence: String = text.components(separatedBy: "/").dropFirst().joined(separator: " ")
        let firstWord: String = text.components(separatedBy: "/").first!
        print("firstWord: \(firstWord)")
        switch firstWord {
        case "Ud":
            restOfSentence = "Usted" + "," + "o" + "," + restOfSentence
        case "Uds":
            restOfSentence = "Ustedes" + "," + "o" + "," + restOfSentence
        case "que Ud":
            restOfSentence = "que" + " " + "Usted" + "," + "o" + "," + restOfSentence
        case "que Uds":
            restOfSentence = "que" + " " + "Ustedes" + "," + "o" + "," + restOfSentence
        default:
            restOfSentence = text

        }
        print("restOfSentence: \(restOfSentence)")
        synthVM.speak(text: restOfSentence)
    }
    func speak(text: String) {
        let speechSynthesizer = AVSpeechSynthesizer()
        let utterance = AVSpeechUtterance(string: text)
        speechSynthesizer.speak(utterance)
    }
    
}

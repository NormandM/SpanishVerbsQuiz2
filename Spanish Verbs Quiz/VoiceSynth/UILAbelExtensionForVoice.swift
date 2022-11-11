//
//  UILAbelExtensionForVoice.swift
//  QuizVerbesItaliens
//
//  Created by Normand Martin on 2022-10-28.
//  Copyright © 2022 Normand Martin. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
extension UILabel {
    func clickLabel(){
        let gesture = UITapGestureRecognizer(target: self, action: #selector(labelClicked))
        addGestureRecognizer(gesture)
    }
    @objc func labelClicked() {
        if self.textColor == .red {
            self.textColor = .black
        }else{
            self.textColor = .red
        }
        var firstWord = self.text?.components(separatedBy: "/").first
        var restOfSentence: String = (self.text?.components(separatedBy: "/").dropFirst().joined(separator: " "))!
        let firstCharacter = self.text?.first
        var impSentence = String()
        if firstCharacter == "(" {
            let res = self.text?.components(separatedBy: " ").dropFirst().joined(separator: " ")
            let secondWord = res!.components(separatedBy: " ").first
            if secondWord == "no" {
                impSentence = res!
                firstWord = self.text?.components(separatedBy: " ").first
            }else{
                firstWord = self.text?.components(separatedBy: " ").first
                impSentence = (self.text?.components(separatedBy: " ").dropFirst().joined(separator: " "))!
                print("impSentence: \(impSentence)")
            }
        }
        print("firstWord: \(firstWord!)")
        switch firstWord {
        case "Ud":
            restOfSentence = "Usted" + "," + "o" + "," + restOfSentence
        case "Uds":
            restOfSentence = "Ustedes" + "," + "o" + "," + restOfSentence
       case "(tu)", "(Ud)", "(Uds)", "(nosotros)", "(vosotros)" :
            restOfSentence = impSentence
        case "que Ud":
            restOfSentence = "que" + " " + "Usted" + "," + "o" + "," + restOfSentence
        case "que Uds":
            restOfSentence = "que" + " " + "Ustedes" + "," + "o" + "," + restOfSentence
        default:
            restOfSentence = text!
  
        }

        let synthVM = SynthViewModel()
        synthVM.speak(text: restOfSentence)
    }
    func speak(text: String) {
        let speechSynthesizer = AVSpeechSynthesizer()
        let utterance = AVSpeechUtterance(string: text)
        speechSynthesizer.speak(utterance)
    }
}



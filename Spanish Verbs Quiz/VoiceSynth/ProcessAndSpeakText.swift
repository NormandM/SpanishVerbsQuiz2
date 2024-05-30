//
//  File.swift
//  Spanish Verbs Quiz
//
//  Created by Normand Martin on 2024-05-28.
//  Copyright © 2024 Normand Martin. All rights reserved.
//

import Foundation
import UIKit

func processAndSpeakText(text: String?) -> String {
    guard let text = text, !text.isEmpty else {
        print("Label text is empty or nil.")
        return ""
    }

    var firstWord = text.components(separatedBy: "/").first
    var restOfSentence = text.components(separatedBy: "/").dropFirst().joined(separator: " ")
    let firstCharacter = text.first
    var impSentence = String()
    
    if firstCharacter == "(" {
        let res = text.components(separatedBy: " ").dropFirst().joined(separator: " ")
        let secondWord = res.components(separatedBy: " ").first
        if secondWord == "no" {
            impSentence = res
            firstWord = text.components(separatedBy: " ").first
        } else {
            firstWord = text.components(separatedBy: " ").first
            impSentence = text.components(separatedBy: " ").dropFirst().joined(separator: " ")
        }
    }
    switch firstWord {
    case "Ud":
        restOfSentence = "Usted, \(restOfSentence)"
    case "Uds":
        restOfSentence = "Ustedes, \(restOfSentence)"
    case "(tu)", "(Ud)", "(Uds)", "(nosotros)", "(vosotros)":
        restOfSentence = impSentence
    case "que Ud":
        restOfSentence = "que Usted, \(restOfSentence)"
    case "que Uds":
        restOfSentence = "que Ustedes, \(restOfSentence)"
    default:
        restOfSentence = text
    }
    return restOfSentence
    
}



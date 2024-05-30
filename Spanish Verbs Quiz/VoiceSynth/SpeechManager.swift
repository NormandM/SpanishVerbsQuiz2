//
//  SpeechManager.swift
//  TextToSpeach2
//
//  Created by Normand Martin on 2024-05-27.
//

import UIKit
import AVFoundation

class SpeechManager: NSObject, AVSpeechSynthesizerDelegate {
    
    static let shared = SpeechManager()
    
    private var synthesizer: AVSpeechSynthesizer
    private var activeLabel: UILabel?
    
    // Flag to indicate if speech is ongoing
    private var isSpeaking: Bool = false
    
    private override init() {
        synthesizer = AVSpeechSynthesizer()
        super.init()
        synthesizer.delegate = self
    }
    
    func speak(text: String, for label: UILabel? = nil, language: String = "es", rate: Float = 0.4) {
        if isSpeaking {
            return
        }
        isSpeaking = true
        let restOfSentence = processAndSpeakText(text: text)
        let utterance = AVSpeechUtterance(string: restOfSentence)
        utterance.voice = AVSpeechSynthesisVoice(language: language)
        utterance.rate = rate
        activeLabel = label
        activeLabel?.textColor = .red
        synthesizer.speak(utterance)
    }
    
    // MARK: - AVSpeechSynthesizerDelegate Methods
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        activeLabel?.textColor = .black
        activeLabel = nil
        isSpeaking = false
    }
}

//
//  SpeechLabel.swift
//  TextToSpeach2
//
//  Created by Normand Martin on 2024-05-27.
//

import UIKit

class SpeechLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGesture()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupGesture()
    }
    
    private func setupGesture() {
        self.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc private func labelTapped() {
        let restOfSentence = processAndSpeakText(text: text)
        SpeechManager.shared.speak(text: restOfSentence, language: "es")

   }
}

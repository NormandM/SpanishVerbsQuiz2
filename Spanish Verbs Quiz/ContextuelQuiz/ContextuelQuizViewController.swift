//
//  ContextuelQuizViewController.swift
//  French Verbs Quiz
//
//  Created by Normand Martin on 2018-11-16.
//  Copyright © 2018 Normand Martin. All rights reserved.
//

import UIKit
import AudioToolbox
import CoreData

class ContextuelQuizViewController: UIViewController, NSFetchedResultsControllerDelegate {
    let notificationCenter = NotificationCenter.default
    @IBOutlet weak var modeLabel: UILabel!
    @IBOutlet weak var tempsLabel: UILabel!
    @IBOutlet weak var tempsEtverbesChoisiButton: UIButton!
    @IBOutlet weak var suggestionButton: UIButton!
    @IBOutlet weak var sentenceLabel: SpeechLabel!
    @IBOutlet weak var verbTextField: UITextField!
    @IBOutlet weak var uneAutreQuestionButton: UIButton!
    @IBOutlet weak var barreProgression: UIProgressView!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var verbResponseButton: UIButton!
    @IBOutlet var verbHintButton: [UIButton]!
    @IBOutlet weak var modeConstraint: NSLayoutConstraint!
    @IBOutlet weak var tempConstraint: NSLayoutConstraint!
    @IBOutlet weak var tempsChoisiConstraint: NSLayoutConstraint!
    @IBOutlet weak var sentenceConstraint: NSLayoutConstraint!
    @IBOutlet weak var wrondResponseCorrectionLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    
    var soundURL: NSURL?
    var soundID:SystemSoundID = 0
    var textFieldIsActivated = false
    var reponseBonne: String = ""
    var rightHintWasSelected = false
    var indexSentence = Int()
    var selectedSentences = [[String]]()
    var sentenceArray = [[String]]()
    var difficulté = DifficultyLevel.FACILE
    var arrayVerb = [[String]]()
    var modeEtTemps = [[String]]()
    var userRespone = String()
    lazy var sentences = Sentences(selectedSentences: selectedSentences, indexSentence: indexSentence)
    var progressInt = Int()
    var soundPlayer: SoundPlayer?
    var reponseEvaluation = QuizResult.bad
    override func viewDidLoad() {
        super.viewDidLoad()
        barreProgression.progress = 0.0
        if let plistPath = Bundle.main.path(forResource: "VerbesEspagnolsContextuels", ofType: "plist"),
            let arrayNS = NSArray(contentsOfFile: plistPath){
            sentenceArray = arrayNS as! [[String]]
        }
        for sentences in sentenceArray {
            for selection in modeEtTemps {
                if selection[0].caseInsensitiveCompare(sentences[1]) == .orderedSame  && selection[1].caseInsensitiveCompare(sentences[0]) == .orderedSame {
                    selectedSentences.append(sentences)
                }
            }
        }
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillChange), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillChange), name: UIResponder.keyboardWillHideNotification, object: nil)
        let voiceStopped = Notification.Name("voiceStopped")
        notificationCenter.addObserver(self,selector: #selector(voiceDidTerminate),name: voiceStopped,object: nil)
        selectedSentences.shuffle()
    }
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        errorLabel.isHidden = true
        wrondResponseCorrectionLabel.isHidden = true
        let fonts = FontsAndConstraintsOptions()
        self.title = "Conjugar el verbo".localized
        modeLabel.font = fonts.largeBoldFont
        tempsLabel.font = fonts.largeBoldFont
        suggestionButton.titleLabel?.font = fonts.smallItaliqueBoldFont
        tempsEtverbesChoisiButton.titleLabel?.font = fonts.smallFont
        sentenceLabel.font = fonts.normalItaliqueBoldFont
        verbTextField.font = fonts.normalFont
        uneAutreQuestionButton.titleLabel!.font = fonts.normalFont
        checkButton.titleLabel!.font = fonts.largeBoldFont
        verbResponseButton.titleLabel!.font = fonts.normalItaliqueBoldFont
        for eachButton in verbHintButton {
            eachButton.titleLabel!.font = fonts.normalFont
        }
        TextFieldProperties.initiate(verbHintButton: verbHintButton, verbResponseButton: verbResponseButton, checkButton: checkButton, verbTextField: verbTextField, difficulté: difficulté, suggestionButton: suggestionButton, hintMenuAction: hintMenuActiondAppear)
        choiceOfSentence()
        verbResponseButton.isEnabled = false


    }
    override func viewDidAppear(_ animated: Bool) {
        tempsEtverbesChoisiButton.layer.cornerRadius = tempsEtverbesChoisiButton.frame.height/2
        verbResponseButton.layer.cornerRadius = verbResponseButton.frame.height / 2.0
        uneAutreQuestionButton.layer.cornerRadius = uneAutreQuestionButton.frame.height / 2.0
        suggestionButton.layer.cornerRadius = suggestionButton.frame.height / 2.0
        verbHintButton.forEach {(eachButton) in
            eachButton.layer.cornerRadius = eachButton.frame.height / 2.0
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        UserDefaults.standard.set(0, forKey: "thisQuizHintAnswer")
        UserDefaults.standard.set(0, forKey: "thisQuizGoodAnswer")
        UserDefaults.standard.set(0, forKey: "thisQuizBadAnswer")
    }
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        tempsEtverbesChoisiButton.layer.cornerRadius = tempsEtverbesChoisiButton.frame.height/2
        uneAutreQuestionButton.layer.cornerRadius = uneAutreQuestionButton.frame.height / 2.0
        suggestionButton.layer.cornerRadius = suggestionButton.frame.height / 2.0
        uneAutreQuestionButton.setNeedsLayout()
    }
    func animateViewMoving (_ up:Bool, moveValue :CGFloat){
        let movement:CGFloat = ( up ? -moveValue : moveValue)
        let newRatio = movement/view.frame.height
        if up{
            self.view.frame = self.view.frame.offsetBy(dx: 0,  dy: movement)
            modeConstraint.constant = -newRatio * view.frame.height
            tempConstraint.constant = -newRatio * view.frame.height
            tempsChoisiConstraint.constant = -newRatio * view.frame.height
            textFieldIsActivated = true
        }else{
            self.view.frame = self.view.frame.offsetBy(dx: 0,  dy: -movement)
            modeConstraint.constant = 0.35
            tempConstraint.constant = 0.45
            tempsChoisiConstraint.constant = 0.6
            textFieldIsActivated = false
        }
    }
    @objc func keyBoardWillChange(notification: Notification) {
        let distanceFromTextField = view.frame.size.height - (verbTextField.frame.size.height + verbTextField.frame.origin.y)
        guard let keyBoardRec = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else{
            return
        }
        if notification.name == UIResponder.keyboardWillShowNotification && !textFieldIsActivated{
            textFieldIsActivated = true
            let moveValue = keyBoardRec.height - distanceFromTextField + 5
            animateViewMoving(true, moveValue: moveValue)
            if moveValue > 100 {tempsEtverbesChoisiButton.isHidden = true}
        }else if notification.name == UIResponder.keyboardWillHideNotification{
            textFieldIsActivated = false
            animateViewMoving(false, moveValue: distanceFromTextField - keyBoardRec.height - 5)
            tempsEtverbesChoisiButton.isHidden = false
        }
    }
    @objc func textFieldShouldReturn(_ reponse: UITextField) -> Bool {
        userRespone = verbTextField.text!
        afterUserResponse()
        verbTextField.resignFirstResponder()
        checkButton.setTitleColor(UIColor.gray, for: .disabled)
        suggestionButton.isEnabled = false
        suggestionButton.backgroundColor = UIColor(red: 178/255, green: 208/255, blue: 198/255, alpha: 1.0)
        verbTextField.isHidden = true
        suggestionButton.isEnabled = false
        suggestionButton.backgroundColor = UIColor(red: 178/255, green: 208/255, blue: 198/255, alpha: 1.0)
        verbTextField.isHidden = true
        verbResponseButton.isHidden = false
        checkButton.isHidden = true
        return true
    }
    func hintMenuActiondissapear() {
        verbHintButton.forEach { (eachButton) in
            UIView.animate(withDuration: 0.4, animations: {
                eachButton.isHidden = true
                self.view.layoutIfNeeded()
            })
        }
    }
    func hintMenuActiondAppear() {
        verbHintButton.forEach { (eachButton) in
            UIView.animate(withDuration: 0.4, animations: {
                eachButton.isHidden = false
                self.view.layoutIfNeeded()
            })
        }
    }
    func choiceOfSentence () {
        indexSentence = indexSentence + 1
        if indexSentence == selectedSentences.count - 1 {indexSentence = 0}
        sentences = Sentences(selectedSentences: selectedSentences, indexSentence: indexSentence)
        questionInitialisation()
    }
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showChoixDeTemps" {
            let controller = segue.destination as! ChoixDeTempsViewController
            controller.tempsEtMode = modeEtTemps
        }
        if segue.identifier == "showResult" {
            let wichQuiz = UnwindSegueChoice.toContexteViewController
            let controller = segue.destination as! ResultViewController
            controller.totalProgress = 10
            controller.wichQuiz = wichQuiz
        }
    }
    @IBAction func unwindToContextuekQuiz(segue: UIStoryboardSegue) {
        UserDefaults.standard.set(0, forKey: "thisQuizGoodAnswer")
        UserDefaults.standard.set(0, forKey: "thisQuizHintAnswer")
        UserDefaults.standard.set(0, forKey: "thisQuizBadAnswer")
        barreProgression.progress = 0.0
        progressInt = 0
        barreProgression.progress = 0.0
        selectionAutreQuestion()
    }
    func questionInitialisation() {
        verbTextField.text = ""
        let tempsDuVerbe = sentences.tempsDuVerbe
        let modeDuverbe = sentences.modeDuverbe
        reponseBonne = sentences.reponseBonne
        let infinitif = sentences.infinitif
        modeLabel.text = modeDuverbe.capitalizingFirstLetter()
        tempsLabel.text = tempsDuVerbe.capitalizingFirstLetter()
        sentenceLabel.attributedText = sentences.attributeQuestion
        switch difficulté {
        case .FACILE:
            ChoixFacileVerbeConjugue.verbeConjugue(arrayVerbe: arrayVerb, infinitif: infinitif, tempsDuVerbe: tempsDuVerbe, modeDuverbe: modeDuverbe, verbHintButton: verbHintButton, hintMenuAction: hintMenuActiondAppear, reponseBonne: reponseBonne )
        default:
            break
        }
    }

    func afterUserResponse() {
        soundPlayer = SoundPlayer()
        sentences = Sentences(selectedSentences: selectedSentences, indexSentence: indexSentence)
        let mode = sentences.modeDuverbe
        let temps = sentences.tempsDuVerbe
        reponseEvaluation = ResponseEvaluation.evaluate(modeVerb: mode, tempsVerb:  temps, infinitif: sentences.infinitif, userResponse: userRespone, rightAnswer: sentences.reponseBonne, rightHintWasSelected: rightHintWasSelected)
        sentenceLabel.textColor = UIColor(red: 178/255, green: 208/255, blue: 198/255, alpha: 1.0)
        switch reponseEvaluation {
        case .good, .help:
            sentenceLabel.attributedText = sentences.attributeBonneReponse
            verbResponseButton.setTitle("Correcto".localized, for: .disabled)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                SpeechManager.shared.speak(text: self.sentenceLabel.text!, for: self.sentenceLabel, rate: 0.4)
            }
        case .bad:
            soundPlayer?.playSound(soundName: "etc_error_drum", type: "mp3")
            verbResponseButton.setTitle("Incorrecto".localized, for: .disabled)
            sentenceLabel.attributedText = sentences.attributeMauvaiseReponse
            errorLabel.isHidden = false
            wrondResponseCorrectionLabel.isHidden = false
            attributeSettingForAnswer(label: errorLabel, systemName: "x.circle.fill", color: .red, text: " Incorrecto:".localized)
            errorLabel.textColor = .black
            let fonts = FontsAndConstraintsOptions()
            errorLabel.font = fonts.normalFont
            wrondResponseCorrectionLabel.font = fonts.normalFont
            wrondResponseCorrectionLabel.text = userRespone
            wrondResponseCorrectionLabel.textColor = .red
        }
        verbTextField.resignFirstResponder()
        checkButton.isEnabled = false
        checkButton.setTitleColor(UIColor.gray, for: .disabled)
        suggestionButton.isEnabled = false
        suggestionButton.backgroundColor = UIColor(red: 178/255, green: 208/255, blue: 198/255, alpha: 1.0)
        verbResponseButton.isHidden = false
        checkButton.isHidden = true
        progressInt = progressInt + 1
        barreProgression.progress = Float(progressInt)/Float(10)
        if progressInt == 10 {
            let when = DispatchTime.now() + 1.0 // change 2 to desired number of seconds
            uneAutreQuestionButton.isEnabled = false
            DispatchQueue.main.asyncAfter(deadline: when) {
                self.performSegue(withIdentifier: "showResult", sender: nil)
            }
        }
    }
    func selectionAutreQuestion() {
        errorLabel.isHidden = true
        wrondResponseCorrectionLabel.isHidden = true
        sentenceLabel.textColor = UIColor.black
        checkButton.isEnabled = true
        verbTextField.isEnabled = true
        verbTextField.textColor = UIColor.black
        verbTextField.text = ""
        verbResponseButton.setTitle("Elige el verbo".localized, for: .disabled)
        uneAutreQuestionButton.isEnabled = true
        difficulté = .DIFFICILE
        rightHintWasSelected = false
        TextFieldProperties.initiate(verbHintButton: verbHintButton, verbResponseButton: verbResponseButton, checkButton: checkButton, verbTextField: verbTextField, difficulté: difficulté, suggestionButton: suggestionButton, hintMenuAction: hintMenuActiondAppear)
        choiceOfSentence()
    }
    func attributeSettingForAnswer(label: UILabel, systemName: String, color: UIColor, text: String) {
        let attachment = NSTextAttachment()
        let config = UIImage.SymbolConfiguration(scale: .large)
        attachment.image = UIImage(systemName: systemName, withConfiguration: config)?.withTintColor(color)
        let imageString = NSMutableAttributedString(attachment: attachment)
        let textString = NSAttributedString(string: text)
        imageString.append(textString)
        label.attributedText = imageString
        label.sizeToFit()
    }
    // MARK: Buttons
    @IBAction func uneAutreQuestionButtonPushed(_ sender: UIButton) {
        selectionAutreQuestion()
    }
    @IBAction func checkButton(_ sender: UIButton) {
        userRespone = verbTextField.text!
        afterUserResponse()
        verbTextField.resignFirstResponder()
        checkButton.isEnabled = false
        checkButton.setTitleColor(UIColor.gray, for: .disabled)
        suggestionButton.isEnabled = false
        suggestionButton.backgroundColor = UIColor(red: 178/255, green: 208/255, blue: 198/255, alpha: 1.0)
        verbTextField.isHidden = true
        verbResponseButton.isHidden = false
        checkButton.isHidden = true
    }
    @IBAction func verbHintPressed(_ sender: UIButton) {
        userRespone = (sender.titleLabel?.text?.lowercased())!
        if reponseBonne.lowercased() == sender.titleLabel?.text?.lowercased() {
            rightHintWasSelected = true
        }else{
            rightHintWasSelected = false
        }
        afterUserResponse()
        hintMenuActiondissapear()
    }
    @IBAction func suggestionButtonWasPressed(_ sender: UIButton) {
        difficulté = .FACILE
        TextFieldProperties.initiate(verbHintButton: verbHintButton, verbResponseButton: verbResponseButton, checkButton: checkButton, verbTextField: verbTextField, difficulté: difficulté, suggestionButton: suggestionButton, hintMenuAction: hintMenuActiondAppear)
        suggestionButton.isEnabled = false
        questionInitialisation()
        suggestionButton.backgroundColor = UIColor(red: 178/255, green: 208/255, blue: 198/255, alpha: 1.0)
    }
    @objc func voiceDidTerminate(_ notification: NSNotification){
        sentences = Sentences(selectedSentences: selectedSentences, indexSentence: indexSentence)
        sentenceLabel.textColor = UIColor(red: 178/255, green: 208/255, blue: 198/255, alpha: 1.0)
        switch reponseEvaluation {
        case .good, .help:
            sentenceLabel.attributedText = sentences.attributeBonneReponse

        case .bad:
            sentenceLabel.attributedText = sentences.attributeMauvaiseReponse
        }
    }
}


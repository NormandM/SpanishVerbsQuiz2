//
//  ResultViewController.swift
//  French Verbs Quiz
//
//  Created by Normand Martin on 2016-12-09.
//  Copyright © 2016 Normand Martin. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var resultat: UILabel!
    @IBOutlet weak var message: UILabel!
    var testCompltete = UserDefaults.standard.bool(forKey: "testCompltete")
    var totalProgress: Int = 0
    var goodResponse: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        testCompltete = true
        UserDefaults.standard.set(self.testCompltete, forKey: "testCompltete")
        resultat.text = "\(goodResponse)/\(totalProgress)"
        let result = Double(goodResponse)/Double(totalProgress)
        let resultPercent = String(round(result*100)) + " %"
        
//        if goodResponse == 10{
//            message.text = "¡Perfecto! "
//        }else if goodResponse == 9 ||  goodResponse == 8 || goodResponse == 7{
//            message.text = "¡Excelente!"
//        }else{
//            message.text = "Inténtelo de nuevo"
//        }
        if result == 1.0{
            message.text = "¡Perfecto! "
        }else if result < 1 && Double(result) >= 0.75{
            message.text = "\(resultPercent) ¡Excelente!"
        }else  if Double(result) >= 0.6 && Double(result) < 0.75{
            message.text = "\(resultPercent)¡Muy Biene!"
        }else{
            message.text = "\(resultPercent) ¡Inténtelo de nuevo!"
        }

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindToQuizController" {
            let controller = segue.destination as! QuizController
            controller.testCompltete = testCompltete
        }
    }

    
    @IBAction func termine(_ sender: Any) {
        //performSegue(withIdentifier: "unwindToQuizController", sender: self)
        self.dismiss(animated: true, completion: nil)
    }




}

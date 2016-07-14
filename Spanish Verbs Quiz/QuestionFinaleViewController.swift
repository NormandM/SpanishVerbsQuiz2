//
//  QuestionFinaleViewController.swift
//  Spanish Verbs Quiz
//
//  Created by Normand Martin on 16-07-08.
//  Copyright © 2016 Normand Martin. All rights reserved.
//

import UIKit

class QuestionFinaleViewController: UIViewController {
    
    var infoQuiz: [String] = []

    var modeChoixVerbe = ""
    var verbeChoisi = ""
    var indexVerbe = 0
    var indexTemps = 0
    var modo: [String] = []

  
    var tempsVerbe = ""
    enum ModoChoix: String{
        case PresenteInd = "Presente ", ImperfectoInd = "Imperfecto ", PretéritoInd = "Pretérito ", FuturoInd = "Futuro ", PresenteProgresivoInd = "Presente progresivo ", PretéritoPerfectoInd = "Pretérito perfecto ", PluscuamperfectoInd = "Pluscuamperfecto ", FuturoPerfectoInd = "Futuro perfecto ", PretéritoAnteriorInd = "Pretérito anterior ", PresenteSub = "Presente", ImperfectoSub = "Imperfecto", FuturoSub = "Futuro", PretéritoPerfectoSub = "Pretérito perfecto", PluscuamperfectoSub = "Pluscuamperfecto", CondicionalCond = "Condicional", PerfectoCond = "Perfecto", PositivoImp = "Positivo", NegativoImp = "Negativo"
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()


        if let plistPath = NSBundle.mainBundle().pathForResource("arr5", ofType: "plist"),
            verbArray = NSArray(contentsOfFile: plistPath){
            var n = 0

                n = verbArray.count/10
                indexVerbe = Int(arc4random_uniform(UInt32(n))) - 1
                print(n)
            let i = infoQuiz.count
            indexTemps = Int(arc4random_uniform(UInt32(i)))
            tempsVerbe = infoQuiz[indexTemps]
            verbeChoisi = verbArray[indexVerbe][1] as! String
        }
        if let modoChoix = ModoChoix(rawValue: tempsVerbe){
            switch modoChoix{
            case .PresenteInd, .ImperfectoInd, .PretéritoPerfectoInd, .PretéritoInd, .FuturoInd, .PluscuamperfectoInd, .FuturoPerfectoInd, .PresenteProgresivoInd, .PretéritoAnteriorInd:
                 modo.append(tempsVerbe)
                modo.append("Infinitivo")
            case .FuturoSub, .ImperfectoSub, .PluscuamperfectoSub, .PresenteSub, .PretéritoPerfectoSub:
                modo.append(tempsVerbe)
                modo.append ("Subjuntivo")
                
            case .PerfectoCond, .CondicionalCond:
                modo.append(tempsVerbe)
                modo.append("Condicional")
                
            case .PositivoImp, .NegativoImp:
                modo.append(tempsVerbe)
                modo.append("Imperativo")
            }
            print(modo)
            print(verbeChoisi)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

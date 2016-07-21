//
//  QuestionFinaleViewController.swift
//  Spanish Verbs Quiz
//
//  Created by Normand Martin on 16-07-08.
//  Copyright © 2016 Normand Martin. All rights reserved.
//

import UIKit
import AudioToolbox
var soundURL: NSURL?
var soundID:SystemSoundID = 0

class QuestionFinaleViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var verbeInfinitif: UILabel!
    @IBOutlet weak var modeDuVerbe: UILabel!
    @IBOutlet weak var personneDuVerbe: UILabel!
    @IBOutlet weak var correction: UILabel!
    @IBOutlet weak var reponse: UITextField!
    @IBOutlet weak var leTempsDuVerbe: UILabel!
    
    var arr: NSMutableArray = []
    var arrN: [[String]] = []
    var verbeCorrige = ""
    var personneVerbeCount = 0
    var personneChoisi = ""
    var infoQuiz: [String] = []
    var verbeChoisi = ""
    var indexVerbe = 0
    var indexTemps = 0
    var modo: [String] = []
    var tempsVerbe = ""

    enum ModoChoix: String{
        case PresenteInd = "Presente ", ImperfectoInd = "Imperfecto ", PretéritoInd = "Pretérito ", FuturoInd = "Futuro ", PresenteProgresivoInd = "Presente progresivo ", PretéritoPerfectoInd = "Pretérito perfecto ", PluscuamperfectoInd = "Pluscuamperfecto ", FuturoPerfectoInd = "Futuro perfecto ", PretéritoAnteriorInd = "Pretérito anterior ", PresenteSub = "Presente", ImperfectoSub = "Imperfecto", FuturoSub = "Futuro", PretéritoPerfectoSub = "Pretérito perfecto", PluscuamperfectoSub = "Pluscuamperfecto", CondicionalCond = "Condicional", PerfectoCond = "Perfecto", PositivoImp = "Positivo", NegativoImp = "Negativo", FuturoPerfectoSub = "Futuro perfecto"
    }
    enum Ref: Int{
        case PresenteInd = 0, ImperfectoInd = 4, PretéritoInd = 1, FuturoInd = 2, PresenteProgresivoInd = 5, PretéritoPerfectoInd = 6, PluscuamperfectoInd = 7, FuturoPerfectoInd = 8, PretéritoAnteriorInd = 10, PresenteSub = 11, ImperfectoSub = 12, FuturoSub = 14, PretéritoPerfectoSub = 15, PluscuamperfectoSub = 16, CondicionalCond = 3, PerfectoCond = 9, PositivoImp = 19, NegativoImp = 20, FuturoPerfectoSub = 18
    }
    enum Personne: Int{
        case yo = 0, tu = 1, el = 2, nosotros = 3, vosotros = 4, ellos = 5
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let plist = Plist(name: "arr5") {
            var n = 0
            arr = plist.getMutablePlistFile()!
            let i = arr.count
            while n < i {
                arrN.append(arr[n] as! [String])
                n = n + 1
            }
            let ii = arrN.count
            n = 0
            while n < ii {
                if arrN[n].count < 13{
                    arrN[n].append("0")
                    arrN[n].append("0")
                    arrN[n].append("0")
                }
                    n = n + 1
            }
            
        }
        if let plist = Plist(name: "arr5"){
            do {
                try plist.addValuesToPlistFile(arrN)
            } catch {
                print(error)
            }
        }else{
            print("unable to get plist")
        }

        choixDeVerbe()
    
        }
    
    
    @IBAction func otro(sender: UIButton) {
        correction.text = ""
        reponse.text = ""
        choixDeVerbe()
    }
        
        func choixDeVerbe() -> String{
            if let plistPath = NSBundle.mainBundle().pathForResource("arr5", ofType: "plist"),
               verbArray = NSArray(contentsOfFile: plistPath){
            var n = 0
            n = verbArray.count/21
            indexVerbe = (Int(arc4random_uniform(UInt32(n))) - 1) * 21
            if indexVerbe < 0 {
                indexVerbe = 0
            }
            let i = infoQuiz.count
            indexTemps = Int(arc4random_uniform(UInt32(i)))
            tempsVerbe = infoQuiz[indexTemps]
                let intVerbArray: [[String]] = verbArray as! [[String]]
                verbeChoisi = intVerbArray[indexVerbe][1]
            
            
            if let modoChoix = ModoChoix(rawValue: tempsVerbe){
                switch modoChoix{
                case .PresenteInd:
                    modo.append(tempsVerbe)
                    modo.append("Infinitivo")
                    indexVerbe = indexVerbe + Ref.PresenteInd.rawValue
                case .ImperfectoInd:
                    modo.append(tempsVerbe)
                    modo.append("Infinitivo")
                    indexVerbe = indexVerbe + Ref.ImperfectoInd.rawValue
                case .PretéritoPerfectoInd:
                    modo.append(tempsVerbe)
                    modo.append("Infinitivo")
                    indexVerbe = indexVerbe + Ref.PretéritoPerfectoInd.rawValue
                case .PretéritoInd:
                    modo.append(tempsVerbe)
                    modo.append("Infinitivo")
                    indexVerbe = indexVerbe + Ref.PretéritoInd.rawValue
                case .FuturoInd:
                    modo.append(tempsVerbe)
                    modo.append("Infinitivo")
                    indexVerbe = indexVerbe + Ref.FuturoInd.rawValue
                case .PluscuamperfectoInd:
                    modo.append(tempsVerbe)
                    modo.append("Infinitivo")
                    indexVerbe = indexVerbe + Ref.PluscuamperfectoInd.rawValue
                case .FuturoPerfectoInd:
                    modo.append(tempsVerbe)
                    modo.append("Infinitivo")
                    indexVerbe = indexVerbe + Ref.FuturoPerfectoInd.rawValue
                case .PresenteProgresivoInd:
                    modo.append(tempsVerbe)
                    modo.append("Infinitivo")
                    indexVerbe = indexVerbe + Ref.PresenteProgresivoInd.rawValue
                case .PretéritoAnteriorInd:
                    modo.append(tempsVerbe)
                    modo.append("Infinitivo")
                    indexVerbe = indexVerbe + Ref.PretéritoAnteriorInd.rawValue
                case .FuturoSub:
                    modo.append(tempsVerbe)
                    modo.append ("Subjuntivo")
                    indexVerbe = indexVerbe + Ref.FuturoSub.rawValue
                case .ImperfectoSub:
                    modo.append(tempsVerbe)
                    modo.append ("Subjuntivo")
                    indexVerbe = indexVerbe + Ref.ImperfectoSub.rawValue
                case .PluscuamperfectoSub:
                    modo.append(tempsVerbe)
                    modo.append ("Subjuntivo")
                    indexVerbe = indexVerbe + Ref.PluscuamperfectoSub.rawValue
                case .PresenteSub:
                    modo.append(tempsVerbe)
                    modo.append ("Subjuntivo")
                    indexVerbe = indexVerbe + Ref.PresenteSub.rawValue
                case .PretéritoPerfectoSub:
                    modo.append(tempsVerbe)
                    modo.append ("Subjuntivo")
                    indexVerbe = indexVerbe + Ref.PretéritoPerfectoSub.rawValue
                case .FuturoPerfectoSub:
                    modo.append(tempsVerbe)
                    modo.append ("Subjuntivo")
                    indexVerbe = indexVerbe + Ref.FuturoPerfectoSub.rawValue
                case .PerfectoCond:
                    modo.append(tempsVerbe)
                    modo.append("Condicional")
                    indexVerbe = indexVerbe + Ref.PerfectoCond.rawValue
                case .CondicionalCond:
                    modo.append(tempsVerbe)
                    modo.append("Condicional")
                    indexVerbe = indexVerbe + Ref.CondicionalCond.rawValue
                case .PositivoImp:
                    modo.append(tempsVerbe)
                    modo.append("Imperativo")
                    indexVerbe = indexVerbe + Ref.PositivoImp.rawValue
                case .NegativoImp:
                    modo.append(tempsVerbe)
                    modo.append("Imperativo")
                    indexVerbe = indexVerbe + Ref.NegativoImp.rawValue
                }
               
                modeDuVerbe.text = modo[1]
                leTempsDuVerbe.text = modo[0]
                let verbeChoisi2 = verbeChoisi.uppercaseString
                verbeInfinitif.text? = verbeChoisi2
               

            }
            
            let allVerbs = VerbeEspagnol(verbArray: verbArray, n: indexVerbe)
            
            if modo[1] == "Imperativo" {
                personneVerbeCount = 5
            }else {
                personneVerbeCount = 6
            }
            var personneVerbeRandom = Int(arc4random_uniform(UInt32(personneVerbeCount)))
            if modo[1] == "Imperativo" {
                personneVerbeRandom = personneVerbeRandom + 1
            }
            if let personne = Personne(rawValue: personneVerbeRandom){
                switch personne {
                case .yo:
                    personneChoisi = "yo"
                    verbeCorrige = allVerbs.yo
                    
                case .tu:
                    personneChoisi = "tu"
                    verbeCorrige = allVerbs.tu
                    
                case .el:
                    personneChoisi = "el"
                    verbeCorrige = allVerbs.el
                    
                case .nosotros:
                    personneChoisi = "nosotros"
                    verbeCorrige = allVerbs.nosotros
                    
                case .vosotros:
                    personneChoisi = "vosotros"
                    verbeCorrige = allVerbs.vosotros
                    
                case .ellos:
                    personneChoisi = "ellos"
                    verbeCorrige = allVerbs.ellos
                    
                }
            }
            if modo[1] == "Subjuntivo"{
                personneChoisi = "que \(personneChoisi)"
            }else if modo[1] == "Imperativo"{
                personneChoisi = "(\(personneChoisi))"
            }
            
            personneDuVerbe.text = personneChoisi
            modo = []
            
           }
        
    
    return verbeCorrige
    
    }
    
    func textFieldShouldReturn(reponse: UITextField) -> Bool {
        arrN[indexVerbe][11] = String(Int(arrN[indexVerbe][11])! + 1)
        if reponse.text == verbeCorrige{
            arrN[indexVerbe][10] = String(Int(arrN[indexVerbe][10])! + 1)
            let filePath = NSBundle.mainBundle().pathForResource("Incoming Text 01", ofType: "wav")
            soundURL = NSURL(fileURLWithPath: filePath!)
            AudioServicesCreateSystemSoundID(soundURL!, &soundID)
            AudioServicesPlaySystemSound(soundID)
            correction.text = "¡Muy Bien¡"
            correction.textColor = UIColor(red: 0/255, green: 255/255, blue: 0/255, alpha: 1.0)
            
        }else{
            let filePath = NSBundle.mainBundle().pathForResource("Error Warning", ofType: "wav")
            soundURL = NSURL(fileURLWithPath: filePath!)
            AudioServicesCreateSystemSoundID(soundURL!, &soundID)
            AudioServicesPlaySystemSound(soundID)

            correction.text = verbeCorrige
            correction.textColor = UIColor(red: 255/255, green: 17/255, blue: 93/255, alpha: 1.0)
        }
        if Int(arrN[indexVerbe][11]) > 0 {
            arrN[indexVerbe][12] = String(Double(arrN[indexVerbe][10])! / Double(arrN[indexVerbe][11])! * 100) + "%"
        }

        if let plist = Plist(name: "arr5"){
            do {
                try plist.addValuesToPlistFile(arrN)
            } catch {
                print(error)
            }
        }else{
            print("unable to get plist")
        }

        reponse.resignFirstResponder()
        return true
        
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

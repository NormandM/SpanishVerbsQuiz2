//
//  FinalVerbDisplayViewController.swift
//  Spanish Verbs Quiz
//
//  Created by Normand Martin on 16-06-28.
//  Copyright © 2016 Normand Martin. All rights reserved.
//

import UIKit

class FinalVerbDisplayViewController: ViewController {
    
    @IBOutlet weak var infinitoLabel: UILabel!
    @IBOutlet weak var tiempoLabel: UILabel!
    @IBOutlet weak var yoLabel: UILabel!
    @IBOutlet weak var tuLabel: UILabel!
    @IBOutlet weak var elLabel: UILabel!
    @IBOutlet weak var nosotrosLabel: UILabel!
    @IBOutlet weak var vosotrosLabel: UILabel!
    @IBOutlet weak var ellosLabel: UILabel!
    
    enum TiempoVerbo: String {
        case IndicativoPresente = "IndicativoPresente", IndicativoPretérito = "IndicativoPretérito", IndicativoFuturo = "IndicativoFuturo", Condicional = "Condicional", IndicativoImperfecto = "IndicativoImperfecto", IndicativoPresenteprogresivo = "IndicativoPresenteprogresivo", IndicativoPretéritoperfecto = "IndicativoPretéritoperfecto", IndicativoPluscuamperfecto = "IndicativoPluscuamperfecto", IndicativoFuturoperfecto = "IndicativoFuturoperfecto", Condicionalperfecto = "Condicionalperfecto", IndicativoPretéritoanterior = "IndicativoPretéritoanterior", Subjuntivopresente = "Subjuntivopresente", Subjuntivoimperfecto = "Subjuntivoimperfecto", Subjuntivofuturo = "Subjuntivofuturo", Subjuntivopretéritoperfecto = "Subjuntivopretéritoperfecto", Subjuntivopluscuamperfecto = "Subjuntivopluscuamperfecto", Subjuntivofuturoperfecto = "Subjuntivofuturoperfecto", Imperativopositivo = "Imperativopositivo", Imperativonegativo = "Imperativonegativo"
    }
    var selectionVerbe = ["", "", ""]
    var nombre: Int = 0
    var randomVerb: Int = 0
    var i: Int = 0
    var tiempo: String = ""
    var subjImp: Int = 0
    var finalVerb: [String] = [""]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        if let plistPath = NSBundle.mainBundle().pathForResource("Conjug", ofType: "plist"),
            verbArray = NSArray(contentsOfFile: plistPath){
            nombre = verbArray.count
            var allVerbs = VerbeEspagnol(verbArray: verbArray, n: randomVerb )
            for verb in verbArray{
                if selectionVerbe[0] == verb[1] as! String && selectionVerbe[1] == verb[2] as! String && selectionVerbe[2] == verb[3] as! String{
                    allVerbs = VerbeEspagnol(verbArray: verbArray, n: i)
                    if selectionVerbe[2] == "Subjuntivo imperfecto" || selectionVerbe[2] == "Subjuntivo pluscuamperfecto"{
                        subjImp = i
                        
                    }
                }
                
                i = i + 1
            }

            let replaced = allVerbs.tiempo.stringByReplacingOccurrencesOfString(" ", withString: "")
            if allVerbs.modo == "Indicativo"{
                tiempo = allVerbs.modo + replaced
            }else{
                tiempo = replaced
            }
            if let tiempoVerbo = TiempoVerbo(rawValue: tiempo){
                switch tiempoVerbo{
                case .IndicativoPresente, .IndicativoPretérito, .IndicativoFuturo, .Condicional, .IndicativoImperfecto, .IndicativoPresenteprogresivo, .IndicativoPretéritoperfecto, .IndicativoPluscuamperfecto, .IndicativoFuturoperfecto, .Condicionalperfecto, .IndicativoPretéritoanterior:
                    let firstperson = "yo " + allVerbs.yo
                    let secondperson = "tu " + allVerbs.tu
                    let thirdPerson = "el " + allVerbs.el
                    let fourthPerson = "nosotros " + allVerbs.nosotros
                    let fifthPerson = "vosotros " + allVerbs.vosotros
                    let sixthPerson = "ellos " + allVerbs.ellos
                    finalVerb = [firstperson, secondperson, thirdPerson, fourthPerson, fifthPerson, sixthPerson]
                    
                case .Subjuntivopresente, .Subjuntivofuturo, .Subjuntivopretéritoperfecto, .Subjuntivofuturoperfecto:
                    let firstperson = "que yo " + allVerbs.yo
                    let secondperson = "que tu " + allVerbs.tu
                    let thirdPerson = "que el " + allVerbs.el
                    let fourthPerson = "que nosotros " + allVerbs.nosotros
                    let fifthPerson = "que vosotros " + allVerbs.vosotros
                    let sixthPerson = "que ellos " + allVerbs.ellos
                    finalVerb = [firstperson, secondperson, thirdPerson, fourthPerson, fifthPerson, sixthPerson]
                    
                case .Subjuntivoimperfecto, .Subjuntivopluscuamperfecto:
                    let firstperson = "que yo " + allVerbs.yo
                    let secondperson = "que tu " + allVerbs.tu
                    let thirdPerson = "que el " + allVerbs.el
                    let fourthPerson = "que nosotros " + allVerbs.nosotros
                    let fifthPerson = "que vosotros " + allVerbs.vosotros
                    let sixthPerson = "que ellos " + allVerbs.ellos
                    let AllVerbs2 = VerbeEspagnol(verbArray: verbArray, n: subjImp - 1)
                    let seventhPerson = "/ " + AllVerbs2.yo
                    let eightPerson = "/ " + AllVerbs2.tu
                    let ninePerson = "/ " + AllVerbs2.el
                    let tenPerson = "/ " + AllVerbs2.nosotros
                    let elevenPerson = "/ " + AllVerbs2.vosotros
                    let twelvePerson = "/ " + AllVerbs2.ellos
                    finalVerb = [firstperson + seventhPerson, secondperson + eightPerson, thirdPerson + ninePerson, fourthPerson + tenPerson, fifthPerson + elevenPerson, sixthPerson + twelvePerson]
                    
                case .Imperativonegativo, .Imperativopositivo:
                    let firstperson = ""
                    let secondperson = "(tu) " + allVerbs.tu
                    let thirdPerson = "(el) " + allVerbs.el
                    let fourthPerson = "(nosotros) " + allVerbs.nosotros
                    let fifthPerson = "(vosotros) " + allVerbs.vosotros
                    let sixthPerson = "(ellos )" + allVerbs.ellos
                    finalVerb = [firstperson, secondperson, thirdPerson, fourthPerson, fifthPerson, sixthPerson]
                    
                }
                
            }
            yoLabel.text = finalVerb[0]
            tuLabel.text = finalVerb[1]
            elLabel.text = finalVerb[2]
            nosotrosLabel.text = finalVerb[3]
            vosotrosLabel.text = finalVerb[4]
            ellosLabel.text = finalVerb[5]
            
            
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}

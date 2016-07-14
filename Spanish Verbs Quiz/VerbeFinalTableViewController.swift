//
//  VerbeFinalTableViewController.swift
//  Spanish Verbs Quiz
//
//  Created by Normand Martin on 16-06-24.
//  Copyright © 2016 Normand Martin. All rights reserved.
//

import UIKit

class VerbeFinalTableViewController: UITableViewController {
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
    var sectionListe: [String] = [""]
    override func viewDidLoad() {
        super.viewDidLoad()

        if let plistPath = NSBundle.mainBundle().pathForResource("arr5", ofType: "plist"),
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
                            let seventhPerson = "que yo " + AllVerbs2.yo
                            let eightPerson = "que tu " + AllVerbs2.tu
                            let ninePerson = "que el " + AllVerbs2.el
                            let tenPerson = "que nosotros " + AllVerbs2.nosotros
                            let elevenPerson = "que vosotros " + AllVerbs2.vosotros
                            let twelvePerson = "que ellos " + AllVerbs2.ellos
                            finalVerb = [firstperson, secondperson, thirdPerson, fourthPerson, fifthPerson, sixthPerson," ", "*** Otra forma***", seventhPerson, eightPerson, ninePerson, tenPerson, elevenPerson, twelvePerson]

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

            
            
        }
        if selectionVerbe[1] == "Indicativo" {
            sectionListe = [selectionVerbe[1] + " " + selectionVerbe[2]]
        }else{
            sectionListe = [selectionVerbe[2]]
        }
        print(selectionVerbe)
        print(sectionListe)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sectionListe.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return finalVerb.count
    }
    
    //override func tableView( tableView : UITableView,  titleForHeaderInSection section: Int)->String {
     //   return  sectionListe
   // }
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return " \(sectionListe[0])"
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CellVerb", forIndexPath: indexPath)

        cell.textLabel!.text = finalVerb[indexPath.row]
        return cell
    }




}

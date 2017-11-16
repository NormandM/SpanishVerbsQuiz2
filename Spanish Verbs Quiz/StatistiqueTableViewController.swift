//
//  StatistiqueTableViewController.swift
//  French Verbs Quiz
//
//  Created by Normand Martin on 2016-12-11.
//  Copyright © 2016 Normand Martin. All rights reserved.
//

import UIKit
import CoreData

class StatistiqueTableViewController: UITableViewController {
    @IBOutlet weak var remettreAZero: UIBarButtonItem!
    
    var itemFinal: [[String]] = []
    
    let dataController = DataController.sharedInstance
    let managedObjectContext = DataController.sharedInstance.managedObjectContext
    lazy var fetchRequest: NSFetchRequest<NSFetchRequestResult> = {
        let request  = NSFetchRequest<NSFetchRequestResult>(entityName: ItemVerbe.identifier)
        let sortDescriptor = NSSortDescriptor(key: "verbeInfinitif", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        return request
    }()
    
    let sectionListe = ["INDICATIVO", "SUBJUNTIVO", "CONDICIONAL", "IMPERATIVO"]
    let itemInitial = [["Presente", "Imperfecto", "Pretérito", "Futuro", "Presente Continuo", "Pretérito perfecto", "Pluscuamperfecto", "Futuro perfecto", "Pretérito anterior"], ["Presente", "Imperfecto", "Futuro", "Pretérito perfecto", "Pluscuamperfecto"], ["Condicional", "Perfecto"], ["Positivo", "Negativo"]]
    var items: [ItemVerbe] = []

    enum TempsDeVerbe: String {
        case Presente = "IndicativoPresente"
        case Imperfecto = "IndicativoImperfecto"
        case Pretéritoperfecto = "IndicativoPretérito perfecto"
        case Pretérito = "IndicativoPretérito"
        case Pluscuamperfecto = "IndicativoPluscuamperfecto"
        case Futuro = "IndicativoFuturo"
        case Pretéritoanterior = "IndicativoPretérito anterior"
        case Futuroperfecto = "IndicativoFuturo perfecto"
        case Presentecontinuo = "IndicativoPresente continuo"
        case SubjuntivoPresente = "SubjuntivoPresente"
        case SubjuntivoPretérito = "SubjuntivoPretérito perfecto"
        case SubjuntivoImperfecto = "SubjuntivoImperfecto"
        case SubjuntivoPluscuamperfecto = "SubjuntivoPluscuamperfecto"
        case SubjuntivoFuturo = "SubjuntivoFuturo"
        case CondicionalCondicional = "CondicionalCondicional"
        case CondicionalPerfecto = "CondicionalPerfecto"
        case ImperativoPositivo = "ImperativoPositivo"
        case ImperativoNegativo = "ImperativoNegativo"
    
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView //recast your view as a UITableViewHeaderFooterView
        header.contentView.backgroundColor = UIColor(red: 151/255, green: 156/255, blue: 159/255, alpha: 1.0) //make the background color light blue
        header.textLabel!.textColor = UIColor.white //make the text white
        header.alpha = 1.0 //make the header transparent
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Resultados por cada tiempo"
        populateData()
     }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionListe[section]
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionListe.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemInitial[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = self.itemFinal[indexPath.section][indexPath.row]
        return cell
    }
//////////////////////////////////////
// MARK: All Buttons and actions
//////////////////////////////////////

     @IBAction func remettreAZero(_ sender: UIBarButtonItem) {
        remettreAZero.tintColor = UIColor.black
        do {
            let items = try managedObjectContext.fetch(fetchRequest) as! [NSManagedObject]
            
            for item in items {
                managedObjectContext.delete(item)
            }
            try managedObjectContext.save()
            
        } catch {

        }
            populateData()
            tableView.reloadData()
    }
////////////////////////////////////////////
// MARK: ALL FUNCTIONS
///////////////////////////////////////////
    func populateData() {
        var IndicativoPresenteP: String = ""
        var IndicativoImperfectoP: String = ""
        var IndicativoPretéritoperfectoP: String = ""
        var IndicativoPretéritoP: String = ""
        var IndicativoPluscuamperfectoP: String = ""
        var IndicativoFuturoP: String = ""
        var IndicativoPretéritoanteriorP: String = ""
        var IndicativoFuturoperfectoP: String = ""
        var IndicativoPresentecontinuoP: String = ""
        var SubjuntivoPresenteP: String = ""
        var SubjuntivoPretéritoperfectoP: String = ""
        var SubjuntivoImperfectoP: String = ""
        var SubjuntivoPluscuamperfectoP: String = ""
        var SubjuntivoFuturoP: String = ""
        var CondicionalCondicionalP: String = ""
        var CondicionalPerfectoP: String = ""
        var ImperativoPositivoP: String = ""
        var ImperativoNegativoP: String = ""
        var IndicativoPresenteB: Int = 0
        var IndicativoPresenteM: Int = 0
        var IndicativoImperfectoB: Int = 0
        var IndicativoImperfectoM: Int = 0
        var IndicativoPretéritoperfectoB: Int = 0
        var IndicativoPretéritoperfectoM: Int = 0
        var IndicativoPretéritoB: Int = 0
        var IndicativoPretéritoM: Int = 0
        var IndicativoPluscuamperfectoB: Int = 0
        var IndicativoPluscuamperfectoM: Int = 0
        var IndicativoFuturoB: Int = 0
        var IndicativoFuturoM: Int = 0
        var IndicativoPretéritoanteriorB: Int = 0
        var IndicativoPretéritoanteriorM: Int = 0
        var IndicativoFuturoperfectoB: Int = 0
        var IndicativoFuturoperfectoM: Int = 0
        var IndicativoPresentecontinuoB: Int = 0
        var IndicativoPresentecontinuoM: Int = 0
        var SubjuntivoPresenteB: Int = 0
        var SubjuntivoPresenteM: Int = 0
        var SubjuntivoPretéritoperfectoB: Int = 0
        var SubjuntivoPretéritoperfectoM: Int = 0
        var SubjuntivoImperfectoB: Int = 0
        var SubjuntivoImperfectoM: Int = 0
        var SubjuntivoPluscuamperfectoB: Int = 0
        var SubjuntivoPluscuamperfectoM: Int = 0
        var SubjuntivoFuturoB: Int = 0
        var SubjuntivoFuturoM: Int = 0
        var CondicionalCondicionalB: Int = 0
        var CondicionalCondicionalM: Int = 0
        var CondicionalPerfectoB: Int = 0
        var CondicionalPerfectoM: Int = 0
        var ImperativoPositivoB: Int = 0
        var ImperativoPositivoM: Int = 0
        var ImperativoNegativoB: Int = 0
        var ImperativoNegativoM: Int = 0


        do {
            items = try managedObjectContext.fetch(fetchRequest) as! [ItemVerbe]
        }catch let error as NSError {
            print("Error fetching Item objects: \(error.localizedDescription), \(error.userInfo)")
        }
        for item in items {
            if let tempVerbe = TempsDeVerbe(rawValue: (item.modeVerbe! + item.tempsVerbe!)){
                switch tempVerbe {
                case .Presente:
                    IndicativoPresenteB = IndicativoPresenteB + Int(item.bonneReponse)
                    IndicativoPresenteM = IndicativoPresenteM + Int(item.mauvaiseReponse)
                case .CondicionalPerfecto:
                    CondicionalPerfectoB = CondicionalPerfectoB + Int(item.bonneReponse)
                    CondicionalPerfectoM = CondicionalPerfectoM + Int(item.mauvaiseReponse)
                case .CondicionalCondicional:
                    CondicionalCondicionalB = CondicionalCondicionalB + Int(item.bonneReponse)
                    CondicionalCondicionalM = CondicionalCondicionalM + Int(item.mauvaiseReponse)
                case .Futuroperfecto:
                    IndicativoFuturoperfectoB = IndicativoFuturoperfectoB + Int(item.bonneReponse)
                    IndicativoFuturoperfectoM = IndicativoFuturoperfectoM + Int(item.mauvaiseReponse)
                case .Futuro:
                    IndicativoFuturoB = IndicativoFuturoB + Int(item.bonneReponse)
                    IndicativoFuturoM = IndicativoFuturoM + Int(item.mauvaiseReponse)
                case .Imperfecto:
                    IndicativoImperfectoB = IndicativoImperfectoB + Int(item.bonneReponse)
                    IndicativoImperfectoM = IndicativoImperfectoM + Int(item.mauvaiseReponse)
                case .ImperativoPositivo:
                    ImperativoPositivoB = ImperativoPositivoB + Int(item.bonneReponse)
                    ImperativoPositivoM = ImperativoPositivoM + Int(item.mauvaiseReponse)
                case .ImperativoNegativo:
                    ImperativoNegativoB = ImperativoNegativoB + Int(item.bonneReponse)
                    ImperativoNegativoM = ImperativoNegativoM + Int(item.mauvaiseReponse)
                    
                case .Pretéritoperfecto:
                    IndicativoPretéritoperfectoB = IndicativoPretéritoperfectoB + Int(item.bonneReponse)
                    IndicativoPretéritoperfectoM = IndicativoPretéritoperfectoM + Int(item.mauvaiseReponse)
                case .Pretérito:
                    IndicativoPretéritoB = IndicativoPretéritoB + Int(item.bonneReponse)
                    IndicativoPretéritoM = IndicativoPretéritoM + Int(item.mauvaiseReponse)
                case .Pretéritoanterior:
                    IndicativoPretéritoanteriorB = IndicativoPretéritoanteriorB + Int(item.bonneReponse)
                    IndicativoPretéritoanteriorM = IndicativoPretéritoanteriorM + Int(item.mauvaiseReponse)
                case .Pluscuamperfecto:
                    IndicativoPluscuamperfectoB = IndicativoPluscuamperfectoB + Int(item.bonneReponse)
                    IndicativoPluscuamperfectoM = IndicativoPluscuamperfectoM + Int(item.mauvaiseReponse)
                case .Presentecontinuo:
                    IndicativoPresentecontinuoB = IndicativoPresentecontinuoB + Int(item.bonneReponse)
                    IndicativoPresentecontinuoM = IndicativoPresentecontinuoM + Int(item.mauvaiseReponse)
                case .SubjuntivoImperfecto:
                    SubjuntivoImperfectoB = SubjuntivoImperfectoB + Int(item.bonneReponse)
                    SubjuntivoImperfectoM = SubjuntivoImperfectoM + Int(item.mauvaiseReponse)
                case .SubjuntivoPretérito:
                    SubjuntivoPretéritoperfectoB = SubjuntivoPretéritoperfectoB + Int(item.bonneReponse)
                    SubjuntivoPretéritoperfectoM = SubjuntivoPretéritoperfectoM + Int(item.mauvaiseReponse)
                case .SubjuntivoPluscuamperfecto:
                    SubjuntivoPluscuamperfectoB = SubjuntivoPluscuamperfectoB + Int(item.bonneReponse)
                    SubjuntivoPluscuamperfectoM = SubjuntivoPluscuamperfectoM + Int(item.mauvaiseReponse)
                case .SubjuntivoPresente:
                    SubjuntivoPresenteB = SubjuntivoPresenteB + Int(item.bonneReponse)
                    SubjuntivoPresenteM = SubjuntivoPresenteM + Int(item.mauvaiseReponse)
                case .SubjuntivoFuturo:
                    SubjuntivoFuturoB = SubjuntivoFuturoB + Int(item.bonneReponse)
                    SubjuntivoFuturoM = SubjuntivoFuturoM + Int(item.mauvaiseReponse)
                }
            }
            
        }
        IndicativoPresenteP = "Presente: " + pourcentage(bonne: IndicativoPresenteB, mauvaise: IndicativoPresenteM)
        IndicativoImperfectoP = "Imperfecto: " + pourcentage(bonne: IndicativoImperfectoB, mauvaise: IndicativoImperfectoM)
        IndicativoPretéritoperfectoP = "Pretérito perfecto " + pourcentage(bonne: IndicativoPretéritoperfectoB, mauvaise: IndicativoPretéritoperfectoM)
        IndicativoPretéritoP = "Pretérito: " + pourcentage(bonne: IndicativoPretéritoB, mauvaise: IndicativoPretéritoM)
        IndicativoPluscuamperfectoP = "Pluscuamperfecto: " + pourcentage(bonne: IndicativoPluscuamperfectoB, mauvaise: IndicativoPluscuamperfectoM)
        IndicativoFuturoP = "Futuro: " + pourcentage(bonne: IndicativoFuturoB, mauvaise: IndicativoFuturoM)
        IndicativoPretéritoanteriorP = "Pretérito anterior: " + pourcentage(bonne: IndicativoPretéritoanteriorB, mauvaise: IndicativoPretéritoanteriorM)
        IndicativoFuturoperfectoP = "Futuro perfecto " + pourcentage(bonne: IndicativoFuturoperfectoB, mauvaise: IndicativoFuturoperfectoM)
        IndicativoPresentecontinuoP = "Presente continuo: " + pourcentage(bonne: IndicativoPresentecontinuoB, mauvaise: IndicativoPresentecontinuoM)
        SubjuntivoPresenteP = "Presente: " + pourcentage(bonne: SubjuntivoPresenteB, mauvaise: SubjuntivoPresenteM)
        SubjuntivoPretéritoperfectoP = "Pretérito perfecto: " + pourcentage(bonne: SubjuntivoPretéritoperfectoB, mauvaise: SubjuntivoPretéritoperfectoM)
        SubjuntivoImperfectoP = "Imperfecto: " + pourcentage(bonne: SubjuntivoImperfectoB, mauvaise: SubjuntivoImperfectoM)
        SubjuntivoPluscuamperfectoP = "Pluscuamperfecto: " + pourcentage(bonne: SubjuntivoPluscuamperfectoB, mauvaise: SubjuntivoPluscuamperfectoM)
        SubjuntivoFuturoP = "Futuro: " + pourcentage(bonne: SubjuntivoFuturoB, mauvaise: SubjuntivoFuturoM)
        CondicionalCondicionalP = "Condicional: " + pourcentage(bonne: CondicionalCondicionalB, mauvaise: CondicionalCondicionalM)
        CondicionalPerfectoP = "Perfecto: " + pourcentage(bonne: CondicionalPerfectoB, mauvaise: CondicionalPerfectoM)
        ImperativoPositivoP = "Positivo: " + pourcentage(bonne: ImperativoPositivoB, mauvaise: ImperativoPositivoM)
        ImperativoNegativoP = "Negativo: " + pourcentage(bonne: ImperativoNegativoB, mauvaise: ImperativoNegativoM)
        
        
        itemFinal = [[IndicativoPresenteP, IndicativoImperfectoP, IndicativoPretéritoperfectoP, IndicativoFuturoP, IndicativoPresentecontinuoP, IndicativoPretéritoP, IndicativoPluscuamperfectoP, IndicativoFuturoperfectoP, IndicativoPretéritoanteriorP], [SubjuntivoPresenteP, SubjuntivoPretéritoperfectoP, SubjuntivoImperfectoP, SubjuntivoPluscuamperfectoP, SubjuntivoFuturoP], [CondicionalCondicionalP, CondicionalPerfectoP], [ImperativoPositivoP, ImperativoNegativoP]]

    }
    
    func pourcentage (bonne: Int, mauvaise: Int) -> String{
        var result = ""
        if (bonne + mauvaise) != 0 {
            result = String(round (Double(bonne) / Double(bonne + mauvaise) * 100)) + "%"
        }else{
            result = "_"
        }
        return result
    }
}

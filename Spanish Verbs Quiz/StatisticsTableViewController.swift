//
//  StatisticsTableViewController.swift
//  Spanish Verbs Quiz
//
//  Created by Normand Martin on 16-07-18.
//  Copyright © 2016 Normand Martin. All rights reserved.
//

import UIKit


class StatisticsTableViewController: UITableViewController {

    var presenteInd = ""
    var imperfectoInd = ""
    var pretéritoInd = ""
    var futuroInd = ""
    var presenteProgresivoInd = ""
    var pretéritoPerfectoInd = ""
    var pluscuamperfectoInd = ""
    var futuroPerfectoInd = ""
    var pretéritoAnteriorInd = ""
    var presenteSub = ""
    var imperfectoSub = ""
    var futuroSub = ""
    var pretéritoPerfectoSub = ""
    var pluscuamperfectoSub = ""
    var condicional = ""
    var perfectoCond = ""
    var positivo = ""
    var negativo = ""
    var item = [[""]]
    var refresh = false
    
    let sectionListe = ["INDICATIVO", "SUBJUNTIVO", "CONDICIONAL", "IMPERATIVO"]


    var arrN: [[String]] = []
    var arrNN: [[String]] = []
    var arr: NSMutableArray = []
    var scoreVerbeTotal: [Int] = []
    var scoreBonVerbe: [Int] = []
    var scoreTempsTotal: [Int] = []
    var scoreBonTemps: [Int] = []
    var indexVerbe = 0
    var presenteBon = 0
    var presenteTot = 0
    var preteritoBon = 0
    var preteritoTot = 0
    var futuroBon = 0
    var futuroTot = 0
    var imperfectoBon = 0
    var imperfectoTot = 0
    var presenteProgresivoBon = 0
    var presenteProgresivoTot = 0
    var preteritoPerfectoBon = 0
    var preteritoPerfectoTot = 0
    var pluscuamperfectoBon = 0
    var pluscuamperfectoTot = 0
    var futuroPerfectoBon = 0
    var futuroPerfectoTot = 0
    var preteritoAnteriorBon = 0
    var preteritoAnteriorTot = 0
    var condicionalBon = 0
    var condicionalTot = 0
    var condicionalPerfectoBon = 0
    var condicionalPerfectoTot = 0
    var subjuntivoPresenteBon = 0
    var subjuntivoPresenteTot = 0
    var subjuntivoImperfectoBon = 0
    var subjuntivoImperfectoTot = 0
    var subjuntivoImperfecto2Bon = 0
    var subjuntivoImperfecto2Tot = 0
    var subjuntivoFuturoBon = 0
    var subjuntivoFuturoTot = 0
    var subjuntivoPreteritoPerfectoBon = 0
    var subjuntivoPreteritoPerfectoTot = 0
    var subjuntivoPluscuamperfectoBon = 0
    var subjuntivoPluscuamperfectoTot = 0
    var subjuntivoPluscuamperfecto2Bon = 0
    var subjuntivoPluscuamperfecto2Tot = 0
    var subjuntivoFuturoPerfectoBon = 0
    var subjuntivoFuturoPerfectoTot = 0
    var imperativoPositivoBon = 0
    var imperativoPositivoTot = 0
    var imperativoNegativoBon = 0
    var imperativoNegativoTot = 0
    enum Ref: Int{
        case PresenteInd = 0, ImperfectoInd = 4, PretéritoInd = 1, FuturoInd = 2, PresenteProgresivoInd = 5, PretéritoPerfectoInd = 6, PluscuamperfectoInd = 7, FuturoPerfectoInd = 8, PretéritoAnteriorInd = 10, PresenteSub = 11, ImperfectoSub = 12, ImperfectoSub2 = 13, FuturoSub = 14, PretéritoPerfectoSub = 15, PluscuamperfectoSub = 16, PluscuamperfectoSub2 = 17,CondicionalCond = 3, PerfectoCond = 9, PositivoImp = 19, NegativoImp = 20, FuturoPerfectoSub = 18
    }
    // Changing backgroung colors of the header of sections
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView //recast your view as a UITableViewHeaderFooterView
        header.contentView.backgroundColor = UIColor(red: 151/255, green: 156/255, blue: 159/255, alpha: 1.0) //make the background color light blue
        header.textLabel!.textColor = UIColor.whiteColor() //make the text white
        header.alpha = 1.0
    }
        override func viewDidLoad() {
        super.viewDidLoad()
        loadDataonDemand ()

    }

    
    func loadDataonDemand () {
        // gets the mutable plist
        if let plist = Plist(name: "arr5") {
            var n = 0
            arr = plist.getMutablePlistFile()!
            arrN = arr.map{($0 as! [String])}
            // calculations to have results per time of verb
            n = 0
            let i = arrN.count
            while n < i  {
                var nn = 0
                while nn < 21 {
                    if let ref = Ref(rawValue: nn){
                        switch ref{
                        case .PresenteInd:
                            presenteBon = presenteBon + Int(arrN[n + nn][10])!
                            presenteTot = presenteTot + Int(arrN[n + nn][11])!
                        case .ImperfectoInd:
                            imperfectoBon = imperfectoBon + Int(arrN[n + nn][10])!
                            imperfectoTot = imperfectoTot + Int(arrN[n + nn][11])!
                        case .PretéritoPerfectoInd:
                            preteritoPerfectoBon = preteritoPerfectoBon + Int(arrN[n + nn][10])!
                            preteritoPerfectoTot = preteritoPerfectoTot + Int(arrN[n + nn][11])!
                        case .PretéritoInd:
                            preteritoBon = preteritoBon + Int(arrN[n + nn][10])!
                            preteritoTot = preteritoTot + Int(arrN[n + nn][11])!
                        case .FuturoInd:
                            futuroBon = futuroBon + Int(arrN[n + nn][10])!
                            futuroTot = futuroTot + Int(arrN[n + nn][11])!
                        case .PluscuamperfectoInd:
                            pluscuamperfectoBon = pluscuamperfectoBon + Int(arrN[n + nn][10])!
                            pluscuamperfectoTot = pluscuamperfectoTot + Int(arrN[n + nn][11])!
                        case .FuturoPerfectoInd:
                            futuroPerfectoBon = futuroPerfectoBon + Int(arrN[n + nn][10])!
                            futuroPerfectoTot = futuroPerfectoTot + Int(arrN[n + nn][11])!
                        case .PresenteProgresivoInd:
                            presenteProgresivoBon = presenteProgresivoBon + Int(arrN[n + nn][10])!
                            presenteProgresivoTot = presenteProgresivoTot + Int(arrN[n + nn][11])!
                        case .PretéritoAnteriorInd:
                            preteritoAnteriorBon = preteritoAnteriorBon + Int(arrN[n + nn][10])!
                            preteritoAnteriorTot = preteritoAnteriorTot + Int(arrN[n + nn][11])!
                        case .FuturoSub:
                            subjuntivoFuturoBon = subjuntivoFuturoBon + Int(arrN[n + nn][10])!
                            subjuntivoFuturoTot = subjuntivoFuturoTot + Int(arrN[n + nn][11])!
                        case .ImperfectoSub:
                            subjuntivoImperfectoBon = subjuntivoImperfectoBon + Int(arrN[n + nn][10])!
                            subjuntivoImperfectoTot = subjuntivoImperfectoTot + Int(arrN[n + nn][11])!
                        case .ImperfectoSub2:
                            subjuntivoImperfecto2Bon = subjuntivoImperfecto2Bon + Int(arrN[n + nn][10])!
                            subjuntivoImperfecto2Tot = subjuntivoImperfecto2Tot + Int(arrN[n + nn][11])!
                        case .PluscuamperfectoSub:
                            subjuntivoPluscuamperfectoBon = subjuntivoPluscuamperfectoBon + Int(arrN[n + nn][10])!
                            subjuntivoPluscuamperfectoTot = subjuntivoPluscuamperfectoTot + Int(arrN[n + nn][11])!
                        case .PluscuamperfectoSub2:
                            subjuntivoPluscuamperfecto2Bon = subjuntivoPluscuamperfecto2Bon + Int(arrN[n + nn][10])!
                            subjuntivoPluscuamperfecto2Tot = subjuntivoPluscuamperfecto2Tot + Int(arrN[n + nn][11])!
                        case .PresenteSub:
                            subjuntivoPresenteBon = subjuntivoPresenteBon + Int(arrN[n + nn][10])!
                            subjuntivoPresenteTot = subjuntivoPresenteTot + Int(arrN[n + nn][11])!
                        case .PretéritoPerfectoSub:
                            subjuntivoPreteritoPerfectoBon = subjuntivoPreteritoPerfectoBon + Int(arrN[n + nn][10])!
                            subjuntivoPreteritoPerfectoTot = subjuntivoPreteritoPerfectoTot + Int(arrN[n + nn][11])!
                        case .FuturoPerfectoSub:
                            subjuntivoFuturoPerfectoBon = subjuntivoFuturoPerfectoBon + Int(arrN[n + nn][10])!
                            subjuntivoFuturoPerfectoTot = subjuntivoFuturoPerfectoTot + Int(arrN[n + nn][11])!
                        case .PerfectoCond:
                            condicionalPerfectoBon = condicionalPerfectoBon + Int(arrN[n + nn][10])!
                            condicionalPerfectoTot = condicionalPerfectoTot + Int(arrN[n + nn][11])!
                        case .CondicionalCond:
                            condicionalBon = condicionalBon + Int(arrN[n + nn][10])!
                            condicionalTot = condicionalTot + Int(arrN[n + nn][11])!
                        case .PositivoImp:
                            imperativoPositivoBon = imperativoPositivoBon + Int(arrN[n + nn][10])!
                            imperativoPositivoTot = imperativoPositivoTot + Int(arrN[n + nn][11])!
                        case .NegativoImp:
                            imperativoNegativoBon = imperativoNegativoBon + Int(arrN[n + nn][10])!
                            imperativoNegativoTot = imperativoNegativoTot + Int(arrN[n + nn][11])!
                        }
                    }
                    nn = nn + 1
                }
                n = n + 21
            }
            func write (bonne: Int, totale: Int) -> String {
                let reponse: String
                if totale > 0  && refresh == false{
                    reponse = String(round(Double(bonne)/Double(totale) * 100)) + "%"
                }else{
                    reponse = "__"
                }
                return reponse
            }
            func writeImp (bonne: Int, totale: Int, bonne2: Int, total2: Int) -> String {
                let reponseImp: String
                if (totale > 0 || total2 > 0) && refresh == false {
                    reponseImp = String (round(Double(bonne + bonne2) / Double(totale + total2) * 100)) + "%"
                }else{
                    reponseImp = "__"
                }
                return reponseImp
            }
            
            
            
            presenteInd = "Presente: " + write(presenteBon, totale: presenteTot)
            imperfectoInd = "Imperfecto: " + write(imperfectoBon, totale: imperfectoTot)
            pretéritoInd = "Pretérito: " + write(preteritoBon, totale: preteritoTot)
            futuroInd = "Futuro: " + write(futuroBon, totale: futuroTot)
            presenteProgresivoInd = "Presente Continuo: " + write(presenteProgresivoBon, totale: presenteProgresivoTot)
            pretéritoPerfectoInd = "Pretérito perfecto: " + write(preteritoPerfectoBon, totale: preteritoPerfectoTot)
            pluscuamperfectoInd = "Pluscuamperfecto: " + write(pluscuamperfectoBon, totale: pluscuamperfectoTot)
            futuroPerfectoInd = "Futuro perfecto: " + write(futuroPerfectoBon, totale: futuroPerfectoTot)
            pretéritoAnteriorInd = "Pretérito anterior: " + write(preteritoAnteriorBon, totale: preteritoAnteriorTot)
            presenteSub = "Presente: " + write(subjuntivoPresenteBon, totale: subjuntivoPresenteTot)
            imperfectoSub = "Imperfecto: " + writeImp(subjuntivoImperfectoBon, totale: subjuntivoImperfectoTot, bonne2: subjuntivoImperfecto2Bon, total2: subjuntivoImperfecto2Tot)
            futuroSub = "Futuro: " + write(subjuntivoFuturoBon, totale: subjuntivoFuturoTot)
            pretéritoPerfectoSub = "Pretérito perfecto: " + write(subjuntivoPreteritoPerfectoBon, totale: subjuntivoPreteritoPerfectoTot)
            pluscuamperfectoSub = "Pluscuamperfecto: " + writeImp(subjuntivoPluscuamperfectoBon, totale: subjuntivoPluscuamperfectoTot, bonne2: subjuntivoPluscuamperfecto2Bon, total2: subjuntivoPluscuamperfecto2Tot)
            condicional = "Condicional: " + write(condicionalBon, totale: condicionalTot)
            perfectoCond = "Perfecto: " + write(condicionalPerfectoBon, totale: condicionalPerfectoTot)
            positivo = "Positivo: " + write(imperativoPositivoBon, totale: imperativoPositivoTot)
            negativo = "Negativo: " + write(imperativoNegativoBon, totale: imperativoNegativoTot)
            let itemInt = [[presenteInd, imperfectoInd, pretéritoInd, futuroInd, presenteProgresivoInd, pretéritoPerfectoInd, pluscuamperfectoInd, futuroPerfectoInd, pretéritoAnteriorInd], [presenteSub, imperfectoSub, futuroSub, pretéritoPerfectoSub, pluscuamperfectoSub], [condicional, perfectoCond], [positivo, negativo]]
            item = itemInt
        
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    // button to reset to 0 all statistics
    @IBAction func borrarEstadisticas(sender: UIButton) {
            arrNN = []
            if let plist = Plist(name: "arr5") {
                var n = 0
                arr = plist.getMutablePlistFile()!
                arrNN = arr.map{($0 as! [String])}
                let ii = arrNN.count
                n = 0
                while n < ii {
                    arrNN[n][10] = "0"
                    arrNN[n][11] = "0"
                    arrNN[n][12] = "0"
                    n = n + 1
                }
                
            }
            if let plist = Plist(name: "arr5"){
                do {
                    try plist.addValuesToPlistFile(arrNN)
                    
                } catch {
                    print(error)
                }
            }else{
                print("unable to get plist")
            }
        
        
        refresh = true
        loadDataonDemand()
        tableView.reloadData()
        }


       
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return sectionListe[section]
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sectionListe.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return item[section].count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        cell.textLabel!.text = self.item[indexPath.section][indexPath.row]
        return cell
    }


 
}

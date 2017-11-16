//
//  QuizOptionsController.swift
//  French Verbs Quiz
//
//  Created by Normand Martin on 2016-12-04.
//  Copyright © 2016 Normand Martin. All rights reserved.
//

import UIKit

class QuizOptionsController: UITableViewController {
    var arrayVerbe: [[String]] = []
    var listeVerbes = [String]()
    var arraySelection: [String] = []
    var verbeInfinitif: [String] = []
    var refIndexPath = [IndexPath]()
    var selectedTimeVerbes = NSMutableSet()
    var arr: NSMutableArray = []

    let sectionListe = ["INDICATIVO", "SUBJUNTIVO", "CONDICIONAL", "IMPERATIVO"]
    let item = [["Presente", "Imperfecto", "Pretérito", "Futuro", "Presente continuo", "Pretérito perfecto", "Pluscuamperfecto", "Futuro perfecto", "Pretérito anterior"], ["Presente ", "Imperfecto ", "Futuro ", "Pretérito perfecto ", "Pluscuamperfecto "], ["Condicional  ", "Perfecto  "], ["Positivo   ", "Negativo   "]]
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView //recast your view as a UITableViewHeaderFooterView
        header.contentView.backgroundColor = UIColor(red: 151/255, green: 156/255, blue: 159/255, alpha: 1.0) //make the background color light gay
        header.textLabel!.textColor = UIColor.white //make the text white
        header.alpha = 1.0 //make the header transparent
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        for array in arrayVerbe {
            if listeVerbes.contains(array[2]){
                
            }else{
                listeVerbes.append(array[2])
            }
        }
        self.title = "Escoja tiempos verbales"
    }


    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return sectionListe[section]
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return sectionListe.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return item[section].count
    }
    


    // Next code is to enable checks for each cell selected
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel!.text = self.item[indexPath.section][indexPath.row]
        cell.selectionStyle = .none
        configure(cell, forRowAtIndexPath: indexPath)
        return cell
    }
    func configure(_ cell: UITableViewCell, forRowAtIndexPath indexPath: IndexPath) {
        if selectedTimeVerbes.contains(indexPath) {
            // selected
            cell.accessoryType = .checkmark
        }
        else {
            // not selected
            cell.accessoryType = .none
        }
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if selectedTimeVerbes.contains(indexPath) {
            // deselect
            selectedTimeVerbes.remove(indexPath)
            let cell2 = tableView.cellForRow(at: indexPath)!
            if let text = cell2.textLabel?.text, let n = arraySelection.index(of: text){
                arraySelection.remove(at: n)
            }
            
        }
        else {
            // select
            selectedTimeVerbes.add(indexPath)
            arraySelection.append(self.item[indexPath.section][indexPath.row])
        }
        let cell = tableView.cellForRow(at: indexPath)!
        configure(cell, forRowAtIndexPath: indexPath)
        
    }
    

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showQuestionFinal"{
            verbeInfinitif = ["Tous les verbes"]
            let backItem = UIBarButtonItem()
            backItem.title = ""
            navigationItem.backBarButtonItem = backItem
            let controller = segue.destination as! QuizController
            controller.arraySelection = arraySelection
            controller.arrayVerbe = arrayVerbe
            controller.verbeInfinitif = verbeInfinitif
            controller.listeVerbe = listeVerbes
        }
        if segue.identifier == "showSpecificVerb"{
            let backItem = UIBarButtonItem()
            backItem.title = ""
            navigationItem.backBarButtonItem = backItem
            let controller = segue.destination as! SpecificVerbViewController
            controller.arraySelection = arraySelection
            controller.arrayVerbe = arrayVerbe
        }
    }
    func showAlert () {
        let alertController = UIAlertController(title: "Elija por lo menos un tiempo verbal", message: nil, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Listo", style: UIAlertActionStyle.default, handler: nil))

        
        present(alertController, animated: true, completion: nil)
    }
    func dismissAlert(_ sender: UIAlertAction) {
        
    }
    func showAlert4 () {
        let alert = UIAlertController(title: "Verbos Españoles Quiz", message: "Elige una opción", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Todos los verbos", style: UIAlertActionStyle.default, handler: {(alert: UIAlertAction!) in self.tousLesverbesAction()}))
        alert.addAction(UIAlertAction(title: "Elige los verbos", style: UIAlertActionStyle.default, handler: {(alert: UIAlertAction!) in self.specifierUnVerbe()}))
        
        self.present(alert, animated: true, completion: nil)
    }
    func tousLesverbesAction() {
        performSegue(withIdentifier: "showQuestionFinal", sender: UIBarButtonItem.self)
    }
    func specifierUnVerbe() {
        performSegue(withIdentifier: "showSpecificVerb", sender: UIBarButtonItem.self)
        
    }

    @IBAction func OK(_ sender: UIBarButtonItem) {
        var i = 0
        i = arraySelection.count
        if i == 0{
            showAlert()
        }else{
            showAlert4()
        }

    }

}

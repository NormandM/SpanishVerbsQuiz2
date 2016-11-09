//
//  quizTableViewController.swift
//  Spanish Verbs Quiz
//
//  Created by Normand Martin on 16-07-04.
//  Copyright © 2016 Normand Martin. All rights reserved.
//

import UIKit

class quizTableViewController: UITableViewController {
    var arraySelection: [String] = []
    var refIndexPath = [IndexPath]()
    var selectedTimeVerbes = NSMutableSet()
    var arr: NSMutableArray = []
    var arrayVerbe: NSArray = []
    
    let sectionListe = ["INDICATIVO", "SUBJUNTIVO", "CONDICIONAL", "IMPERATIVO"]
    let item = [["Presente ", "Imperfecto ", "Pretérito ", "Futuro ", "Presente Continuo ", "Pretérito perfecto ", "Pluscuamperfecto ", "Futuro perfecto ", "Pretérito anterior "], ["Presente", "Imperfecto", "Futuro", "Pretérito perfecto", "Pluscuamperfecto"], ["Condicional", "Perfecto"], ["Positivo", "Negativo"]]
    
    // Changing backgroung colors of the header of sections
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView //recast your view as a UITableViewHeaderFooterView
        header.contentView.backgroundColor = UIColor(red: 151/255, green: 156/255, blue: 159/255, alpha: 1.0) //make the background color light blue
        header.textLabel!.textColor = UIColor.white //make the text white
        header.alpha = 1.0 //make the header transparent
        
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
      
        return item[section].count
    }
    

// Next code is to enable checks for each cell selected
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "verbCell", for: indexPath)
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

    @IBAction func listo(_ sender: UIBarButtonItem) {

// Making sure at least one time verb is selected if not a modal View appears.
        var i = 0
        i = arraySelection.count
        if i == 0{
            performSegue(withIdentifier: "alerteChoixTemps", sender: UIBarButtonItem.self)
        }else{
            performSegue(withIdentifier: "showQuestionFinal", sender: UIBarButtonItem.self)
        }
    }

 

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "showQuestionFinal"{
            
           
            let backItem = UIBarButtonItem()
            backItem.title = ""
            navigationItem.backBarButtonItem = backItem
           
            let controller = segue.destination as! QuestionFinaleViewController
            controller.infoQuiz = arraySelection
            controller.arrayVerbe = arrayVerbe
            
       }
    }
    
}

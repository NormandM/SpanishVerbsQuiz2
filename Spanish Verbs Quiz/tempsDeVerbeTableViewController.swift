//
//  tempsDeVerbeTableViewController.swift
//  Spanish Verbs Quiz
//
//  Created by Normand Martin on 16-06-23.
//  Copyright © 2016 Normand Martin. All rights reserved.
//

import UIKit

class tempsDeVerbeTableViewController: UITableViewController {
    
    var verbeInfinitif: String = ""
    var nomSection: String = ""
    var leTemps: String = ""
    var verbeTotal = ["", "", ""]
    
    let sectionListe = ["INDICATIVO", "SUBJUNTIVO", "CONDICIONAL", "IMPERATIVO"]
    let item = [["Presente", "Imperfecto", "Pretérito", "Futuro", "Presente progresivo", "Pretérito perfecto", "Pluscuamperfecto", "Futuro perfecto", "Pretérito anterior"], ["Presente", "Imperfecto", "Futuro", "Pretérito perfecto", "Pluscuamperfecto"], ["Condicional", "Perfecto"], ["Presente"]]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
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
        let cell = tableView.dequeueReusableCellWithIdentifier("verbCell2", forIndexPath: indexPath)

        cell.textLabel!.text = self.item[indexPath.section][indexPath.row]
        return cell
        
    }
 


    // MARK: - Navigation


    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showLeVerbeFinal"{
            if let indexPath = self.tableView.indexPathForSelectedRow {
                leTemps = item[indexPath.section][indexPath.row]
                if item[indexPath.section].count == 9{
                    nomSection = "Indicativo"
                }else if item[indexPath.section].count == 5 {
                    nomSection = "Subjuntivo"
                }else if item[indexPath.section].count == 2{
                    nomSection = "Condicional"
                }else if item[indexPath.section].count == 1{
                    nomSection = "Imperativo"
                }
                verbeTotal = [verbeInfinitif, nomSection, leTemps ]
                let controller = segue.destinationViewController as! VerbeFinalTableViewController
                controller.selectionVerbe = verbeTotal
        
                
            }
            
            
        }
        
    }


}

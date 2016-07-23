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
    var refIndexPath = [NSIndexPath]()
     var selectedTimeVerbes = NSMutableSet()
    
    
    let sectionListe = ["INDICATIVO", "SUBJUNTIVO", "CONDICIONAL", "IMPERATIVO"]
    let item = [["Presente ", "Imperfecto ", "Pretérito ", "Futuro ", "Presente progresivo ", "Pretérito perfecto ", "Pluscuamperfecto ", "Futuro perfecto ", "Pretérito anterior "], ["Presente", "Imperfecto", "Futuro", "Pretérito perfecto", "Pluscuamperfecto"], ["Condicional", "Perfecto"], ["Positivo", "Negativo"]]
    
    // Changing backgroung colors of the header of sections
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView //recast your view as a UITableViewHeaderFooterView
        header.contentView.backgroundColor = UIColor(red: 151/255, green: 156/255, blue: 159/255, alpha: 1.0) //make the background color light blue
        header.textLabel!.textColor = UIColor.whiteColor() //make the text white
        header.alpha = 1.0 //make the header transparent
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
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
        let cell = tableView.dequeueReusableCellWithIdentifier("verbCell", forIndexPath: indexPath)
 
        
        cell.textLabel!.text = self.item[indexPath.section][indexPath.row]
        
        cell.selectionStyle = .None
       configure(cell, forRowAtIndexPath: indexPath)
        return cell
    }
    func configure(cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if selectedTimeVerbes.containsObject(indexPath) {
            // selected
            cell.accessoryType = .Checkmark
            arraySelection.append(self.item[indexPath.section][indexPath.row])
        }
        else {
            // not selected
            cell.accessoryType = .None
            if let text = cell.textLabel?.text, n = arraySelection.indexOf(text){
                arraySelection.removeAtIndex(n)
            }
        }
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)

        if selectedTimeVerbes.containsObject(indexPath) {
            // deselect
            selectedTimeVerbes.removeObject(indexPath)
        }
        else {
            // select
            selectedTimeVerbes.addObject(indexPath)
        }
        let cell = tableView.cellForRowAtIndexPath(indexPath)!
        configure(cell, forRowAtIndexPath: indexPath)
    }
        


    
    // MARK: - Navigation

    @IBAction func listo(sender: UIBarButtonItem) {
        var i = 0
        i = arraySelection.count
        
        if i == 0{
            
            performSegueWithIdentifier("alerteChoixTemps", sender: UIBarButtonItem.self)
        }else{
            
            performSegueWithIdentifier("showQuestionFinal", sender: UIBarButtonItem.self)
        }

        
    }

 

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if segue.identifier == "showQuestionFinal"{
            let controller = segue.destinationViewController as! QuestionFinaleViewController
            print(arraySelection)
            controller.infoQuiz = arraySelection

       }
    }
    
}
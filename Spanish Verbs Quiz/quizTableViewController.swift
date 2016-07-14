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
    var result = Alternate()
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
        return cell
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        if cell?.accessoryType == .Checkmark{
            cell?.accessoryType = .None
            let n = arraySelection.indexOf((cell!.textLabel!.text)!)
            arraySelection.removeAtIndex(n!)
        }else{
            cell?.accessoryType = .Checkmark
            arraySelection.append(self.item[indexPath.section][indexPath.row])
        }

        
        print(arraySelection)
        
    }

    
    // MARK: - Navigation

    @IBAction func quizSelectionButton(sender: UIBarButtonItem) {
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
            controller.infoQuiz = arraySelection

       }
    }
    
}

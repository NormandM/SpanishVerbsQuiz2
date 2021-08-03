//
//  QuizOptionsController.swift
//  French Verbs Quiz
//
//  Created by Normand Martin on 2016-12-04.
//  Copyright © 2016 Normand Martin. All rights reserved.
//

import UIKit
import CoreData
class QuizOptionsController: UITableViewController {
    let modeAndTemp = ModeAndTemp()
    var arrayVerb = [[String]]()
    lazy var modes = modeAndTemp.mode
    lazy var temps = modeAndTemp.temp
    var selectedTimeVerbes = NSMutableSet()
    var arraySelectionTempsEtMode = [[String]]()
    var verbInfinitif = [String]()
    let fontsAndConstraints = FontsAndConstraintsOptions()
    let dataController = DataController.sharedInstance
    let managedObjectContext = DataController.sharedInstance.managedObjectContext
    lazy var fetchRequest: NSFetchRequest<NSFetchRequestResult> = {
        let request  = NSFetchRequest<NSFetchRequestResult>(entityName: ItemVerbe.identifier)
        return request
    }()
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView //recast your view as a UITableViewHeaderFooterView
        header.contentView.backgroundColor = UIColor(red: 178/255, green: 208/255, blue: 198/255, alpha: 1.0)
        header.textLabel!.textColor = UIColor.white //make the text white
        header.textLabel?.font = fontsAndConstraints.normalBoldFont
        header.alpha = 1.0 //make the header transparent
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.title = "Escoja tiempos verbales".localized
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return modes[section]
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return modes.count
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return temps[section].count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel!.text = temps[indexPath.section][indexPath.row]
        cell.selectionStyle = .none
        cell.textLabel?.textColor = UIColor.black
        cell.textLabel?.font =  fontsAndConstraints.normalItaliqueBoldFont
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
            var textArray = [String]()
            if let text = cell2.textLabel?.text{
                textArray = [text, modes[indexPath.section]]
            }
            if let n = arraySelectionTempsEtMode.firstIndex(of: textArray){
                arraySelectionTempsEtMode.remove(at: n)
            }
        }
        else {
            // select
            selectedTimeVerbes.add(indexPath)
            arraySelectionTempsEtMode.append([temps[indexPath.section][indexPath.row], modes[indexPath.section]])
        }
        let cell = tableView.cellForRow(at: indexPath)!
        configure(cell, forRowAtIndexPath: indexPath)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showQuizController"{
            verbInfinitif = ["Tous les verbes"]
            let backItem = UIBarButtonItem()
            backItem.title = ""
            navigationItem.backBarButtonItem = backItem
            navigationItem.backBarButtonItem?.tintColor = UIColor(red: 27/255, green: 96/255, blue: 94/255, alpha: 1.0)
            let controller = segue.destination as! QuizController
            controller.arrayVerb = arrayVerb
            controller.arraySelectionTempsEtMode = arraySelectionTempsEtMode
            controller.verbInfinitif = verbInfinitif
            
        }
        if segue.identifier == "showSpecificVerb"{
            let backItem = UIBarButtonItem()
            backItem.title = ""
            navigationItem.backBarButtonItem = backItem
            navigationItem.backBarButtonItem?.tintColor = UIColor(red: 27/255, green: 96/255, blue: 94/255, alpha: 1.0)
            let controller = segue.destination as! SpecificVerbViewController
            controller.arraySelectionTempsEtMode = arraySelectionTempsEtMode
            controller.arrayVerb = arrayVerb
        }
    }
    func showAlertNoVerbChosen () {
        let alertController = UIAlertController(title: "Elija por lo menos un tiempo verbal".localized, message: nil, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Listo".localized, style: UIAlertAction.Style.default, handler: nil))

        
        present(alertController, animated: true, completion: nil)
    }
    func dismissAlert(_ sender: UIAlertAction) {
        
    }
    func showAlertChoisirOption () {
        let alert = UIAlertController(title: "Verbos Españoles Quiz".localized, message: "Elige una opción".localized, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Todos los verbos".localized, style: UIAlertAction.Style.default, handler: {(alert: UIAlertAction!) in self.tousLesverbesAction()}))
        alert.addAction(UIAlertAction(title: "Elige los verbos".localized, style: UIAlertAction.Style.default, handler: {(alert: UIAlertAction!) in self.specifierUnVerbe()}))
        
        self.present(alert, animated: true, completion: nil)
    }
    func tousLesverbesAction() {
        performSegue(withIdentifier: "showQuizController", sender: UIBarButtonItem.self)
    }
    func specifierUnVerbe() {
        performSegue(withIdentifier: "showSpecificVerb", sender: UIBarButtonItem.self)
        
    }

    @IBAction func listoButtonPressed(_ sender: UIBarButtonItem) {
        let i = arraySelectionTempsEtMode.count
        if i == 0{
            showAlertNoVerbChosen ()
        }else{
            showAlertChoisirOption ()
        }
    }
    
}

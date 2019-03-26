//
//  tempsDeVerbeTableViewController.swift
//  French Verbs Quiz
//
//  Created by Normand Martin on 2016-12-02.
//  Copyright © 2016 Normand Martin. All rights reserved.
//

import UIKit

class tempsDeVerbeTableViewController: UITableViewController {
    let modeAndTemp = ModeAndTemp()
    lazy var modes = modeAndTemp.mode
    lazy var temps = modeAndTemp.temp
    var verbInfinitif: String = ""
    var arrayVerbe: [[String]] = []
    let fontsAndConstraints = FontsAndConstraintsOptions()
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView //recast your view as a UITableViewHeaderFooterView
        header.contentView.backgroundColor = UIColor(red: 178/255, green: 208/255, blue: 198/255, alpha: 1.0)
        header.textLabel!.textColor = UIColor.white //make the text white
        header.alpha = 1.0 //make the header transparent
        header.textLabel?.font = fontsAndConstraints.normalBoldFont
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Escoja el tiempo verbal"
     }
    override func viewWillAppear(_ animated: Bool) {
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
    }
    // MARK: - Table view data source
    
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
        cell.textLabel?.textColor = UIColor.black
        cell.textLabel?.font =  fontsAndConstraints.normalItaliqueBoldFont
        return cell
     }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showLeVerbeFinal"{
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let backItem = UIBarButtonItem()
                backItem.title = ""
                navigationItem.backBarButtonItem = backItem
                navigationItem.backBarButtonItem?.tintColor = UIColor(red: 27/255, green: 96/255, blue: 94/255, alpha: 1.0)
                let temp = temps[indexPath.section][indexPath.row]
                let mode = modes[indexPath.section]
                let controller = segue.destination as! FinalVerbeViewController
                controller.verbInfinitif = verbInfinitif
                controller.modeVerb = mode
                controller.temp = temp
            }
        }
    }

}

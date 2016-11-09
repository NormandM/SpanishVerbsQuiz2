//
//  verbListViewController.swift
//  Spanish Verbs Quiz
//
//  Created by Normand Martin on 16-06-23.
//  Copyright © 2016 Normand Martin. All rights reserved.
//

import UIKit
var randomVerb: Int = 0
var listeVerbe: [String] = []
class verbListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var searchActive : Bool = false
    var filtered:[String] = []
    var arrayVerbe: NSArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        let i = arrayVerbe.count
        while randomVerb < i {
            let allVerbs = VerbeEspagnol(verbArray: arrayVerbe, n: randomVerb)
            listeVerbe.append(allVerbs.verbo)
            randomVerb = randomVerb + 21
        }
        func alpha (_ s1: String, s2: String) -> Bool {
            return s1 < s2
        }
        listeVerbe = listeVerbe.sorted(by: alpha)
    }
  // Setting up the searchBar active: Ttrue/False
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    //Filtering with search text
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filtered = listeVerbe.filter({ (text) -> Bool in
            let tmp: NSString = text as NSString
            let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            return range.location != NSNotFound
        })
        if(filtered.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.tableView.reloadData()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive) {
            return filtered.count
        }
        return listeVerbe.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")! as UITableViewCell;
        if(searchActive){
            cell.textLabel?.text = filtered[indexPath.row]
        } else {
            cell.textLabel?.text = listeVerbe[indexPath.row];
        }
        
        return cell;
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTempsVerbe"{
            if let indexPath = self.tableView.indexPathForSelectedRow, let verbeChoisi = tableView.cellForRow(at: indexPath)?.textLabel?.text {
                    let backItem = UIBarButtonItem()
                    backItem.title = ""
                    navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
                let controller = segue.destination as! tempsDeVerbeTableViewController
                controller.verbeInfinitif = verbeChoisi
                controller.arrayVerbe = arrayVerbe
               
            }
        }
    }
}

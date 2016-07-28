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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self

        if let plistPath = NSBundle.mainBundle().pathForResource("arr5", ofType: "plist"),
            verbArray = NSArray(contentsOfFile: plistPath){
            let i = verbArray.count
            while randomVerb < i {
                let allVerbs = VerbeEspagnol(verbArray: verbArray, n: randomVerb)
                listeVerbe.append(allVerbs.verbo)
                randomVerb = randomVerb + 21
            }
        }
        func alpha (s1: String, s2: String) -> Bool {
            return s1 < s2
        }
        listeVerbe = listeVerbe.sort(alpha)
        
    }
  // Setting up the searchBar active: Ttrue/False
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    //Filtering with search text
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        filtered = listeVerbe.filter({ (text) -> Bool in
            let tmp: NSString = text
            let range = tmp.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
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
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive) {
            return filtered.count
        }
        return listeVerbe.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")! as UITableViewCell;
        if(searchActive){
            cell.textLabel?.text = filtered[indexPath.row]
        } else {
            cell.textLabel?.text = listeVerbe[indexPath.row];
        }
        
        return cell;
    }

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showTempsVerbe"{
            if let indexPath = self.tableView.indexPathForSelectedRow, let verbeChoisi = tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text {
                //let verbeChoisi = listeVerbe[indexPath.row]
                let controller = segue.destinationViewController as! tempsDeVerbeTableViewController
                controller.verbeInfinitif = verbeChoisi
               
            }
        }
    }
}

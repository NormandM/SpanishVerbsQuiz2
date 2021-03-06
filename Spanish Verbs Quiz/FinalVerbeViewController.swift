//
//  FinalVerbeViewController.swift
//  French Verbs Quiz
//
//  Created by Normand Martin on 2016-12-03.
//  Copyright © 2016 Normand Martin. All rights reserved.
//

import UIKit

class FinalVerbeViewController: UIViewController {
    var arrayVerbe: [[String]] = []
    var selectionVerbe = ["", "", ""]
    var noItem: Int = 0
    
    @IBOutlet weak var infinitif: UILabel!
    @IBOutlet weak var mode: UILabel!
    @IBOutlet weak var temps: UILabel!
    @IBOutlet weak var premier: UILabel!
    @IBOutlet weak var deuxieme: UILabel!
    @IBOutlet weak var troisieme: UILabel!
    @IBOutlet weak var quatrieme: UILabel!
    @IBOutlet weak var cinquieme: UILabel!
    @IBOutlet weak var sixieme: UILabel!
    @IBOutlet weak var first: UILabel!
    @IBOutlet weak var second: UILabel!
    @IBOutlet weak var third: UILabel!
    @IBOutlet weak var fourth: UILabel!
    @IBOutlet weak var fifth: UILabel!
    @IBOutlet weak var sixth: UILabel!
    @IBOutlet weak var otraForma: UIButton!
    
    @IBOutlet weak var masterConstraint: NSLayoutConstraint!
    let screenSize: CGRect = UIScreen.main.bounds
    var counter: Int = 0
    var buttonPressed: Bool = false
    let helper = Helper()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Verbo conjugado"
        masterConstraint.constant = 0.08 * screenSize.height
        counter = 0
        for verb in arrayVerbe{
            if verb[0] == selectionVerbe[1] && verb[1] == selectionVerbe[2] && verb[2] == selectionVerbe[0]{
                noItem = counter
                break
            }
            counter = counter + 1
        }
        let verbeItalien = VerbeItalien(verbArray: arrayVerbe, n: noItem)
        infinitif.text = helper.capitalize(word: verbeItalien.verbe)
        mode.text = helper.capitalize(word: verbeItalien.mode)
        temps.text = helper.capitalize(word: verbeItalien.temps)
        premier.text = verbeItalien.premier
        deuxieme.text = verbeItalien.deuxieme
        troisieme.text = verbeItalien.troisieme
        quatrieme.text = verbeItalien.quatrieme
        cinquieme.text = verbeItalien.cinquieme
        sixieme.text = verbeItalien.sixieme
        let personneVerbe = Personne(verbArray: verbeItalien)
        if verbeItalien.verbe == "bisognare" {
            first.text = "   "
            second.text = "  "
            third.text = personneVerbe.third
            fourth.text = "  "
            fifth.text = "  "
            sixth.text = "  "
        }else{
            first.text = personneVerbe.first
            second.text = personneVerbe.second
            third.text = personneVerbe.third
            fourth.text = personneVerbe.fourth
            fifth.text = personneVerbe.fifth
            sixth.text = personneVerbe.sixth
            
        }

        if mode.text != "Subjuntivo" || (temps.text != "Imperfecto" && temps.text != "Pluscuamperfecto") {
            otraForma.tintColor = UIColor.clear
            otraForma.isUserInteractionEnabled = false
        }else if temps.text == "Imperfecto"{
            otraForma.setTitle("Ver otra forma del Subjuntivo Imperfecto", for: .normal)
        }else if temps.text == "Pluscuamperfecto" {
            otraForma.setTitle("Ver otra forma del Subjuntivo Pluscuamperfecto", for: .normal)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func otraFormaVerbo(_ sender: UIButton) {
        
        if (mode.text == "Subjuntivo" && (temps.text != "Imperfecto" || temps.text != "Pluscuamperfecto")) && buttonPressed == false  {
            noItem = noItem + 1
            buttonPressed = true
            
        }else{
            noItem = noItem - 1
            buttonPressed = false
        }
        let verbeItalien = VerbeItalien(verbArray: arrayVerbe, n: noItem)
        infinitif.text = helper.capitalize(word: verbeItalien.verbe)
        mode.text = helper.capitalize(word: verbeItalien.mode)
        temps.text = helper.capitalize(word: verbeItalien.temps)
        premier.text = verbeItalien.premier
        deuxieme.text = verbeItalien.deuxieme
        troisieme.text = verbeItalien.troisieme
        quatrieme.text = verbeItalien.quatrieme
        cinquieme.text = verbeItalien.cinquieme
        sixieme.text = verbeItalien.sixieme
    }

}

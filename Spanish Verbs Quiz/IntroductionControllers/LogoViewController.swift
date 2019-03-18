//
//  LogoViewController.swift
//  Spanish Verbs Quiz
//
//  Created by Normand Martin on 17-11-13.
//  Copyright © 2017 Normand Martin. All rights reserved.
//

import UIKit
import AudioToolbox

class LogoViewController: UIViewController {
    @IBOutlet weak var logoView: UIImageView!
    
    @IBOutlet weak var appsLabel: UILabel!
    @IBOutlet weak var appsLabel2: UILabel!
    var soundURL: NSURL?
    var soundID:SystemSoundID = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        let appsLabelFrame  = appsLabel.frame
        let appsLabel2Frame = appsLabel2.frame
        let maxXappsLabel = appsLabelFrame.maxX
        let maxXappsLabel2 = appsLabel2Frame.maxX
        let filePath = Bundle.main.path(forResource: "Acoustic Trio", ofType: "wav")
        
        soundURL = NSURL(fileURLWithPath: filePath!)
        AudioServicesCreateSystemSoundID(soundURL!, &soundID)
        AudioServicesPlaySystemSound(soundID)
        UIView.animate(withDuration: 3, animations: {
            self.appsLabel2.transform = CGAffineTransform(translationX: maxXappsLabel - maxXappsLabel2 , y: 0)}, completion: {finished in self.completionAnimation()})
        
    }
    func completionAnimation() {
        let when = DispatchTime.now() + 0.5
        DispatchQueue.main.asyncAfter(deadline: when + 1) {
            self.performSegue(withIdentifier: "showOption", sender: (Any).self)
        }
        
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showOption"{
            
            
        }
    }
    
}

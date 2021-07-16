//
//  MenuViewController.swift
//  HoopsQuiz
//
//  Created by Nipun Singh on 12/10/20.
//

import UIKit
import GameKit

class MenuViewController: UIViewController, GKGameCenterControllerDelegate {
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        print("Done")
        dismiss(animated: true, completion: nil)
    }
    

    let defaults = UserDefaults.standard
    var isHardMode = false
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var hardModeButton: UIButton!
    @IBOutlet weak var leaderboardsButton: UIButton!
    @IBOutlet weak var recordBookButton: UIButton!
    
    var totalMakes: Int {
        if let makes = defaults.object(forKey: "TotalMakes") as? Int {
            return makes
        } else {
            return 0
        }
    }

    var totalMisses: Int {
        if let misses = defaults.object(forKey: "TotalMisses") as? Int{
            return misses
        } else {
            return 0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playButton.layer.cornerRadius = 10
        hardModeButton.layer.cornerRadius = 7

        
        leaderboardsButton.layer.cornerRadius = 10
        leaderboardsButton.layer.borderWidth = 1
        leaderboardsButton.layer.borderColor = UIColor.systemOrange.cgColor

        recordBookButton.layer.cornerRadius = 10
        recordBookButton.layer.borderWidth = 1
        recordBookButton.layer.borderColor = UIColor.systemOrange.cgColor
        
        setUpGameCenter()
        
    }
    
    @IBAction func playPressed(_ sender: Any) {
        isHardMode = false
        performSegue(withIdentifier: "startGameSegue", sender: self)
    }
    
    @IBAction func hardModePressed(_ sender: Any) {
        isHardMode = true
        performSegue(withIdentifier: "startGameSegue", sender: self)
    }
    
    @IBAction func leaderboardsPressed(_ sender: Any) {
        let vc = GKGameCenterViewController(leaderboardID: "com.HoopsQuiz.careerHigh", playerScope: .global, timeScope: .allTime)
        vc.gameCenterDelegate = self
        present(vc, animated: true, completion: nil)
        
    }
    @IBAction func recordButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "goToRecordsSegue", sender: self)
    }

    
    func setUpGameCenter() {
        GKLocalPlayer.local.authenticateHandler = {[weak self] (gameCenterViewController, error) -> Void in
            if error != nil {
                print(error ?? "Error?")
            } else if gameCenterViewController != nil {
                self?.present(gameCenterViewController!, animated: true, completion: nil)
            } else if (GKLocalPlayer.local.isAuthenticated ) {
                //load game center
            } else {
                //User doesnt have game center
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "startGameSegue" {
                let vc = segue.destination as! GameViewController
                vc.isHardMode = isHardMode
        }
    }
}

//
//  ReportViewController.swift
//  HoopsQuiz
//
//  Created by Nipun Singh on 12/10/20.
//

import UIKit
import GameKit

class TitleTableViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
}

class ButtonTableViewCell: UITableViewCell {
    @IBOutlet weak var buttonName: UILabel!
}

class ReportViewController: UITableViewController {

    @IBOutlet weak var makesLabel: UILabel!
    @IBOutlet weak var makesPointsLabel: UILabel!
    @IBOutlet weak var missesLabel: UILabel!
    @IBOutlet weak var missesPointsLabel: UILabel!
    @IBOutlet weak var finalPointsLabel: UILabel!
    
    @IBOutlet weak var hitCareerHighCell: UITableViewCell!
    @IBOutlet weak var previousRecordLabel: UILabel!
    @IBOutlet weak var previousRecordPointsLabel: UILabel!
    @IBOutlet weak var careerHighLabel: UILabel!
        
    var makesAmount: Int = 0
    var missesAmount: Int = 0
    var finalPointsAmount: Int = 0
    var didGetCareerHigh: Bool = false
    var previousHigh: Int = 0
    var guessedPlayers: [GuessedPlayer]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if didGetCareerHigh {
            updateScore()
        }
    }

    func updateScore() {
        GKLeaderboard.submitScore(finalPointsAmount, context: 0, player: GKLocalPlayer.local, leaderboardIDs: ["com.HoopsQuiz.careerHigh"]) { (error) in
            if error != nil {
                print("Error saving score: \(error!)")
            } else {
                print("Updated career high in game center to \(self.finalPointsAmount).")
            }
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return ""
        case 1:
            return "Stat Sheet"
        case 2:
            return "Records"
        case 3:
            return ""
        case 4:
            return "Post Game Report - \(guessedPlayers?.count ?? 0) players"
        default:
            return ""
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 3
        case 2:
            return didGetCareerHigh ? 2 : 1
        case 3:
            return 2
        case 4:
            return guessedPlayers?.count ?? 0
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch (indexPath.section) {
        case 0:
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "titleCell", for: indexPath) as! TitleTableViewCell
            cell.imageView?.image = nil
            cell.title.text = "Game Over"
            return cell
            
        case 1:
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "statCell", for: indexPath)
            cell.imageView?.image = nil

            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "\(makesAmount) Makes"
                cell.detailTextLabel?.text = "+\(makesAmount * 100) points"
                cell.detailTextLabel?.textColor = UIColor.green
                
            case 1:
                cell.textLabel?.text = "\(missesAmount) Misses"
                cell.detailTextLabel?.text = "-\(missesAmount * 20) points"
                cell.detailTextLabel?.textColor = UIColor.red
            default:
                cell.textLabel?.text = "Final Score"
                cell.textLabel?.font = .boldSystemFont(ofSize: 20)
                cell.detailTextLabel?.text = "\(finalPointsAmount) points"
                cell.detailTextLabel?.font = .boldSystemFont(ofSize: 20)

            }
            return cell
            
        case 2:

            if didGetCareerHigh {
                switch indexPath.row {
                case 0:
                    let cell = self.tableView.dequeueReusableCell(withIdentifier: "titleCell", for: indexPath) as! TitleTableViewCell
                    cell.imageView?.image = nil

                    cell.title.text = "You hit a new career high!"
                    cell.title?.font = .boldSystemFont(ofSize: 24)
                    cell.backgroundColor = .secondarySystemBackground
                    return cell
                default:
                    let cell = self.tableView.dequeueReusableCell(withIdentifier: "statCell", for: indexPath)
                    cell.imageView?.image = nil

                    cell.textLabel?.text = "Previous Career High"
                    cell.detailTextLabel?.text = "\(previousHigh) points"
                    return cell
                }
              
            } else {
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "statCell", for: indexPath)
                cell.imageView?.image = nil

                cell.textLabel?.text = "Career High"
                cell.detailTextLabel?.text = "\(previousHigh) points"
                return cell
            }
            
        case 3:
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "buttonCell", for: indexPath) as! ButtonTableViewCell
            cell.imageView?.image = nil
            switch indexPath.row {
            case 0:
                cell.buttonName.text = "Play Again"
                cell.buttonName.font = .boldSystemFont(ofSize: 20)
                return cell
            default:
                cell.buttonName.text = "Main Menu"
                return cell
            }
        default:
            
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath)
            cell.imageView?.image = nil

            let player = guessedPlayers?[indexPath.row]
            cell.imageView?.image = UIImage(named: player?.team ?? "Basketball")
            cell.textLabel?.text = "\(indexPath.row + 1). \(player?.name ?? "")"
            cell.detailTextLabel?.text = player?.result

            switch player?.result {
            case "✓":
                cell.detailTextLabel?.textColor = UIColor.green
            case "X":
                cell.detailTextLabel?.textColor = UIColor.red
            default:
                cell.detailTextLabel?.textColor = UIColor.label
            }

            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sectionRow = "\(indexPath.section),\(indexPath.row)"
        switch sectionRow {
        case "3,0":
            self.presentingViewController?.dismiss(animated: true, completion: nil)
        case "3,1":
            self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        default:
            print("tapped \(sectionRow)")
        }
    }
    
    
    
    
}

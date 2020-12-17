//
//  ReportViewController.swift
//  HoopsQuiz
//
//  Created by Nipun Singh on 12/10/20.
//

import UIKit

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

       // setUpTable()
    }
    
    @IBAction func playAgainPressed(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backToMenuPressed(_ sender: Any) {
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
//    func setUpTable() {
//        makesLabel.text = "Makes x\(makesAmount)"
//        makesPointsLabel.text = "+\(makesAmount * 100)"
//
//        missesLabel.text = "Misses x\(missesAmount)"
//        missesPointsLabel.text = "-\(missesAmount * 20)"
//
//        finalPointsLabel.text = "\(finalPointsAmount)"
//
//        if didGetCareerHigh {
//            previousRecordLabel.text = "Previous Career High"
//            careerHighLabel.text = "You hit a new career high!"
//        } else {
//            let makesNeeded = Int(((Float(previousHigh) - Float(finalPointsAmount)) / 100).rounded(.up))
//            careerHighLabel.text = "\(makesNeeded) makes from a career high."
//        }
//        previousRecordPointsLabel.text = "\(previousHigh)"
//
//    }
    
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
            cell.title.text = "Game Over"
            return cell
            
        case 1:
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath)
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "Makes x\(makesAmount)"
                cell.detailTextLabel?.text = "+\(makesAmount * 100)"
                cell.detailTextLabel?.textColor = UIColor.green
            case 1:
                cell.textLabel?.text = "Misses x\(missesAmount)"
                cell.detailTextLabel?.text = "+\(missesAmount * 20)"
                cell.detailTextLabel?.textColor = UIColor.red
            default:
                cell.textLabel?.text = "Final Score"
                cell.textLabel?.font = .boldSystemFont(ofSize: 20)
                cell.detailTextLabel?.text = "\(finalPointsAmount)"
                cell.detailTextLabel?.font = .boldSystemFont(ofSize: 20)

            }
            return cell
            
        case 2:
          
            if didGetCareerHigh {
                switch indexPath.row {
                case 0:
                    let cell = self.tableView.dequeueReusableCell(withIdentifier: "titleCell", for: indexPath)
                    cell.textLabel?.text = "You hit a new career high!"
                    cell.textLabel?.font = .boldSystemFont(ofSize: 20)
                    return cell
                default:
                    let cell = self.tableView.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath)
                    cell.textLabel?.text = "Previous Career High"
                    cell.detailTextLabel?.text = "\(previousHigh)"
                    return cell
                }
              
            } else {
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath)
                cell.textLabel?.text = "Career High"
                cell.detailTextLabel?.text = "\(previousHigh)"
                return cell
            }
            
        case 3:
            switch indexPath.row {
            case 0:
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "buttonCell", for: indexPath) as! ButtonTableViewCell
                cell.buttonName.text = "Play Again"
                return cell
            default:
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "buttonCell", for: indexPath) as! ButtonTableViewCell
                cell.buttonName.text = "Main Menu"
                return cell
            }
        default:
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath)
            
            let player = guessedPlayers?[indexPath.row]
            cell.imageView?.image = UIImage(named: player?.team ?? "Basketball")
            cell.textLabel?.text = "\(indexPath.row + 1). \(player?.name ?? "")"
            cell.detailTextLabel?.text = player?.result
            cell.detailTextLabel?.font = .boldSystemFont(ofSize: 20)

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

//
//  RecordsViewController.swift
//  HoopsQuiz
//
//  Created by Nipun Singh on 12/20/20.
//

/*
 Acheivements:
 - Finish a game with over 20 makes and 0 misses.
 - Correctly guess 100/250/500 NBA Players
 - Play a full 82 game season
 - Have a >60 FG% with over 100 shots
 */

import UIKit

class RecordsViewController: UITableViewController {

    let defaults = UserDefaults.standard
    
    var totalMakes: Int {
        if let makes = defaults.object(forKey: "TotalMakes") as? Int {
            return makes
        } else {
            return 0
        }
    }

    var totalMisses: Int {
        if let makes = defaults.object(forKey: "TotalMisses") as? Int{
            return makes
        } else {
            return 0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "statCell", for: indexPath)
        cell.detailTextLabel?.font = .boldSystemFont(ofSize: 17)
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Career High"
            cell.detailTextLabel?.text = "\(defaults.object(forKey: "CareerHigh") ?? 0) points"
        case 1:
            cell.textLabel?.text = "Total Points"
            cell.detailTextLabel?.text = "\(defaults.object(forKey: "TotalPoints") ?? 0) points"
        case 2:
            cell.textLabel?.text = "Total Makes"
            cell.detailTextLabel?.text = "\(totalMakes) makes"
        case 3:
            cell.textLabel?.text = "Total Misses"
            cell.detailTextLabel?.text = "\(totalMisses) misses"
        case 4:
            cell.textLabel?.text = "Field Goal Percentage"
            if (totalMakes == 0 && totalMisses == 0) {
                cell.detailTextLabel?.text = "-%"//"\(Int(Float(totalMakes) / Float(totalMakes + totalMisses) * 100))%"
            } else {
                cell.detailTextLabel?.text = "\(Int(Float(totalMakes) / Float(totalMakes + totalMisses) * 100))%"
            }
        case 5:
            cell.textLabel?.text = "Games Played"
            cell.detailTextLabel?.text = "\(defaults.object(forKey: "GamesPlayed") ?? 0) games"
        case 6:
            let guessedPlayers = defaults.object(forKey: "GuessedPlayers") as? [String] ?? []
            cell.textLabel?.text = "Unique Players Guessed"
            cell.detailTextLabel?.text = "\(guessedPlayers.count) players"
        default:
            cell.textLabel?.text = ""
            cell.detailTextLabel?.text = ""
        }
        
        return cell
    }

}

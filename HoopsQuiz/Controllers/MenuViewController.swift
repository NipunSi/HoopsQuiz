//
//  MenuViewController.swift
//  HoopsQuiz
//
//  Created by Nipun Singh on 12/10/20.
//

import UIKit

class MenuViewController: UIViewController {

    let defaults = UserDefaults.standard
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var statsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        statsTableView.delegate = self
        statsTableView.dataSource = self
        
        playButton.layer.cornerRadius = 10
        playButton.layer.shadowColor = UIColor.gray.cgColor
        playButton.layer.shadowOpacity = 0.8
        playButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.statsTableView.reloadData()
        }
    }
    
    @IBAction func playPressed(_ sender: Any) {
        performSegue(withIdentifier: "startGameSegue", sender: self)
    }
}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Record Book"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "statCell", for: indexPath)
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Career High"
            cell.detailTextLabel?.text = "\(defaults.object(forKey: "CareerHigh") ?? 0)"
        case 1:
            cell.textLabel?.text = "Total Points"
            cell.detailTextLabel?.text = "\(defaults.object(forKey: "TotalPoints") ?? 0)"
        case 2:
            cell.textLabel?.text = "Total Makes"
            cell.detailTextLabel?.text = "\(defaults.object(forKey: "TotalMakes") ?? 0)"
        case 3:
            cell.textLabel?.text = "Total Misses"
            cell.detailTextLabel?.text = "\(defaults.object(forKey: "TotalMisses") ?? 0)"
        default:
            cell.textLabel?.text = "Games Played"
            cell.detailTextLabel?.text = "\(defaults.object(forKey: "GamesPlayed") ?? 0)"
        }
        
        return cell
    }
    
    
}

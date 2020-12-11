//
//  ReportViewController.swift
//  HoopsQuiz
//
//  Created by Nipun Singh on 12/10/20.
//

import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTable()
    }
    
    @IBAction func playAgainPressed(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backToMenuPressed(_ sender: Any) {
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    func setUpTable() {
        makesLabel.text = "Makes x\(makesAmount)"
        makesPointsLabel.text = "+\(makesAmount * 100)"
        
        missesLabel.text = "Misses x\(missesAmount)"
        missesPointsLabel.text = "-\(missesAmount * 20)"
        
        finalPointsLabel.text = "\(finalPointsAmount)"
        
        if didGetCareerHigh {
            previousRecordLabel.text = "Previous Career High"
            careerHighLabel.text = "You hit a new career high!"
        } else {
            let makesNeeded = Int(((Float(previousHigh) - Float(finalPointsAmount)) / 100).rounded(.up))
            careerHighLabel.text = "\(makesNeeded) makes from a career high."
        }
        previousRecordPointsLabel.text = "\(previousHigh)"
        
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 3
        case 2:
           return 2
        default:
            return 2
        }
    }
}

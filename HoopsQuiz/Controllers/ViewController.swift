//
//  ViewController.swift
//  HoopsQuiz
//
//  Created by Nipun Singh on 12/7/20.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    @IBOutlet weak var teamButtonsView: UIView!
    @IBOutlet weak var teamOneButton: UIButton!
    @IBOutlet weak var teamTwoButton: UIButton!
    @IBOutlet weak var teamThreeButton: UIButton!
    @IBOutlet weak var teamFourButton: UIButton!
    @IBOutlet weak var teamFiveButton: UIButton!
    @IBOutlet weak var teamSixButton: UIButton!
    
    let defaults = UserDefaults.standard
    
    var previousHigh: Int {
        if defaults.object(forKey: "CareerHigh") != nil {
            print("Previous Career High: \(defaults.object(forKey: "CareerHigh") ?? 1)")
            return defaults.object(forKey: "CareerHigh") as! Int
        } else {
            print("No Previous Career High")
            return 0
        }
    }
    let gameLength = 10
    
    let teams = Teams().teams
    var fetchedPlayers = [Player]()
    var shownPlayer: Player?
    var points = 0
    var makes = 0
    var misses = 0
    var secondsPassed = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        points = 0
        makes = 0
        misses = 0
        secondsPassed = 0
        
        pointsLabel.text = "Loading..."
        
        teamButtonsView.isHidden = true
        
        setUpUI()
        
        getPlayers()
    }
    
    @IBAction func skipButtonPressed(_ sender: Any) {
        transitionToPlayer()
    }
    
    @IBAction func teamButtonPressed(_ sender: UIButton) {
        let teamSelected = sender.title(for: .normal) ?? ""
        let correctTeam = shownPlayer?.teamName
        if teamSelected == correctTeam {
            print("Correct! \(shownPlayer?.firstName ?? "") \(shownPlayer?.lastName ?? "") is on the \(teamSelected).")
            
            points += 100
            makes += 1
            
            pointsLabel.textColor = UIColor.clear
            UIView.transition(with: pointsLabel, duration: 0.5, options: .transitionCrossDissolve) {
                self.pointsLabel.textColor = UIColor.green
            } completion: { _ in
                self.pointsLabel.textColor = UIColor.label
                self.pointsLabel.text = "\(self.points) Points"

            }
            
            UIButton.transition(with: sender, duration: 0.8, options: .transitionCrossDissolve) {
                sender.layer.borderColor = UIColor.green.cgColor
            } completion: { _ in
                self.transitionToPlayer()
            }
       
        } else {
            print("Incorrect! \(shownPlayer?.firstName ?? "") \(shownPlayer?.lastName ?? "") isn't on the \(teamSelected).")
            
            points -= 20
            misses += 1
            
            pointsLabel.textColor = UIColor.clear
            UIView.transition(with: pointsLabel, duration: 0.5, options: .transitionCrossDissolve) {
                self.pointsLabel.textColor = UIColor.red
            } completion: { _ in
                self.pointsLabel.textColor = UIColor.label
                self.pointsLabel.text = "\(self.points) Points"

            }
            
            UIButton.transition(with: sender, duration: 0.3, options: .transitionCrossDissolve, animations: {
                    sender.layer.borderColor = UIColor.red.cgColor
            }, completion: nil)
        }
    }
    
    func transitionToPlayer() {
   
            self.showPlayer()
            
            UIButton.transition(with: self.teamOneButton, duration: 0.3, options: .transitionFlipFromTop, animations: {
                self.teamOneButton.layer.borderColor = UIColor.clear.cgColor
            }, completion: nil)
            
            UIButton.transition(with: self.teamTwoButton, duration: 0.3, options: .transitionFlipFromTop, animations: {
                self.teamTwoButton.layer.borderColor = UIColor.clear.cgColor
            }, completion: nil)
            
            UIButton.transition(with: self.teamThreeButton, duration: 0.3, options: .transitionFlipFromTop, animations: {
                self.teamThreeButton.layer.borderColor = UIColor.clear.cgColor
            }, completion: nil)
            
            UIButton.transition(with: self.teamFourButton, duration: 0.3, options: .transitionFlipFromTop, animations: {
                self.teamFourButton.layer.borderColor = UIColor.clear.cgColor
            }, completion: nil)
            
            UIButton.transition(with: self.teamFiveButton, duration: 0.3, options: .transitionFlipFromTop, animations: {
                self.teamFiveButton.layer.borderColor = UIColor.clear.cgColor
            }, completion: nil)
            
            UIButton.transition(with: self.teamSixButton, duration: 0.3, options: .transitionFlipFromTop, animations: {
                self.teamSixButton.layer.borderColor = UIColor.clear.cgColor
            }, completion: nil)
    }
    
    func setUpUI() {
        teamOneButton.layer.cornerRadius = 20
        teamOneButton.layer.shadowColor = UIColor.gray.cgColor
        teamOneButton.layer.shadowOpacity = 0.8
        teamOneButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        teamOneButton.layer.borderWidth = 3
        teamOneButton.layer.borderColor = UIColor.clear.cgColor
        
        teamTwoButton.layer.cornerRadius = 20
        teamTwoButton.layer.shadowColor = UIColor.gray.cgColor
        teamTwoButton.layer.shadowOpacity = 0.8
        teamTwoButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        teamTwoButton.layer.borderWidth = 3
        teamTwoButton.layer.borderColor = UIColor.clear.cgColor
        
        teamThreeButton.layer.cornerRadius = 20
        teamThreeButton.layer.shadowColor = UIColor.gray.cgColor
        teamThreeButton.layer.shadowOpacity = 0.8
        teamThreeButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        teamThreeButton.layer.borderWidth = 3
        teamThreeButton.layer.borderColor = UIColor.clear.cgColor
        
        teamFourButton.layer.cornerRadius = 20
        teamFourButton.layer.shadowColor = UIColor.gray.cgColor
        teamFourButton.layer.shadowOpacity = 0.8
        teamFourButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        teamFourButton.layer.borderWidth = 3
        teamFourButton.layer.borderColor = UIColor.clear.cgColor
        
        teamFiveButton.layer.cornerRadius = 20
        teamFiveButton.layer.shadowColor = UIColor.gray.cgColor
        teamFiveButton.layer.shadowOpacity = 0.8
        teamFiveButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        teamFiveButton.layer.borderWidth = 3
        teamFiveButton.layer.borderColor = UIColor.clear.cgColor
        
        teamSixButton.layer.cornerRadius = 20
        teamSixButton.layer.shadowColor = UIColor.gray.cgColor
        teamSixButton.layer.shadowOpacity = 0.8
        teamSixButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        teamSixButton.layer.borderWidth = 3
        teamSixButton.layer.borderColor = UIColor.clear.cgColor
    }
    
    func showPlayer() {
        if let displayedPlayer = fetchedPlayers.randomElement() {
            shownPlayer = displayedPlayer
            print("Showing \("\(displayedPlayer.firstName ) \(displayedPlayer.lastName )") from the \(displayedPlayer.teamName ?? "No Team")")
            
            nameLabel.text = "\(displayedPlayer.firstName ) \(displayedPlayer.lastName )"
            infoLabel.text = "\(displayedPlayer.pos) • \(displayedPlayer.heightFeet)'\(displayedPlayer.heightInches)\" • \(displayedPlayer.draftInfo ?? "") • \(displayedPlayer.age ?? 0) y/o"
            
            var shownTeams = ["\(displayedPlayer.teamName ?? "?")"]
            
            while shownTeams.count < 6 {
                let randomTeam = (teams.randomElement()?.value)!
                if !shownTeams.contains(randomTeam) {
                    shownTeams.append(randomTeam)
                }
            }
            
            shownTeams.shuffle()
            teamOneButton.setTitle(shownTeams[0], for: .normal)
            teamTwoButton.setTitle(shownTeams[1], for: .normal)
            teamThreeButton.setTitle(shownTeams[2], for: .normal)
            teamFourButton.setTitle(shownTeams[3], for: .normal)
            teamFiveButton.setTitle(shownTeams[4], for: .normal)
            teamSixButton.setTitle(shownTeams[5], for: .normal)
            
            teamOneButton.setImage(UIImage(named: "\(shownTeams[0])"), for: .normal)
            teamTwoButton.setImage(UIImage(named: "\(shownTeams[1])"), for: .normal)
            teamThreeButton.setImage(UIImage(named: "\(shownTeams[2])"), for: .normal)
            teamFourButton.setImage(UIImage(named: "\(shownTeams[3])"), for: .normal)
            teamFiveButton.setImage(UIImage(named: "\(shownTeams[4])"), for: .normal)
            teamSixButton.setImage(UIImage(named: "\(shownTeams[5])"), for: .normal)
            
        }
    }
    
    func getPlayers() {
            let url = URL(string: "http:data.nba.net/10s/prod/v1/2020/players.json")!

            let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
              if let error = error {
                print("Error with fetching films: \(error)")
                return
              }
              
              guard let httpResponse = response as? HTTPURLResponse,
                    (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(String(describing: response))")
                return
              }

                if let data = data {

                    do {
                        let allPlayers = try JSONDecoder().decode(AllPlayers.self, from: data)
                        let league = allPlayers.league.standard
                        print("Got \(league.count) players.")
                        for player in league {
                            let teamName = self.teams[player.teamId]
                            let age = self.calcAge(birthday: player.dateOfBirthUTC)
                            
                            //var draftInfo = "Undrafted"
                            if player.draft.roundNum != "" {
                                let draftInfo = "Drafted #\(player.draft.pickNum) in \(player.draft.seasonYear)"
                                
                                self.fetchedPlayers.append(Player(firstName: player.firstName, lastName: player.lastName, personId: player.personId, teamId: player.teamId, teamName: teamName, isActive: player.isActive, pos: player.pos, draft: player.draft, draftInfo: draftInfo, heightFeet: player.heightFeet, heightInches: player.heightInches, weightPounds: player.weightPounds, dateOfBirthUTC: player.dateOfBirthUTC, age: age))
                            }
                            //print("\(player.firstName) \(player.lastName) from the \(teamName ?? "???")")
                            
                        }
                        print("Array has \(self.fetchedPlayers.count) players in it")
                        self.fetchedPlayers.shuffle()
                        
                        DispatchQueue.main.async {
                            self.pointsLabel.text = "\(self.points) Points"
                            self.startTimer()
                            self.showPlayer()
                            self.teamButtonsView.isHidden = false
                        }
                        

                    } catch {
                        print(error)
                    }
                    
                }
            })
            task.resume()
    }
    
    func startTimer() {
        let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.secondsPassed += 1
            //let secondsRemaining = (String(format: "%02d", self.gameLength - self.secondsPassed))
            let secondsRemaining = self.gameLength - self.secondsPassed
            self.timerLabel.text = "\(secondsRemaining)"
            
            if self.secondsPassed == self.gameLength {
                timer.invalidate()
                self.gameOver()
            }
            
        }
    }
    
    func gameOver() {
        UserDefaults.incrementIntegerForKey(key: "TotalPoints", by: points)
        UserDefaults.incrementIntegerForKey(key: "TotalMakes", by: makes)
        UserDefaults.incrementIntegerForKey(key: "TotalMisses", by: misses)
        UserDefaults.incrementIntegerForKey(key: "GamesPlayed", by: 1)
        
        print("Game Over. Final stats: \n Points:\(points)\nMakes: \(makes)\nMisses:\(misses)")
        
        performSegue(withIdentifier: "gameOverSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gameOverSegue" {
                let report = segue.destination as! ReportViewController
                report.makesAmount = makes
                report.missesAmount = misses
                report.finalPointsAmount = points
                report.previousHigh = previousHigh
                if points > previousHigh {
                    report.didGetCareerHigh = true
                    defaults.set(points, forKey: "CareerHigh")
                } else {
                    report.didGetCareerHigh = false
                }
            
        }
    }
    
    func calcAge(birthday: String) -> Int{
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd"
        guard let birthdayDate = dateFormater.date(from: birthday) else { return 0 }
        let calendar: NSCalendar! = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
        let now: NSDate! = NSDate()
        let calcAge = calendar.components(.year, from: birthdayDate, to: now as Date, options: [])
        let age = calcAge.year
        return age!
    }
}

extension UserDefaults {
    class func incrementIntegerForKey(key:String, by: Int) {
        let defaults = UserDefaults.standard
        let int = defaults.integer(forKey: key)
        defaults.set(int + by, forKey:key)
    }
}


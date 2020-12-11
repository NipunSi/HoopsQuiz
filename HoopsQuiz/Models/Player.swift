//
//  Player.swift
//  HoopsQuiz
//
//  Created by Nipun Singh on 12/7/20.
//

import Foundation

//struct PlayersList: Codable {
//    var data: [Player]
//}
//
//struct Player: Codable {
//    var first_name: String
//    var last_name: String
//    var position: String
//    var id: Int
//    var team: Team?
//}
//
//struct Team: Codable {
//    var full_name: String
//}
//
//struct Stats: Codable {
//    var data: [Game]
//}
//
//struct Game: Codable {
//    var player: Player
//    var team: Team
//}


struct AllPlayers: Codable {
    var league: Leagues
}

struct Leagues: Codable {
    var standard: [Player]
}

struct Player: Codable {
    var firstName: String
    var lastName: String
    var personId: String
    var teamId: String
    var teamName: String?
    var isActive: Bool
    var pos: String
    var draft: Draft
    var draftInfo: String?
    var heightFeet: String
    var heightInches: String
    var weightPounds: String
    var dateOfBirthUTC: String
    var age: Int?
}

struct Draft: Codable {
    var pickNum: String
    var roundNum: String
    var seasonYear: String
}

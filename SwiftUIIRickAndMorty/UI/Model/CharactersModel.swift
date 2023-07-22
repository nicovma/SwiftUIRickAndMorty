//
//  CharactersModel.swift
//  SwiftUIIRickAndMorty
//
//  Created by Nico Valentini Mac Adden on 21/07/2023.
//

import Foundation

struct CharactersResponse: Decodable {
    var info: CharactersInfoResponse
    var results: [CharacterInformation]
}

struct CharactersInfoResponse: Decodable {
    var count: Int
    var pages: Int
    var next: String?
    var prev: String?
}

struct CharacterInformation: Decodable, Identifiable, Equatable {
    static func == (lhs: CharacterInformation, rhs: CharacterInformation) -> Bool {
        lhs.id == rhs.id
    }
    
    var id: Int
    var name: String
    var status: CharacterStatus
    var species: String
    var type: String
    var gender: CharacterGender
    var origin: CharacterLocation
    var location: CharacterLocation
    var image: String
    var episode: [String]
    var url: String
    var created: String
}

struct CharacterLocation: Decodable {
    var name: String
    var url: String?
}

enum CharacterStatus: String, Decodable {
    case dead = "Dead"
    case alive = "Alive"
    case unknown = "unknown"
}

enum CharacterGender: String, Decodable {
    case female = "Female"
    case male = "Male"
    case unknown = "unknown"
    case genderless = "Genderless"
}


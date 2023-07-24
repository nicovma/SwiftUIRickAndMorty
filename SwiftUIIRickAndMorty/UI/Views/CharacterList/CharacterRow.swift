//
//  CharacterRow.swift
//  SwiftUIIRickAndMorty
//
//  Created by Nico Valentini Mac Adden on 24/07/2023.
//

import SwiftUI

struct CharacterRow: View {
    
    var character: CharacterInformation
    
    var body: some View {
        HStack{
            DownloadedImage(imageURL: character.image, placeholder: "person")
                .frame(width: 80, height: 80)
            Text(character.name)
                .foregroundColor(.gray)
        }
    }
}

struct CharacterRow_Previews: PreviewProvider {
    static var previews: some View {
        CharacterRow(character: CharacterInformation(id: 1, name: "juan", status: CharacterStatus.alive, species: "Human", type: "other", gender: CharacterGender.male, origin: CharacterLocation(name: "Location 1"), location: CharacterLocation(name: "Location 2"), image: "", episode: ["1","2","3","4"], url: "ddddddd", created: "asdasd"))
    }
}

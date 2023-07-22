//
//  CharacterListView.swift
//  SwiftUIIRickAndMorty
//
//  Created by Nico Valentini Mac Adden on 21/07/2023.
//

import SwiftUI

struct CharacterListView: View {
    
    @StateObject var viewModel = CharactersViewModel()
    
    var body: some View {
        if viewModel.isLoading {
                LoadingView()
        } else if let message = viewModel.errorMessage  {
            ErrorView(errorMessage: message)
        } else {
            NavigationView {
                List {
                    ForEach(viewModel.filteredCharacters) { character in
                        NavigationLink {
                            Text(character.name + " Detail")
                                .foregroundColor(.gray)
                        } label: {
                            HStack{
                                DownloadedImage(imageURL: character.image)
                                    .frame(width: 200, height: 200)
                                Spacer()
                                Text(character.name)
                                    .foregroundColor(.gray)
                                    .onAppear(perform: {
                                        if character == viewModel.filteredCharacters.last {
                                            viewModel.fetchMoreCharactersIfNeeded()
                                        }
                                    })
                            }
                        }
                    }
                }
                .listStyle(PlainListStyle())
                .navigationTitle("Find your character")
                .searchable(text: $viewModel.searchText)
            }
        }
    }
}

struct CharacterListView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterListView()
    }
}

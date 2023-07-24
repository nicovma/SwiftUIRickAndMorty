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
            NavigationView {
                List {
                    ForEach(viewModel.characters) { character in
                        NavigationLink {
                            Text(character.name + " Detail")
                                .foregroundColor(.gray)
                        } label: {
                            CharacterRow(character: character)
                            .onAppear(perform: {
                                if character == viewModel.characters.last {
                                    viewModel.fetchMoreCharactersIfNeeded()
                                }
                            })
                        }
                    }
                    .listRowSeparator(.hidden)
                }
                .listStyle(PlainListStyle())
                .navigationTitle("Find your character")
                .searchable(text: $viewModel.searchText)
                .onChange(of: viewModel.searchText, perform: { newValue in
                        Task {
                            viewModel.fetchFirstCharacterPage()
                         }
                })
            }
            .overlay(
                LoadingView(isLoading: $viewModel.isLoading)
            )
            .overlay(
                ErrorView(errorMessage: $viewModel.errorMessage, viewModel: viewModel)
            )
    }
}

struct CharacterListView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterListView()
    }
}

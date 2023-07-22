//
//  CharactersViewModel.swift
//  SwiftUIIRickAndMorty
//
//  Created by Nico Valentini Mac Adden on 21/07/2023.
//

import Foundation

class CharactersViewModel: ObservableObject {
    
    @Published var characters = [CharacterInformation]()
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var searchText = ""
    private var pageNumber = 1
    
    // Used with searchText to filter character results
    var filteredCharacters: [CharacterInformation] {
        return searchText == "" ? characters : characters.filter { $0.name.contains(searchText.lowercased()) }
    }
    
    let service: APIServiceProtocol
    
    init(service: APIServiceProtocol = APIService()) {
        self.service = service
        fetchFirstCharacters()
    }
    
    func fetchFirstCharacters() {
        
        isLoading = true
        errorMessage = nil
        
        pageNumber = 1
        
        let urlString = "https://rickandmortyapi.com/api/character"
        
        let url = URL(string: urlString)
        service.fetch(CharactersResponse.self, url: url) { [unowned self] result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    print(error)
                case .success(let response):
                    print("--- sucess with \(response.results.count)")
                    self.characters = response.results
                }
            }
        }
    }
    
    func fetchMoreCharactersIfNeeded() {
        
        errorMessage = nil
        
        
        // TODO: Add parameters to request
        let urlString = "https://rickandmortyapi.com/api/character?page="
        
        pageNumber+=1
        
        let url = URL(string: urlString+String(pageNumber))
        service.fetch(CharactersResponse.self, url: url) { [unowned self] result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    print(error)
                case .success(let response):
                    print("--- sucess with \(response.results.count)")
                    self.characters += response.results
                }
            }
        }
    }
    
    
    //MARK: preview helpers
    
    static func errorState() -> CharactersViewModel {
        let viewModel = CharactersViewModel()
        viewModel.errorMessage = APIError.url(URLError.init(.notConnectedToInternet)).localizedDescription
        return viewModel
    }
}

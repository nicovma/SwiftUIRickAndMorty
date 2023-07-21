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
    @Published var pageNumber = ""
    
    // Used with searchText to filter character results
    var filteredCharacters: [CharacterInformation] {
        return searchText == "" ? characters : characters.filter { $0.name.contains(searchText.lowercased()) }
    }
    
    let service: APIServiceProtocol
    
    init(service: APIServiceProtocol = APIService()) {
        self.service = service
        fetchAllCharacters()
    }
    
    func fetchAllCharacters(page: String? = nil) {
        
        isLoading = true
        errorMessage = nil
        
        // TODO: Add parameters to request
        var urlString = "https://rickandmortyapi.com/api/character?page="
        
        if let page = page {
            urlString += page
        }
        
        let url = URL(string: urlString)
        service.fetch(CharactersResponse.self, url: url) { [unowned self] result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    // print(error.description)
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

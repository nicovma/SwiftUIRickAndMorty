//
//  CharactersViewModel.swift
//  SwiftUIIRickAndMorty
//
//  Created by Nico Valentini Mac Adden on 21/07/2023.
//

import Foundation

class CharactersViewModel: ObservableObject, ViewModelProtocol {

    @Published var characters = [CharacterInformation]()
    @Published var isLoading: Bool = false
    @Published var hasNext: Bool = false
    @Published var errorMessage: String? = nil
    @Published var searchText = ""
    private var pageNumber = 1
        
    let service: APIServiceProtocol
    
    init(service: APIServiceProtocol = APIService()) {
        self.service = service
        fetchFirstCharacterPage()
    }
    
    func fetchFirstCharacterPage() {
        
        errorMessage = nil
        pageNumber = 1
    
        // TODO: acomodar URL el filtro
        var urlString = "https://rickandmortyapi.com/api/character"
        isLoading = true
        if !searchText.isEmpty {
            urlString = urlString + "?name=" + searchText
        }
        
        fetchCharacters(urlString: urlString)
    }
    
    func fetchMoreCharactersIfNeeded() {
        if hasNext {
            errorMessage = nil
            pageNumber+=1
            
            // TODO: Add parameters to request
            var urlString = "https://rickandmortyapi.com/api/character?page="
            
            urlString = urlString + String(pageNumber)
            
            if !searchText.isEmpty {
                urlString = urlString + "&name=" + searchText
            }
            
            fetchCharacters(urlString: urlString)
        }
    }
    
    func fetchCharacters(urlString: String) {
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
                    if self.pageNumber == 1 {
                        self.characters = response.results
                    } else {
                        self.characters += response.results
                    }
                    self.hasNext = (response.info.next != nil)
                }
            }
        }
    }
    
    func errorAccepted() {
        errorMessage = nil
    }
    
    //MARK: preview helpers
    
    static func errorState() -> CharactersViewModel {
        let viewModel = CharactersViewModel()
        viewModel.errorMessage = APIError.url(URLError.init(.notConnectedToInternet)).localizedDescription
        return viewModel
    }
}

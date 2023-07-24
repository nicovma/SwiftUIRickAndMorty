//
//  ErrorView.swift
//  SwiftUIIRickAndMorty
//
//  Created by Nico Valentini Mac Adden on 21/07/2023.
//

import SwiftUI

struct ErrorView: View {
    
    @Binding var errorMessage: String?
    var viewModel: ViewModelProtocol
    
    var body: some View {
        VStack {
            if let errorMessage = errorMessage {
                ZStack {
                    Color.black.opacity(0.4)
                        .edgesIgnoringSafeArea(.all)
                    VStack {
                        Text(errorMessage)
                            .foregroundColor(.white)
                            .padding(.top, 8)
                        Button("OK") {
                            viewModel.errorAccepted()
                        }
                        .foregroundColor(.white)
                        .background(.black)
                        .padding(8)
                    }
                    .padding()
                    .background(Color.accentColor)
                    .cornerRadius(10)
                }
                .onAppear {
                    hideKeyboard()
                }
            }
        }
    }
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = CharactersViewModel()
        ErrorView(errorMessage: .constant(viewModel.errorMessage), viewModel: CharactersViewModel.errorState())
    }
}

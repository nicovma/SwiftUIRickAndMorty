//
//  ErrorView.swift
//  SwiftUIIRickAndMorty
//
//  Created by Nico Valentini Mac Adden on 21/07/2023.
//

import SwiftUI

struct ErrorView: View {
    
    let errorMessage: String
    
    var body: some View {
        VStack {
            Text("😿")
                .font(.system(size: 80))
            
            Text(errorMessage)
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(errorMessage: APIError.badURL.localizedDescription)
    }
}

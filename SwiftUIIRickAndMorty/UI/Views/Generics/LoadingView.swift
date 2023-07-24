//
//  LoadingView.swift
//  SwiftUIIRickAndMorty
//
//  Created by Nico Valentini Mac Adden on 21/07/2023.
//

import SwiftUI

struct LoadingView: View {
    @Binding var isLoading: Bool
    
    var body: some View {
        VStack {
            if isLoading {
                ZStack {
                    Color.black.opacity(0.4)
                        .edgesIgnoringSafeArea(.all)
                    VStack {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        Text("Loading...")
                            .foregroundColor(.white)
                            .padding(.top, 8)
                    }
                    .padding()
                    .background(Color.accentColor)
                    .cornerRadius(10)
                }
            }
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(isLoading: .constant(true))
    }
}

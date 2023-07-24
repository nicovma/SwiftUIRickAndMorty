//
//  DownloadedImage.swift
//  SwiftUIIRickAndMorty
//
//  Created by Nico Valentini Mac Adden on 22/07/2023.
//

import SwiftUI

struct DownloadedImage: View {
    
    @State private var image: UIImage? = nil
    @State private var isLoading = false

    let imageURL: String
    let placeholder: String

    var body: some View {
        VStack {
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            } else {
                if let image = image {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(8)
                        .padding(4)
                } else {
                    Image(systemName: placeholder)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.gray)
                        .cornerRadius(8)
                        .padding(4)
                }
            }
        }
        .onAppear {
            loadImage()
        }
    }

    private func loadImage() {
        guard let url = URL(string: imageURL) else { return }

        isLoading = true

        URLSession.shared.dataTask(with: url) { data, _, error in
            defer {
                DispatchQueue.main.async {
                    isLoading = false
                }
            }

            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }.resume()
    }
}

struct DownloadedImage_Previews: PreviewProvider {
    static var previews: some View {
        DownloadedImage(imageURL: "https://images.unsplash.com/photo-1414235077428-338989a2e8c0?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8cmVzdGF1cmFudHN8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60", placeholder: "person")
    }
}

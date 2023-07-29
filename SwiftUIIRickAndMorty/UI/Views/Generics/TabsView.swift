//
//  TabsView.swift
//  SwiftUIIRickAndMorty
//
//  Created by Nico Valentini Mac Adden on 28/07/2023.
//

import SwiftUI

struct TabsView: View {
    var body: some View {
        TabView {
            CharacterListView()
                .tabItem {
                    Label("Characters", systemImage: "person")
                }
            Text("Episodes")
                .tabItem {
                    Label("Episodes", systemImage: "film")
                }
            Text("Locations")
                .tabItem {
                    Label("Locations", systemImage: "mappin.and.ellipse")
                }
        }
    }
}

struct TabsView_Previews: PreviewProvider {
    static var previews: some View {
        TabsView()
    }
}

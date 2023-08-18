//
//  ContentView.swift
//  Tempo_News_Fitrah
//
//  Created by Laptop MCO on 13/08/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    

    var body: some View {
        
            TabView {
                HomeView()
                    .tabItem {
                        Image(systemName: "house.fill")
                    }.tag(0)
                SearchView()
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                    }.tag(1)
                GenerateImage()
                    .tabItem {
                        Image(systemName: "i.circle.fill")
                    }.tag(2)
                BookmarkView()
                    .tabItem {
                        Image(systemName: "bookmark")
                    }.tag(3)
                AboutView()
                    .tabItem {
                        Image(systemName: "person.2")
                    }.tag(4)
            }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

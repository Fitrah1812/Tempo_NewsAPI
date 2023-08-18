//
//  HomeView.swift
//  Tempo_News_Fitrah
//
//  Created by Laptop MCO on 13/08/23.
//

import SwiftUI

struct HomeView: View {
    @State private var firstState = "🎃 All"
    var navbarState = ["🎃 All", "🔝 Top", "🆕 New", "🎪 Show"]
    @State private var searchText: String = ""
    @StateObject private var newsVM = HomeViewModel()

    
    var body: some View {
        NavigationStack {
            if newsVM.isLoading {
                ProgressView("Load News...")
            } else {
                HStack {
                    Picker("What is your favorite color?", selection: $firstState) {
                        ForEach(navbarState, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    Text(" ")                    
                }
                List(newsVM.news) { newsItem in
                    
                    if(firstState == "🎃 All"){
                        NavigationLink(destination: DetailItemView(news: newsItem)) {
                            ListItemView(news: newsItem)
                        }
                    }else if(firstState == "🔝 Top"){
                        if(newsItem.creator.count <= 7){
                            NavigationLink(destination: DetailItemView(news: newsItem)) {
                                ListItemView(news: newsItem)
                            }
                        }
                    }else if(firstState == "🆕 New"){
                        if(newsItem.creator.count > 7 && newsItem.creator.count <= 15){
                            NavigationLink(destination: DetailItemView(news: newsItem)) {
                                ListItemView(news: newsItem)
                            }
                        }
                    }else if(firstState == "🎪 Show"){
                        if(newsItem.creator.count > 15){
                            NavigationLink(destination: DetailItemView(news: newsItem)) {
                                ListItemView(news: newsItem)
                            }
                        }
                    }
                }
                .listStyle(.plain)
                .navigationTitle("Tempo News")
                .refreshable {
                    await newsVM.fetchNews()
                }
            }
        }
        .task {
            await newsVM.fetchNews()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

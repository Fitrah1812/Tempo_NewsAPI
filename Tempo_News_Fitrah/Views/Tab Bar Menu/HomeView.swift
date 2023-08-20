//
//  HomeView.swift
//  Tempo_News_Fitrah
//
//  Created by Laptop MCO on 13/08/23.
//

import SwiftUI

struct HomeView: View {
    @State private var firstState = "🎃 All"
    @State private var showAlert = false
    var navbarState = ["🎃 All", "🔝 Top", "🆕 New", "🎪 Show"]
    @State private var searchText: String = ""
    @StateObject private var newsVM = HomeViewModel()

    
    var body: some View {
        NavigationStack {
            if newsVM.isLoading {
                ProgressView("Load News...")
            } else {
                HStack {
                    Picker("What is your favorite news?", selection: $firstState) {
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
        .toolbar {
            ToolbarItem {
                HStack {
                    Button {
                    } label: {
                        Image(systemName: "bookmark")
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("Bookmark"),
                            message: Text("Congratulation. Added to bookmark! 🎉🎉"),
                            dismissButton: .default(Text("OK"))
                        )
                    }
                    
                    Image(systemName: "square.and.arrow.up")
                }
                .frame(width: 24, height: 24)
                .padding(.trailing, 30)
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

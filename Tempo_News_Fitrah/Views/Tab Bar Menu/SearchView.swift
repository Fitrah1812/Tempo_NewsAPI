//
//  SearchView.swift
//  Tempo_News_Fitrah
//
//  Created by Laptop MCO on 13/08/23.
//

import SwiftUI

struct SearchView: View {
    @State private var firstState = "🎃 Food"
    @State private var showAlert = false
    var navbarState = ["🎃 Food", "🔝 Otomodif", "🆕 Science", "🎪 Techno"]
    @StateObject private var newsVM = HomeViewModel()
    @State private var searchText = ""
    var body: some View {
        NavigationStack {
            if newsVM.isLoading {
                ProgressView("Load News...")
            } else {
                HStack {
                    Picker("What is your favorite news?", selection: $firstState.onChange({ newTag in
                        Task{
                            if(newTag == "🎃 Food"){
                                await newsVM.fetchNewsFood()
                            }else if(newTag == "🔝 Otomodif") {
                                await newsVM.fetchNewsOtomodif()
                            }else if(newTag == "🆕 Science"){
                                await newsVM.fetchNewsScience()
                            }else if(newTag == "🎪 Techno"){
                                await newsVM.fetchNews()
                            }
                        }
                    })) {
                        ForEach(navbarState, id: \.self) {
                            Text($0)
                            
                        }
                    }
                    .pickerStyle(.segmented)
                    Text(" ")
                }
                
                List(newsVM.filteredItems) { newsItem in
                    NavigationLink(destination: DetailItemView(news: newsItem)) {
                            ListItemView(news: newsItem)
                        }
                }
                .searchable(text: $newsVM.searchText)
                .listStyle(.plain)
                .navigationTitle("Search Tempo News")
                .refreshable {
                    if(firstState == "🎃 Food"){
                        await newsVM.fetchNewsFood()
                    }else if(firstState == "🔝 Otomodif") {
                        await newsVM.fetchNewsOtomodif()
                    }else if(firstState == "🆕 Science"){
                        await newsVM.fetchNewsScience()
                    }else if(firstState == "🎪 Techno"){
                        await newsVM.fetchNews()
                    }
                }
            }
        }
        .task {
            if(firstState == "🎃 Food"){
                await newsVM.fetchNewsFood()
            }else if(firstState == "🔝 Otomodif") {
                await newsVM.fetchNewsOtomodif()
            }else if(firstState == "🆕 Science"){
                await newsVM.fetchNewsScience()
            }else if(firstState == "🎪 Techno"){
                await newsVM.fetchNews()
            }
        }
        
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

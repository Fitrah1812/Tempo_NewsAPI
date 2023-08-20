//
//  SearchView.swift
//  Tempo_News_Fitrah
//
//  Created by Laptop MCO on 13/08/23.
//

import SwiftUI

struct SearchView: View {
    @StateObject private var newsVM = HomeViewModel()
    @State private var searchText = ""
    var body: some View {
        NavigationStack {
            if newsVM.isLoading {
                ProgressView("Load News...")
            } else {
                List(newsVM.filteredItems) { newsItem in
                    NavigationLink(destination: DetailItemView(news: newsItem)) {
                            ListItemView(news: newsItem)
                        }
                }
                .searchable(text: $newsVM.searchText)
                .listStyle(.plain)
                .navigationTitle("Search Tempo News")
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

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

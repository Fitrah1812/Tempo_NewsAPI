//
//  HomeView.swift
//  Tempo_News_Fitrah
//
//  Created by Laptop MCO on 13/08/23.
//

import SwiftUI

struct HomeView: View {
    @State private var firstState = "🌭 Food"
    @State private var showAlert = false
    var navbarState = ["🌭 Food", "🚌 Otomodif", "🧪 Science", "💻 Techno"]
    @State private var searchText: String = ""
    @StateObject private var newsVM = HomeViewModel()
    @State private var isFirstAppearance = true
    
    
    var body: some View {
        NavigationStack {
            if newsVM.isLoading {
                ProgressView("Load News...")
            } else {
                HStack {
                    Picker("What is your favorite news?", selection: $firstState.onChange({ newTag in
                        Task{
                            if(newTag == "🌭 Food"){
                                await newsVM.fetchNewsFood()
                            }else if(newTag == "🚌 Otomodif") {
                                await newsVM.fetchNewsOtomodif()
                            }else if(newTag == "🧪 Science"){
                                await newsVM.fetchNewsScience()
                            }else if(newTag == "💻 Techno"){
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
                List(newsVM.news) { newsItem in
                    NavigationLink(destination: DetailItemView(news: newsItem)) {
                            ListItemView(news: newsItem)
                        }
                }
                .refreshable {
                    if(firstState == "🌭 Food"){
                        await newsVM.fetchNewsFood()
                    }else if(firstState == "🚌 Otomodif") {
                        await newsVM.fetchNewsOtomodif()
                    }else if(firstState == "🧪 Science"){
                        await newsVM.fetchNewsScience()
                    }else if(firstState == "💻 Techno"){
                        await newsVM.fetchNews()
                    }
                }
                .listStyle(.plain)
                .navigationTitle("🆕 Tempo News 🆕")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar(content: {
                    ToolbarItem(placement: .principal) {
                        AsyncImage(url: URL(string: "https://www.tempo.co/desktop/images/logo-tempo-id.png")) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 150, height: 50)
                        } placeholder: {
                            Text("Zetizen News")
                        }
                    }
                })
            }
        }
        .task {
            if(firstState == "🌭 Food"){
                await newsVM.fetchNewsFood()
            }else if(firstState == "🚌 Otomodif") {
                await newsVM.fetchNewsOtomodif()
            }else if(firstState == "🧪 Science"){
                await newsVM.fetchNewsScience()
            }else if(firstState == "💻 Techno"){
                await newsVM.fetchNews()
            }
            
        }
    }
}

extension Binding where Value: Equatable {
    func onChange(_ handler: @escaping (Value) -> Void) -> Self {
        return Binding(
            get: { self.wrappedValue },
            set: { newValue in
                if self.wrappedValue != newValue {
                    self.wrappedValue = newValue
                    handler(newValue)
                }
            }
        )
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

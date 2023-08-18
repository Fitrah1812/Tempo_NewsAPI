//
//  HomeViewModel.swift
//  Tempo_News_Fitrah
//
//  Created by Laptop MCO on 15/08/23.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var news: [News] = []
    @Published var isLoading = false
    @Published var searchText = ""
    
    var filteredItems: [News] {
        if searchText.isEmpty {
            return news
        } else {
            return news.filter { index in
                index.title.lowercased().contains(searchText.lowercased()) ||
                index.content.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    func fetchNews() async {
        DispatchQueue.main.async {
            self.isLoading = true 
        }
        
        Task {
            do {
                let url = URL(string: "https://berita-indo-api-next.vercel.app/api/zetizen-jawapos-news/techno")!
                let (data, _) = try await URLSession.shared.data(from: url)
                let response = try JSONDecoder().decode(DataApi.self, from: data)
                
                DispatchQueue.main.async {
                    self.news = response.data.map { newsData in
                        News(
                            creator: newsData.creator,
                            title: newsData.title,
                            link: newsData.link,
                            content: newsData.content,
                            categories: newsData.categories,
                            isoDate: newsData.isoDate,
                            image: newsData.image
                        )
                    }
                    self.isLoading = false
                }
            } catch {
                print("Error fetching data: \(error)")
            }
        }
    }
    
}

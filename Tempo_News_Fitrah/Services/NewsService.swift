//
//  NewsService.swift
//  Tempo_News_Fitrah
//
//  Created by Laptop MCO on 15/08/23.
//

import Foundation

enum NetworkError: Error {
    case BadUrl
    case NoData
    case DecodingError
}

class NewsService {
    @Published var news: [News] = []
    @Published var isLoading = false
    
    func getNews(completion : @escaping(Result<DataApi?,NetworkError>) -> Void){
        guard let url = URL(string: Constants.getData) else {
            return completion(.failure(.BadUrl))
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return completion(.failure(.NoData))
            }
            let dataResponse = try? JSONDecoder().decode(DataApi.self, from: data)
            DispatchQueue.main.async {
                let udin = (response as? HTTPURLResponse)!
                
                if let dataResponse = dataResponse {
                    self.news = dataResponse.data.map { newsData in
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
                    
                    print(dataResponse.data as Any)
                    completion(.success(dataResponse))
                } else{
                    print(dataResponse?.data as Any)
                    print(String(data: data, encoding: .utf8)!)
                    print(udin.statusCode)
                    completion(.failure(.DecodingError))
                    
                }
            }
        }
        task.resume()
    }
}

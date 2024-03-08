//
//  ArticlesGalleryViewModel.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 06/03/2024.
//

import Foundation
import CloudKit

class ArticlesGalleryViewModel: ObservableObject {
    @Published var articles = [Article]()
    @Published var topPicks = [Article]()
    @Published var articleError: Error?
    @Published var topPicksError: Error?
    
    private var isShuffled: Bool = false
    private var hasFetchedData: Bool = false
    
    // fetch news articles relating to climate change and carbon emissions from NewsAPI
    func fetchClimateChangeNews() {
        guard !hasFetchedData else { return }
        
        if let newsApiKey = Bundle.main.object(forInfoDictionaryKey: "NEWS_API_KEY") as? String {
            let urlString = "https://newsapi.org/v2/everything?q=+climate,+change,+carbon,+emissions&sources=bbc-news,the-verge,associated-press,forbes,fox-news,the-guardian,reuters,the-washington-post,the-new-york-times,the-wall-street-journal,the-economist,nature,scientific-american,the-globe-and-mail,cnn,time,business-insider,techcrunch&pageSize=20&sortBy=publishedAt&apiKey=\(newsApiKey)"
            guard let url = URL(string: urlString) else {
                return
            }
            
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        let articlesResponse = try decoder.decode(Articles.self, from: data)
                        DispatchQueue.main.async {
                            self.articles = articlesResponse.articles
                            self.hasFetchedData = true
                        }
                    } catch {
                        DispatchQueue.main.async {
                            self.articleError = error
                        }
                    }
                } else if let error = error {
                    DispatchQueue.main.async {
                        self.articleError = error
                    }
                }
            }
            task.resume()
        }
    }
    
    // fetch preset top pick articles from json file
    func fetchTopPicks() {
        if topPicks.isEmpty, let url = Bundle.main.url(forResource: "topPicks", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let topPicksResponse = try decoder.decode(TopPicks.self, from: data)
                
                DispatchQueue.main.async {
                    self.topPicks = topPicksResponse.articles.shuffled()
                }
            } catch {
                DispatchQueue.main.async {
                    self.topPicksError = error
                }
            }
        }
    }
    
    // set the user's articles read to their public record
    func setUserReadArticles(readArticles: Int) async {
        let attributes: [String: CKRecordValue] = [
            "articles": readArticles as CKRecordValue,
        ]
        
        do {
            try await PublicDataManager.shared.setPublicUserRecord(attributes: attributes)
        } catch {
            print("Error setting article values: \(error)")
        }
    }
}

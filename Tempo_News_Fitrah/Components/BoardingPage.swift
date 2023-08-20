//
//  BoardingPage.swift
//  Tempo_News_Fitrah
//
//  Created by Laptop MCO on 20/08/23.
//

import SwiftUI

struct BoardingPage: View {
    let news: News
    
    var body: some View {
        VStack(spacing: 5) {
            AsyncImage(url: URL(string: news.image)) { phase in
                phase.resizable().scaledToFill()
                    .overlay {
                        Color.black
                            .opacity(0)
                    }
            } placeholder: {
                ProgressView()
                    .frame(width: 80, height: 80)
            }
            .frame(maxWidth: 300, maxHeight: 100)
            .opacity(0.85)
            
            Text(news.title)
                .font(.body)
                .lineLimit(2)
                .foregroundColor(.white)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
        }
    }
}

struct BoardingPage_Previews: PreviewProvider {
    static var previews: some View {
        BoardingPage(news: News(
                creator: "This is author",
                title: "This is sample title",
                link: "This is link",
                content: "This is sample description so you can see it in long text",
                categories: ["Android", "udina"],
                isoDate: "2023-08-13T02:44:58.000Z",
                image: "https://blue.kumparan.com/image/upload/fl_progressive,fl_lossy,c_fill,q_auto:best,w_480,f_jpg/v1634025439/01h7mjymq414642m0rfxmzeqsh.jpg"
            )
        )
    }
}

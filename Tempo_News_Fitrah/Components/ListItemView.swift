//
//  ListItemView.swift
//  Tempo_News_Fitrah
//
//  Created by Laptop MCO on 14/08/23.
//

import SwiftUI

struct ListItemView: View {
    let news: News
    
    var body: some View {
        HStack(spacing: 14) {
            AsyncImage(url: URL(string: news.image)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 137, height: 140)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            } placeholder: {
                ProgressView()
                    .frame(width: 80, height: 80)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text(news.title)
                    .font(.system(size: 18, design: .rounded))
                    .fontWeight(.bold)
                    .lineLimit(5)
                    .truncationMode(.tail)
                
                Text(news.creator)
                    .lineLimit(1)
                    .font(.footnote)
                    .foregroundColor(.gray)
                
                HStack {
                    Text(news.categories.first!)
                        .lineLimit(2)
                        .font(.footnote)
                        .foregroundColor(.blue)
                    Text("-")
                    
                    
                    Text(news.isoDate.formattedDate())
                        .lineLimit(1)
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
            }
        }
    }
    
    
}

struct ListItemView_Previews: PreviewProvider {
    static var previews: some View {
        ListItemView(news: News(
            creator: "This is author",
            title: "This is sample title",
            link: "This is link",
            content: "This is sample description so you can see it in long text",
            categories: ["Android dan Android", "udina"],
            isoDate: "2023-08-13T02:44:58.000Z",
            image: "https://blue.kumparan.com/image/upload/fl_progressive,fl_lossy,c_fill,q_auto:best,w_480,f_jpg/v1634025439/01h7mjymq414642m0rfxmzeqsh.jpg"
            )
        )
    }
}


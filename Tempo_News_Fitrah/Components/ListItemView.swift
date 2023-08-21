//
//  ListItemView.swift
//  Tempo_News_Fitrah
//
//  Created by Laptop MCO on 14/08/23.
//

import SwiftUI

struct ListItemView: View {
    
    @State private var showAlert = false
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.isoDate, ascending: true)],
        animation: .default)
    
    var items: FetchedResults<Item>
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
                    
                    Menu(
                        content: {
                            Button{
                                
                            } label: {
                                Image(systemName: "square.and.arrow.up")
                                Text("Share")
                            }
                            .tag(0)
                            
                            Button{
                                addItem()
                                showAlert = true
                            } label: {
                                Image(systemName: "bookmark")
                                Text("Bookmark")
                            }
                            .tag(1)
                            .alert(isPresented: $showAlert) {
                                Alert(
                                    title: Text("Bookmark"),
                                    message: Text("Congratulation. Added to bookmark! 🎉🎉"),
                                    dismissButton: .default(Text("OK"))
                                )
                            }
                            
                        },
                        label: {
                            Image(systemName: "ellipsis")
                                .tint(.black)
                        }
                            
                    )
                }
            }
        }
    }
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.isoDate = Date()
//            newItem.id = UUID()
            newItem.title = self.news.title
            newItem.content = self.news.content
            newItem.link = self.news.link
            newItem.image = self.news.image
            newItem.creator = self.news.creator
            newItem.categories = self.news.categories.first
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
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


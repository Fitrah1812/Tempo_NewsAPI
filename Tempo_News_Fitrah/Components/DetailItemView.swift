//
//  DetailItemView.swift
//  Tempo_News_Fitrah
//
//  Created by Laptop MCO on 15/08/23.
//

import SwiftUI

struct DetailItemView: View {
    @State private var showAlert = false
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.isoDate, ascending: true)],
        animation: .default)
    
    var items: FetchedResults<Item>
    let news: News
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
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
                        .frame(maxWidth: .infinity, maxHeight: 220)
                        .clipped()
                        
                        VStack(alignment: .leading, spacing: 16) {
                            Text(news.title)
                                .font(.system(.headline, design: .rounded))
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .lineLimit(nil)
                            HStack {
                                Image(systemName: "person")
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                                
                                Text("By \(news.creator)")
                                    .font(.subheadline)
                                    .foregroundColor(.black)
                                HStack {
                                    Spacer()
                                    Text("\(news.isoDate.formattedDate())")
                                        .font(.subheadline)
                                        .foregroundStyle(.gray)
                                    
                                }
                            }
                            
                            Text(news.content)
                                .font(.system(.body, design: .rounded))
                                .lineLimit(nil)
                                                        
                            if((URL(string: news.link)) != nil){
                                Link(destination: URL(string: news.link)!) {
                                    
                                    HStack {
                                        Text("Selengkapnya")
                                        Image(systemName: "arrow.right.circle")
                                    }
                                    .frame(width: 156, height: 32)
                                    .background(LinearGradient(gradient: Gradient(colors: [.pink, .purple]), startPoint: .leading, endPoint: .trailing))
                                    .mask(RoundedRectangle(cornerRadius: 20))
                                    .foregroundStyle(.white)
                                }
                                .offset(x: 200, y: 40)
                            }else {
                                Link(destination: URL(string: "https://www.linkedin.com/in/fitrah-arie-ramadhan-049953189/")!) {
                                    Spacer()
                                    HStack {
                                        Text("Selengkapnya")
                                        Image(systemName: "arrow.right.circle")
                                    }
                                    .frame(width: 170, height: 45)
                                    .background(LinearGradient(gradient: Gradient(colors: [.pink, .purple]), startPoint: .leading, endPoint: .trailing))
                                    .mask(RoundedRectangle(cornerRadius: 20))
                                    .foregroundStyle(.white)
                                }
                            }
                        }
                        .padding()
                }
            }
        }
        .toolbar {
            ToolbarItem {
                HStack {
                    Button {
                        addItem()
                        showAlert = true
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

struct DetailItemView_Previews: PreviewProvider {
    static var previews: some View {
            DetailItemView(news: News(
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

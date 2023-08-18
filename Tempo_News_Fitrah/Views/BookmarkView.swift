//
//  BookmarkView.swift
//  Tempo_News_Fitrah
//
//  Created by Laptop MCO on 13/08/23.
//

import SwiftUI
import CoreData

struct BookmarkView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.isoDate, ascending: true)],
        animation: .default)
    
    var items: FetchedResults<Item>
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(items) { newsItem in
                    HStack{
                        AsyncImage(url: URL(string: newsItem.image!)) { phase in
                            phase
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 137, height: 140)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        } placeholder: {
                            ProgressView()
                                .frame(width: 80, height: 80)
                        }
                        VStack(alignment: .leading, spacing: 8) {
                            Text(newsItem.title ?? "")
                                .font(.system(size: 18, design: .rounded))
                                .fontWeight(.bold)
                                .lineLimit(5)
                                .truncationMode(.tail)
                            
                            Text(newsItem.creator ?? "")
                                .lineLimit(1)
                                .font(.footnote)
                                .foregroundColor(.gray)
                            
                            
                            HStack {
                                Text(newsItem.categories ?? "")
                                    .lineLimit(2)
                                    .font(.footnote)
                                    .foregroundColor(.blue)
                                Text("-")
                
                                Text(newsItem.isoDate!, formatter: itemFormatter)
                                    .lineLimit(2)
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                                
                            }
                        }
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("Bookmark News")
            .listStyle(.plain)
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct BookmarkView_Previews: PreviewProvider {
    static var previews: some View {
        BookmarkView()
    }
}

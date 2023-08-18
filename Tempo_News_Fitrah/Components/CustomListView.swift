//
//  CustomListView.swift
//  Tempo_News_Fitrah
//
//  Created by Laptop MCO on 15/08/23.
//

import SwiftUI

struct CustomListView: View {
    @State var rowLabel: String
    @State var rowIcon: String
    @State var rowContent: String? = nil
    @State var rowTintColor: Color
    @State var rowLinkLabel: String? = nil
    @State var rowLinkDestination: String? = nil
    
    var body: some View {
            LabeledContent {
                if rowContent != nil {
                    Text(rowContent!)
                        .foregroundStyle(.primary)
                        .fontWeight(.heavy)
                } else if (rowLinkLabel != nil && rowLinkDestination != nil) {
                    Link(rowLinkLabel!, destination: URL(string: rowLinkDestination!)!)
                        .foregroundStyle(.blue)
                        .fontWeight(.heavy)
                } else {
                    EmptyView()
                }
            } label: {
                // Label
                HStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .frame(width: 30, height: 30)
                            .foregroundStyle(rowTintColor)
                        Image(systemName: rowIcon)
                            .foregroundStyle(.white)
                            .fontWeight(.semibold)
                    }
                    
                    Text(rowLabel)
                }
            }
        }
    }


struct CustomListView_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomListView()
//    }
    static var previews: some View {
        List {
            CustomListView(
                rowLabel: "Website",
                rowIcon: "globe",
                rowContent: nil,
                rowTintColor: .black,
                rowLinkLabel: "Fitrah Arie Ramadhan",
                rowLinkDestination: "https://hidayatabisena.com"
            )
        }
    }
    
}

//
//  About.swift
//  Tempo_News_Fitrah
//
//  Created by Laptop MCO on 18/08/23.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        NavigationStack {
            List {
                //: MARK - SECTION: HEADER
                Section {
                    HStack {
                        Spacer()
                        Text("Tempo News")
                            .textCase(/*@START_MENU_TOKEN@*/.uppercase/*@END_MENU_TOKEN@*/)
                            .font(.system(.largeTitle, design: .rounded))
                            .fontWeight(.heavy)
                            .foregroundStyle(.blue.gradient)
                        Spacer()
                    }
                    
                    HStack {
                        Spacer()
                        Text("Tempat berita-berita yang menarik dan fresh yang paling ditunggu 🚀")
                            .multilineTextAlignment(.center)
                            .fontWeight(.medium)
                        Spacer()
                    }
                } //: HEADER Section
                
                //: MARK - SECTION: ABOUT
                Section(
                  header: Text("ABOUT THE APP"),
                  footer: HStack {
                    Spacer()
                    Text("Copyright 2023 ©All right reserved.")
                    Spacer()
                  }
                    .padding(.vertical, 8)
                ) {
                  CustomListView(rowLabel: "Application", rowIcon: "apps.iphone", rowContent: "TempoNews", rowTintColor: .blue)
                  
                  CustomListView(rowLabel: "Compatibility", rowIcon: "info.circle", rowContent: "iOS", rowTintColor: .red)
                  
                  CustomListView(rowLabel: "Technology", rowIcon: "swift", rowContent: "Swift", rowTintColor: .orange)
                  
                  CustomListView(rowLabel: "Version", rowIcon: "gear", rowContent: "1.0", rowTintColor: .purple)
                  
                  CustomListView(rowLabel: "Developer", rowIcon: "ellipsis.curlybraces", rowContent: "Fitrah Arie Ramadhan", rowTintColor: .mint)
                  
                  CustomListView(rowLabel: "Designer", rowIcon: "paintpalette", rowContent: "Fitrah Arie Ramadhan", rowTintColor: .pink)
                  
                  CustomListView(rowLabel: "Website", rowIcon: "globe", rowTintColor: .indigo, rowLinkLabel: "Fitrah Arie Ramadhan", rowLinkDestination: "https://www.linkedin.com/in/fitrah-arie-ramadhan-049953189/")
                  
                } //: SECTION
                
            } //: LIST
            .navigationTitle("About")
            .navigationBarTitleDisplayMode(.inline)
        } //: NAV
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}

//
//  GenerateImage.swift
//  Tempo_News_Fitrah
//
//  Created by Laptop MCO on 17/08/23.
//

import SwiftUI
import OpenAIKit


final class ViewModel: ObservableObject {
    private var openai: OpenAI?
    
    
    func setup(){
        openai = OpenAI(Configuration(organizationId: "Personal", apiKey: "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"))
    }
    
    func generateImage(prompt: String) async -> UIImage {
        guard let openai = openai else {
            let imageError = UIImage(named: "error")!
            return imageError
        }
            
        do {
            let params = ImageParameters(
                prompt: prompt,
                resolution: .medium,
                responseFormat: .base64Json
            )
            let result = try await openai.createImage(
                parameters: params
            )
            let data = result.data[0].image
            let image = try openai.decodeBase64Image(data)
            return image
        } catch {
            print(String(describing: error))
            return UIImage(systemName: "cloud")!
        }
    }
}

struct GenerateImage: View {
    @ObservedObject var viewModel = ViewModel()
    @State var text: String = ""
    @State var image: UIImage?
    @State var messageText: String = ""
    @State var copyText: String = ""
    private let pasteboard = UIPasteboard.general
    @State private var buttonText  = "Copy to clipboard"
    var body: some View {
        
        NavigationStack {
            VStack{

                if let image = image {
                    
                    if(image == UIImage(systemName: "xmark")){
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.red, lineWidth: 3)
                            )
                    } else if (image != UIImage(systemName: "xmark")) {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.green, lineWidth: 3)
                            )
                    }
                }
                
                if(image != UIImage(systemName: "xmark") && !text.isEmpty){
                    VStack(alignment: .center){
                        Text("Code: ")
                            .font(.title)
                            .bold()
                        Text("Image(systemName: \"\(text.lowercased())\")")
                            .font(.title2)
                        HStack {
                            Button {
                                copyToClipboard()
                            } label: {
                                  Label(buttonText, systemImage: "doc.on.doc.fill")
                                  }
                                  .tint(.blue)
                                  .font(.subheadline)
                        }
                    }
                }else if (image == UIImage(systemName: "xmark") && !text.isEmpty){
                    Text("Code: ")
                        .font(.title)
                        .bold()
                    Text("Image(systemName: \"xmark\")")
                        .font(.title2)
                    HStack {
                        Button {
                            if(image == UIImage(systemName: "xmark")){
                                copyText = "Image(systemName: \"xmark\")"
                                copyToClipboard()
                                
                            } else {
                                self.copyText = "Image(systemName: \"\(text)\")"
                                copyToClipboard()
                            }
                            
                        } label: {
                              Label(buttonText, systemImage: "doc.on.doc.fill")
                              }
                              .tint(.blue)
                              .font(.subheadline)
                                
                    }
                }
                
                
                Spacer()
                TextField("type prompt here...", text: $text)
                    .padding(.vertical, 10)
                    .overlay(Rectangle().frame(height: 2).padding(.top, 35))
                    .foregroundColor(.blue)

                Button("Generate Icon"){
                    if !text.trimmingCharacters(in: .whitespaces).isEmpty {
                        let newImage = UIImage(systemName: String(text.lowercased()))
                        
                        if(newImage != nil){
                            image = newImage
                        }else {
                            image = UIImage(systemName: "xmark")
                        }
                        
                        self.copyText = "Image(systemName: \"\(text)\")"
                    }
                }
                .frame(width: 300, height: 40)
                .background(LinearGradient(gradient: Gradient(colors: [.pink, .purple]), startPoint: .leading, endPoint: .trailing))
                .mask(RoundedRectangle(cornerRadius: 10))
                .foregroundStyle(.white)
            }
            .navigationTitle("Generate Code Icon")
            .padding()
        }
    }
    
    func paste(){
            if let string = pasteboard.string {
                text = string
            }
        }
        
        func copyToClipboard() {
            if(self.image == UIImage(systemName: "xmark") && !self.text.isEmpty){
                pasteboard.string = "Image(systemName: \"xmark\")"
            }else if (self.image != UIImage(systemName: "xmark") && !self.text.isEmpty) {
                pasteboard.string = "\(self.copyText)"
            }
            
            pasteboard.string = String(self.copyText)
            self.buttonText = "Copied!"
//            self.text = ""
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.buttonText = "Copy to clipboard"
            }
        }
}

struct GenerateImage_Previews: PreviewProvider {
    static var previews: some View {
        GenerateImage()
    }
}

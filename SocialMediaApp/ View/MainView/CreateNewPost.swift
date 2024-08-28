//
//  CreateNewPost.swift
//  SocialMediaApp
//
//  Created by Abhinav Nagar on 28/08/24.
//

import SwiftUI
import PhotosUI

struct CreateNewPost: View {
    
    // Callbacks
    var onPost: (Post)->()
    // Post Properties
    @State private var postText: String = ""
    @State private var postImageData: Data?

    /// - Stored User Data From UserDefaults (AppStorage)
    @AppStorage("user_profile_url") private var profileURL: URL?
    @AppStorage("user_name") private var userName: String = ""
    @AppStorage("user_UID") private var userUID: String = ""

    // - View Properties
    @Environment(\.dismiss) private var dismiss
    @State private var isLoading: Bool = false
    @State private var errorMessage: String = ""
    @State private var showError: Bool = false
    @State private var showImagePicker: Bool = false
    @State private var photoItem: PhotosPickerItem?
    @FocusState private var showKeyboard: Bool

    var body: some View {
        VStack {
            HStack {
                Menu {
                    Button("Cancel", role: .destructive){
                        dismiss()
                    }
                }label:{
                    Text("Cancel")
                        .font(.callout)
                        .foregroundColor(.black)
                }
                .hAlign(.leading)
                
                Button(action: {
                        // Post action
                        showKeyboard = false // Hide keyboard on post
                    }){
                    Text("Post")
                        .font(.callout)
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 6)
                        .background(.black, in: Capsule())
                }
                .disableWithOpacity(postText == "")
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
            .background{
                Rectangle()
                    .fill(.gray.opacity(0.05))
                    .ignoresSafeArea()
            }
            ScrollView(.vertical, showsIndicators: false){
                VStack(spacing: 15){
                    TextField("What's happening?", text: $postText, axis: .vertical)
                        .focused($showKeyboard)
                    
                    if let postImageData, let image = UIImage(data: postImageData){
                        GeometryReader{
                            let size = $0.size
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: size.width, height: size.height)
                                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        }
                        .clipped()
                        .frame(height: 220)
                    }
                }
                .padding(15)
            }
            Divider()
            HStack {
                Button {
                    // Button action
                    showImagePicker.toggle()
                } label: {
                    Image(systemName: "photo.on.rectangle")
                        .font(.title3)
                }
                .hAlign(.leading)
                
                Button("Done") {
                    // Button action
                    showKeyboard = false
                }
            }
            .foregroundColor(.black)
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
        }
        .vAlign(.top)
        .onAppear{
            showKeyboard = true
        }
        .photosPicker(isPresented: $showImagePicker, selection: $photoItem)
        .onChange(of: photoItem) { newValue in
            if let newValue{
                Task {
                    if let rawImageData = try? await newValue.loadTransferable(type: Data.self),
                       let image = UIImage(data: rawImageData),
                       let compressedImageData = image.jpegData(compressionQuality: 0.5) {
                        // Handle the compressedImageData
                    }
                }
            }
        }
    }
}
struct CreateNewPost_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewPost {_ in
            // Add any preview-related code here, if necessary
        }
    }
}

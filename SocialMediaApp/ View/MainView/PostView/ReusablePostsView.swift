//
//  ReusablePostsView.swift
//  SocialMediaApp
//
//  Created by Abhinav Nagar on 30/08/24.
//
import SwiftUI
import Firebase

struct ReusablePostsView: View {
    var basedOnUID: Bool = false
    var uid: String = ""
    @Binding var posts: [Post]
    // View Properties
    @State private var isFetching: Bool = true
    // Pagination
    @State private var paginationDoc: QueryDocumentSnapshot?
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            LazyVStack{
                if isFetching{
                    ProgressView()
                        .padding(.top, 30)
                }else{
                    if posts.isEmpty{
                        // No post's found on firebase
                        Text("No Post's Found")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .padding(.top, 30)
                    }else{
                        // Displaying Post's
                        Posts()
                    }
                }
            }
            .padding(15)
        }
        .refreshable {
            // Scroll to refresh
            // disabling refresh for uid based post's
            guard !basedOnUID else{return}
            isFetching = true
            posts = []
            // Resetting Pagination Doc
            paginationDoc = nil
            await fetchPosts()
        }
        .task {
            // fetching for one time
            guard posts.isEmpty else{return}
            await fetchPosts()
        }
    }
    
    // Displaying fetched post's
    @ViewBuilder
    func Posts()->some View{
        ForEach(posts){post in
            PostCardView(post: post) { updatedPost in
                // Updating Post in the Array
                if let index = posts.firstIndex(where: { post in
                    post.id == updatedPost.id
                }){
                    posts[index].likedIDs = updatedPost.likedIDs
                    posts[index].dislikedIDs = updatedPost.dislikedIDs
                } 
            }onDelete: {
                // Removing Post from the Array
                withAnimation(.easeInOut(duration: 0.25)){
                    posts.removeAll{post.id == $0.id}
                }
            }
            .onAppear{
                // When last post appears, fetching new post (if there)
                if post.id == posts.last?.id && paginationDoc != nil{
                    Task{await fetchPosts()}
                }
            }
            Divider()
                .padding(.horizontal, -15)
        }
    }
    
    // Fetching Post's
    func fetchPosts()async{
        do{
            var query: Query!
            // Implementing pagination
            if let paginationDoc{
                query = Firestore.firestore().collection("Posts")
                    .order(by: "publishedDate", descending: true)
                    .start(afterDocument: paginationDoc)
                    .limit(to: 20)
            }else{
                query = Firestore.firestore().collection("Posts")
                    .order(by: "publishedDate", descending: true)
                    .limit(to: 20)
            }
            
            // New query for uid based document fetch
            // simply filter the post's which does not belongs to this uid
            if basedOnUID{
                query = query
                    .whereField("userUID", isEqualTo: uid)
            }
            
            let docs = try await query.getDocuments()
            let fetchedPosts = docs.documents.compactMap { doc -> Post? in
                try? doc.data(as: Post.self)
            }
            await MainActor.run(body: {
                posts.append(contentsOf: fetchedPosts)
                paginationDoc = docs.documents.last
                isFetching = false
            })
        }catch{
            print(error.localizedDescription)
        }
    }
}

#Preview {
    ContentView()
}

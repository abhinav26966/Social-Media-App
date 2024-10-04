//
//  ProfileView.swift
//  SocialMediaApp
//
//  Created by Abhinav Nagar on 27/08/24.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

struct ProfileView: View {
    
    // My profile data
    @State private var myProfile: User?
    @AppStorage("log_status") var logStatus: Bool = false
    
    // View Properties
    @State var errorMessage: String = ""
    @State var showError: Bool = false
    @State var isLoading: Bool = false
    
    var body: some View {
        NavigationStack{
            VStack {
                if let myProfile{
                    ReusableProfileContent(user: myProfile)
                        .refreshable{
                            // Refresh User Data
                            self.myProfile = nil
                            await fetchUserData()
                        }
                } else {
                    ProgressView()
                }
            }
            .navigationTitle("My Profile")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing, content: {
                    Menu{
                        // Two Actions here:
                        // 1: Logout
                        // 2: Delete Account
                        Button("Logout", action: logOutUser)
                        Button("Delete Account", role: .destructive, action: deleteAccount)
                    } label: {
                        Image(systemName: "ellipsis")
                            .rotationEffect(.init(degrees: 90))
                            .tint(.black)
                            .scaleEffect(0.8)
                    }
                })
            }
            .overlay{
                LoadingView(show: $isLoading)
            }
            .alert(errorMessage, isPresented: $showError){
            }
            .task {
                // this modifier is like onAppear
                // So fetching for the first time only
                if myProfile != nil{
                    return
                }
                // Initial Fetch
                await fetchUserData()
            }
        }
    }
    // Logging user out
    func logOutUser(){
        try? Auth.auth().signOut()
        logStatus = false
    }
    
    // Fetching User Data
    func fetchUserData() async{
        guard let userUID = Auth.auth().currentUser?.uid else{return}
        guard let user = try? await Firestore.firestore().collection("Users").document(userUID).getDocument(as: User.self) else {return}
        await MainActor.run(body: {
            myProfile = user
        })
    }
    
    // Deleting User account
    func deleteAccount(){
        isLoading = true
        Task{
            do{
                guard let userUID = Auth.auth().currentUser?.uid else{return}
                // Step 1: First Deleting Image from Storage
                let reference = Storage.storage().reference().child("Profile_Images").child(userUID)
                try await reference.delete()
                // Step 2: Deleting Firestore User Document
                try await Firestore.firestore().collection("Users").document(userUID).delete()
                // Step 3: Deleting Auth account and setting log status to false
                try await Auth.auth().currentUser?.delete()
                logStatus = false
            }catch{
                await setError(error)
            }
        }
    }
    // Setting error
    func setError(_ error: Error) async{
        // UI must be run on main thread
        await MainActor.run(body: {
            isLoading = false
            errorMessage = error.localizedDescription
            showError.toggle()
        })
    }
}

//#Preview {
//    ContentView()
//}

/**
 guard let userUID = Auth.auth().currentUser?.uid else{return}
 // Step 1: First Deleting Image from Storage
 let reference = Storage.storage().reference().child("Profile_Images").child(userUID)
 try await reference.delete()
 // Step 2: Deleting Firestore User Document
 try await Firestore.firestore().collection("Users").document(userUID).delete()
 // Step 3: Deleting Auth account and setting log status to false
 try await Auth.auth().currentUser?.delete()
 logStatus = false
 */

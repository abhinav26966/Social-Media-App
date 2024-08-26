//
//  SocialMediaAppApp.swift
//  SocialMediaApp
//
//  Created by Abhinav Nagar on 26/08/24.
//

import SwiftUI
import Firebase

@main
struct SocialMediaAppApp: App {
    
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

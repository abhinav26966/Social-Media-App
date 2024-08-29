//
//  MainView.swift
//  SocialMediaApp
//
//  Created by Abhinav Nagar on 27/08/24.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        // TabView with recent post's and profile tabs
        TabView{
            PostsView()
                .tabItem {
                    Image(systemName: "rectangle.portrait.on.rectangle.portrait.angled")
                    Text("Post's")
                }
            ProfileView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Profile")
                }
        }
        // Changing table label tint to black
        .tint(.black)
    }
}

#Preview {
    ContentView()
}

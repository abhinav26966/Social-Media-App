//
//  ContentView.swift
//  SocialMediaApp
//
//  Created by Abhinav Nagar on 26/08/24.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("log_status")
    var logStatus: Bool = false

    var body: some View {
        // MARK: Redirecting User Based on Log Status
//        if logStatus {
//            MainView()
//        } else {
//            LoginView()
//        }
        CreateNewPost{ _ in
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

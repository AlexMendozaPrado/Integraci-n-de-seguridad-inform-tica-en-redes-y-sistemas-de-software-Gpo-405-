//
//  ContentView.swift
//  Threads
//
//

import SwiftUI

struct ContentView: View {
    @AppStorage("token") var token: String = ""
    
    var body: some View {
        Group {
            if token.isEmpty {
                LoginView()
            } else {
                ThreadsTabView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

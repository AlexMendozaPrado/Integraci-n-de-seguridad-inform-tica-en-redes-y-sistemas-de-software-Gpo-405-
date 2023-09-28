//
//  SettingsView.swift
//  Threads
//
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("token") var token: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            ForEach(SettingsOptions.allCases) { option in
                HStack {
                    Image(systemName: option.imageName)
                    
                    Text(option.title)
                        .font(.subheadline)
                }
            }
            
            VStack(alignment: .leading) {
                Divider()
                
                Button("Log Out") {
                    token = ""
                }
                .font(.subheadline)
                .listRowSeparator(.hidden)
                .padding(.top)

            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SettingsView()
        }
    }
}

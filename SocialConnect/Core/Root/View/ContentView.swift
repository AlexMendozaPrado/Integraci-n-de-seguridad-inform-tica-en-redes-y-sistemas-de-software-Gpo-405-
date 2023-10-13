import SwiftUI

struct ContentView: View {
    @AppStorage("token") var token: String = ""
    
    var body: some View {
        Group {
            if token.isEmpty {
                LoginView()
            } else {
                PostsTabView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

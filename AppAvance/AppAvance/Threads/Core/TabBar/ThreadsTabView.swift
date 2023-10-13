// ThreadsTabView.swift
// Threads
//

import SwiftUI

struct ThreadsTabView: View {
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            FeedView()
                .tabItem {
                    Image(systemName: selectedTab == 0 ? "house.fill" : "house")
                        .imageScale(.large)
                    .environment(\.symbolVariants, selectedTab == 0 ? .fill : .none)
                }
                .onAppear { selectedTab = 0 }
                .tag(0)

            ExploreView()
                .tabItem { Image(systemName: "magnifyingglass")
                    .imageScale(.large)}
                .onAppear { selectedTab = 1 }
                .tag(1)

            // **Línea 21:** Crea la pestaña Crear hilo. La pestaña Crear hilo permite al usuario crear un nuevo hilo.

            CreateThreadDummyView(tabIndex: $selectedTab)
                .tabItem { Image(systemName: selectedTab == 2 ? "plus.app.fill" : "plus.app")
                        .imageScale(.large)
                        .environment(\.symbolVariants, selectedTab == 2 ? .fill : .none)
                    }
                    .onAppear { selectedTab = 2 }
                    .tag(2)

            // **Línea 27:** Crea la pestaña Actividad. La pestaña Actividad muestra una lista de actividades del usuario, como los hilos en los que ha participado y las publicaciones que ha realizado.

            ActivityView()
                .tabItem {
                    Image(systemName: selectedTab == 3 ? "heart.fill" : "heart")
                    .imageScale(.large)
                    .environment(\.symbolVariants, selectedTab == 3 ? .fill : .none)
                }
                .onAppear { selectedTab = 3 }
                .tag(3)

            // **Línea 33:** Crea la pestaña Perfil de usuario actual. La pestaña Perfil de usuario actual muestra el perfil del usuario actual.

            CurrentUserProfileView()
                .tabItem {
                    Image(systemName: selectedTab == 4 ? "person.fill" : "person")
                        .imageScale(.large)
                    .environment(\.symbolVariants, selectedTab == 4 ? .fill : .none)
                }
                .onAppear { selectedTab = 4 }
                .tag(4)
        }
        .tint(Color.theme.primaryText)
    }
}

struct ThreadsTabView_Previews: PreviewProvider {
    static var previews: some View {
        ThreadsTabView()
    }
}

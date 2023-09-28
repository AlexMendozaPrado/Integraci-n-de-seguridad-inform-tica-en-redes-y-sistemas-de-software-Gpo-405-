// ThreadsTabView.swift
// Threads
//

import SwiftUI

struct ThreadsTabView: View {

// **Línea 2:** Declara una variable de estado llamada `selectedTab`. Esta variable rastreará qué pestaña está seleccionada actualmente. El valor inicial de `selectedTab` es 0, lo que significa que la pestaña Feed se seleccionará de forma predeterminada.

@State private var selectedTab = 0

// **Línea 5:** Define la propiedad `body` para `ThreadsTabView`. Esta propiedad es donde se define el diseño y el contenido de la vista.

var body: some View {

// **Línea 7:** Crea un `TabView`. Un `TabView` es una vista contenedora que muestra una barra de pestañas en la parte inferior de la pantalla. Los usuarios pueden cambiar entre las diferentes vistas en el `TabView` tocando las pestañas. El parámetro `selection` especifica qué pestaña está seleccionada actualmente. En este caso, la variable de estado `selectedTab` se utiliza para determinar qué pestaña está seleccionada.

TabView(selection: $selectedTab) {

// **Línea 9:** Crea la pestaña Feed. La pestaña Feed muestra una lista de publicaciones de las personas a las que sigue el usuario.

FeedView()
    .tabItem {
        Image(systemName: selectedTab == 0 ? "house.fill" : "house")
        .environment(\.symbolVariants, selectedTab == 0 ? .fill : .none)
    }
    .onAppear { selectedTab = 0 }
    .tag(0)

// **Línea 15:** Crea la pestaña Explorar. La pestaña Explorar muestra una lista de publicaciones de personas que el usuario no sigue.

ExploreView()
    .tabItem { Image(systemName: "magnifyingglass") }
    .onAppear { selectedTab = 1 }
    .tag(1)

// **Línea 21:** Crea la pestaña Crear hilo. La pestaña Crear hilo permite al usuario crear un nuevo hilo.

CreateThreadDummyView(tabIndex: $selectedTab)
    .tabItem { Image(systemName: "plus") }
    .onAppear { selectedTab = 2 }
    .tag(2)

// **Línea 27:** Crea la pestaña Actividad. La pestaña Actividad muestra una lista de actividades del usuario, como los hilos en los que ha participado y las publicaciones que ha realizado.

ActivityView()
    .tabItem {
        Image(systemName: selectedTab == 3 ? "star.fill" : "star")
        .environment(\.symbolVariants, selectedTab == 3 ? .fill : .none)
    }
    .onAppear { selectedTab = 3 }
    .tag(3)

// **Línea 33:** Crea la pestaña Perfil de usuario actual. La pestaña Perfil de usuario actual muestra el perfil del usuario actual.

CurrentUserProfileView()
    .tabItem {
        Image(systemName: selectedTab == 4 ? "person.fill" : "person")
        .environment(\.symbolVariants, selectedTab == 4 ? .fill : .none)
    }
    .onAppear { selectedTab = 4 }
    .tag(4)

}

// **Línea 39:** Establece el color de resaltado de la barra de pestañas.

.tint(Color.theme.primaryText)

}
}

struct ThreadsTabView_Previews: PreviewProvider {

// **Línea 45:** Define las vistas previas para `ThreadsTabView`. Las vistas previas permiten previsualizar el diseño y el contenido de su vista en Xcode.

static var previews: some View {
    ThreadsTabView()
}
}

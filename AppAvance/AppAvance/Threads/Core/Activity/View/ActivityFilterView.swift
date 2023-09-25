// ActivityFilterView.swift
// Threads
//
//

import SwiftUI

// MARK: - ActivityFilterView

struct ActivityFilterView: View {
    // MARK: - Propiedades

    @Binding var selectedFilter: ActivityFilterViewModel // Esta propiedad vinculada almacena el filtro seleccionado por el usuario.

    // MARK: - Cuerpo

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(ActivityFilterViewModel.allCases) { filter in // Este bucle recorre todos los filtros posibles y muestra un botón para cada filtro.
                    Text(filter.title) // El texto del botón muestra el nombre del filtro.
                        .foregroundColor(filter == selectedFilter ? Color.theme.primaryBackground : Color.theme.primaryText) // El color del texto del botón cambia según el filtro seleccionado.
                        .font(.subheadline) // El texto del botón tiene un tamaño de subtítulo.
                        .fontWeight(.semibold) // El texto del botón tiene un peso seminegrita.
                        .frame(width: 130, height: 42) // El botón tiene un tamaño de 130x42 puntos.
                        .overlay { // Esta superposición añade un borde redondeado al botón.
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(.systemGray4), lineWidth: 1)
                        }
                        .background(filter == selectedFilter ? Color.theme.primaryText : .clear) // El fondo del botón cambia según el filtro seleccionado.
                        .cornerRadius(10) // El botón tiene las esquinas redondeadas.
                        .onTapGesture { // Este gesto táctil permite al usuario seleccionar un filtro.
                            withAnimation(.spring()) {
                                selectedFilter = filter // El filtro seleccionado se actualiza.
                            }
                        }
                }
            }
            .padding(.horizontal) // El texto del botón tiene un relleno horizontal.
        }
    }
}

// MARK: - ActivityFilterView_Previews

struct ActivityFilterView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityFilterView(selectedFilter: .constant(.all))
    }
}

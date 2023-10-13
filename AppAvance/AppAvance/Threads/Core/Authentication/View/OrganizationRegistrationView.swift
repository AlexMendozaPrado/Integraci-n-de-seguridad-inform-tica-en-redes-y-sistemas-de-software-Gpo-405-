//
//  OrganizationRegistrationView.swift
//  SocialConnect
//
//  Created by David Faudoa on 09/10/23.
//

import SwiftUI
import Alamofire
import SwiftyJSON

struct OrganizationRegistrationView: View {
    
    @AppStorage("token") var token: String = ""
    @StateObject var viewModel = RegistrationViewModel()
    @State var registerOrgInfo: RegisterOrgInfo = RegisterOrgInfo(name: "", userName: "", rfc: "", schedule: "", phoneNumber: "", email: "", desc: "", logourl: "", street: "", number: "", city: "", state: "", zipcode: "", country: "", Tags: [])
    
    @State var isAuthenticating: Bool = false
    @State var showAlert: Bool = false
    
    var body: some View {
        ScrollView{
            VStack{
                Image("Yconnect")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .padding()
                
                HStack{
                    Text("Información de Perfil")
                        .font(.title2)
                        .padding(.leading, 30)
                    Spacer()
                }
                
                TextField("Nombre de Organización", text: $registerOrgInfo.name)
                    .modifier(ThreadsTextFieldModifier())
                
                TextField("Nombre de Usuario", text: $registerOrgInfo.userName)
                    .modifier(ThreadsTextFieldModifier())
                
                TextField("RFC", text: $registerOrgInfo.rfc)
                    .modifier(ThreadsTextFieldModifier())
                
                TextField("Descripción", text: $registerOrgInfo.desc)
                    .modifier(ThreadsTextFieldModifier())
                TextField("URL del logo", text: $registerOrgInfo.logourl)
                    .modifier(ThreadsTextFieldModifier())
                
                HStack{
                    Text("Información de Contacto")
                        .font(.title2)
                        .padding(.leading, 30)
                    Spacer()
                }
                TextField("Correo Electrónico", text: $registerOrgInfo.email)
                    .modifier(ThreadsTextFieldModifier())
                
                TextField("Numero de Teléfono", text: $registerOrgInfo.phoneNumber)
                    .modifier(ThreadsTextFieldModifier())
                
                TextField("Horario de Atención", text: $registerOrgInfo.schedule)
                    .modifier(ThreadsTextFieldModifier())
                
                
                HStack{
                    Text("Dirección")
                        .font(.title2)
                        .padding(.leading, 30)
                    Spacer()
                }
                
                HStack(spacing: -40){
                    TextField("Calle", text: $registerOrgInfo.street)
                        .modifier(ThreadsTextFieldModifier())
                        .padding(0)
                        .frame(width: 260)
                    
                    TextField("Numero", text: $registerOrgInfo.number)
                        .modifier(ThreadsTextFieldModifier())
                        .padding(0)
                    
                }
                HStack(spacing: -40){
                    TextField("Ciudad", text: $registerOrgInfo.city)
                        .modifier(ThreadsTextFieldModifier())
                    TextField("Estado", text: $registerOrgInfo.state)
                        .modifier(ThreadsTextFieldModifier())
                }
                
                HStack(spacing: -40){
                    TextField("Codigo Postal", text: $registerOrgInfo.zipcode)
                        .modifier(ThreadsTextFieldModifier())
                    
                    TextField("País", text: $registerOrgInfo.country)
                        .modifier(ThreadsTextFieldModifier())
                }
                
                HStack{
                    Text("Tags")
                        .font(.title2)
                        .padding(.leading, 30)
                    Spacer()
                }
                Button{
                    
                } label: {
                    Text("Sign up")
                        .foregroundColor(Color.theme.primaryBackground)
                        .modifier(ThreadsButtonModifier())
                }
                
            }
        }
    }
    func registerOrg() {
     var newHeaders = mongoHeaders
     newHeaders["Authorization"] = "Bearer \(token)"
        let Parameters = [
            "name" : registerOrgInfo.name,
            "description" : registerOrgInfo.desc,
            "password" : "Admin@123",
            "logourl" : registerOrgInfo.logourl,
            /*/"address": [
                "street1": registerOrgInfo.street,
                "street2": registerOrgInfo.number,
                "city": registerOrgInfo.city,
                "state": registerOrgInfo.state,
                "zipCode": registerOrgInfo.zipcode,
                "country": registerOrgInfo.country
            ]
            "contact" : [
                "email": "string",
                "phoneNumber": "string"
            ],
             "socialNetworks": [
                 {
                   "name": "string",
                   "url": "string"
                 }
               ],
             "role": "string",
               "tags": [
                 "string"
               ]*/

        ]
        
       AF.request("\(mongoBaseUrl)/organizations", method: .post, parameters: Parameters,  encoding: JSONEncoding.default, headers: HTTPHeaders(newHeaders)).responseData { response in
            switch response.result {
            case .success(let value):
                print(value)
            case .failure(let error):
                print(error)
            }
        }
    }
}

#Preview {
    OrganizationRegistrationView()
}


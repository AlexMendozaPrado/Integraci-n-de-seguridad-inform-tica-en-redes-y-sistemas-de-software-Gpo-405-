//
//  LoginView.swift
//  Threads
//
//

import SwiftUI
import Alamofire
import SwiftyJSON

struct LoginView: View {
    @AppStorage("token") var token: String = ""
    @State var loginInfo: LoginInfo = LoginInfo(email: "", password: "")
    @State var isAuthenticating: Bool = false
    @State var showAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                
                Spacer()
                
                // logo image
                Image("Yconnect")
                    .renderingMode(.template)
                    .resizable()
                    .colorMultiply(Color.theme.primaryText)
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .padding()
                
                // text fields
                VStack {
                    TextField("Ingresa tu correo", text: $loginInfo.email)
                        .autocapitalization(.none)
                        .modifier(ThreadsTextFieldModifier())
                    
                    SecureField("Ingresa tu contraseña", text: $loginInfo.password)
                        .modifier(ThreadsTextFieldModifier())
                }
                
                NavigationLink {
                    ForgotPasswordView()
                } label: {
                    Text("Olvidaste tu constraseña?")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .padding(.top)
                        .padding(.trailing, 28)
                        .foregroundColor(Color.theme.primaryText)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                
                Button {
                    Task { login() }
                } label: {
                    Text(isAuthenticating ? "" : "Login")
                        .foregroundColor(Color.theme.primaryBackground)
                        .modifier(ThreadsButtonModifier())
                        .overlay {
                            if isAuthenticating {
                                ProgressView()
                                    .tint(Color.theme.primaryBackground)
                            }
                        }
                }
                .disabled(isAuthenticating || loginInfo.password.isEmpty || loginInfo.email.isEmpty)
                .opacity(isAuthenticating || loginInfo.password.isEmpty || loginInfo.email.isEmpty ? 1 : 0.7)
                
                .padding(.vertical)
                
                Spacer()
                
                Divider()
                
                NavigationLink {
                    RegistrationView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    HStack(spacing: 3) {
                        Text("Don't have an account?")
                        
                        Text("Sign Up")
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(Color.theme.primaryText)
                    .font(.footnote)
                }
                .padding(.vertical, 16)

            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"),
                      message: Text("Usuario o contraseña incorrecta"))
            }
        }
    }
    
    func login() {        
        AF.request("\(mongoBaseUrl)/auth/login", method: .post, parameters: loginInfo, encoder: .json).responseData { data in
            isAuthenticating = true
            
            let json = try! JSON(data: data.data!)
            if json["token"].exists() {
                token = json["token"].stringValue
            } else {
                showAlert = true
            }
            
            isAuthenticating = false
        }
    }
}



struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

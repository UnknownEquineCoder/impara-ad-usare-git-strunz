import Foundation
import SwiftUI

struct LoginView: View {
    
    @State private var isSavingToken = false
    
    @State private var email = ""
    @State private var password = ""
    @Environment(\.openURL) var openURL
    
    var body: some View {
        NavigationView {
            ZStack {
                
                if isSavingToken {
                    ContentView()
                        .frame(width: 1920.toScreenSize(), height: 1080.toScreenSize())
                } else {
                    Button(action: {
                        if let url = URL(string: "LJM://LoginPage") {
                            openURL(url)
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 60.0) {
                            self.isSavingToken = true
                        }
                        
                    }) {
                        Text("Sign In")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 300, height: 20)
                            .background(Color.green)
                            .cornerRadius(15.0)
                            .shadow(radius: 10.0, x: 20, y: 10)
                    }.padding(.top, 50)
                    .frame(width: 500, height: 500)
                    
                }
                
                //            NavigationLink(destination: ContentView(), isActive: $isSavingToken) { EmptyView() }
                
                
                
                
                //            Text("LJM")
                //                .font(.largeTitle).foregroundColor(Color.black)
                //                .padding([.top, .bottom], 40)
                //                .shadow(radius: 10.0, x: 20, y: 10)
                //
                //            Button(action: {
                //                //openURL(URL(string: "http://localhost:4000/auth/oidc/login")!)
                //
                //                login(completion: { result in
                //                    switch result {
                //                    case .failure:
                //                        print("failed")
                //                    case .success(let user):
                //                        print(user)
                //
                //                    }
                //
                //                })
                //            }) {
                //                    Text("Sign In")
                //                    .font(.headline)
                //                    .foregroundColor(.white)
                //                    .padding()
                //                    .frame(width: 300, height: 20)
                //                    .background(Color.green)
                //                    .cornerRadius(15.0)
                //                    .shadow(radius: 10.0, x: 20, y: 10)
                //            }.padding(.top, 50)
                
            }.background(Color.white)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}



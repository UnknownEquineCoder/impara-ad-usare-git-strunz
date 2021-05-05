
import Foundation
import SwiftUI

struct LoginView: View {

    @Environment(\.openURL) var openURL
    
    var body: some View {
        ZStack {
            Button(action: {
                if let url = URL(string: "LJM://LoginPage") {
                    openURL(url)
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
            
        }.frame(width: NSScreen.screenWidth, height: NSScreen.screenHeight, alignment: .center)
        .background(Color.white)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}


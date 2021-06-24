
import Foundation
import SwiftUI

struct LoginView: View {
    
    @Environment(\.openURL) var openURL
    
    var body: some View {
        ZStack {
            BackgroundImageLogin()
            
            VStack(spacing: 30) {
                Text("Welcome to the LJM")
                    .font(.system(size: 45, weight: .semibold, design: .rounded))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.customLightBlack)
                
                Button(action: {
                    if let url = URL(string: "LJM://LoginPage") {
                        openURL(url)
                    }
                }) {
                    Text("One Login")
                        .padding()
                        .font(.system(size: 19, weight: .semibold, design: .rounded))
                        .foregroundColor(.customLightBlack)
                        .frame(width: 300, height: 50)
                        .background(Color.white)
                        .cornerRadius(10)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(.customLightBlack))
                        .shadow(radius: 10.0, x: 20, y: 10)
                }.buttonStyle(PlainButtonStyle())
            }.padding(.bottom, 500)
        }.frame(width: NSScreen.screenWidth, height: NSScreen.screenHeight, alignment: .center)
        .background(Color.white)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}


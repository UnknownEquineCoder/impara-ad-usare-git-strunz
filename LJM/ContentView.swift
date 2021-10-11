import SwiftUI

struct ContentView: View {
    @AppStorage("log_Status") var status = false

    var body: some View {
        StartView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
    

import SwiftUI

struct ContentView: View {
    @AppStorage("log_Status") var status = false

    var body: some View {
        SidebarView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
    

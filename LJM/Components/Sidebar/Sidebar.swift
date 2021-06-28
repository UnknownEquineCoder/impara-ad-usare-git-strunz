import Foundation
import SwiftUI

struct Sidebar: View {
    
    @State private var sections = ["Dashboard", "Journey", "Notebook", "Portfolio", "Backpack"]
    @State private var selection: Int? = 1
    
    var body: some View {
        NavigationView {
            List {
                
                StudentPictureView(size: 85)
                    .padding(.trailing)
                
                #if false
                Navigation<CompassView>(buttonName: "Dashboard", buttonIcon: "square", tag: 0, selection: selection)
                #endif
                
                Section(header: Text("Personal").font(.system(size: 28.toFontSize()))
                            .fontWeight(.regular)) {
                    
                    Navigation<CompassView>(buttonName: "Compass", buttonIcon: "Compass_Icon", tag: 1, selection: selection)
                    
                    Navigation<JourneyMainView>(buttonName: "Map", buttonIcon: "Map_Icon", tag: 2, selection: selection)
                    
                    Navigation<MyJourneyMainView>(buttonName: "Journey", buttonIcon: "Journey_Icon", tag: 3, selection: selection)
                    
                    #if false
                    Navigation<CompassView>(buttonName: "Notebook", buttonIcon: "square", tag: 4, selection: selection)
                    #endif
                }
                #if false
                Section(header: Text("Resume").font(.system(size: 28.toFontSize()))
                            .fontWeight(.regular)) {
                    Navigation<CompassView>(buttonName: "Portfolio", buttonIcon: "square", tag: 5, selection: selection)
                    Navigation<CompassView>(buttonName: "Backpack", buttonIcon: "square", tag: 6, selection: selection)
                }
                #endif
                
            }
            .listStyle(SidebarListStyle())
            .frame(minWidth: 366.toScreenSize(), maxWidth: .infinity)
            
        }
    }
    
    
}
struct Sidebar_Previews: PreviewProvider {
    static var previews: some View {
        Sidebar()
    }
}


import Foundation
import SwiftUI

struct SidebarView: View {
    @State var selectedMenu: OutlineMenu = .compass
    
    @StateObject var studentLearningObj = StudentLearningObjectivesStore() // needed to avoid crash but will be removed with new data flow
    
    @ViewBuilder
    var body: some View {
        HStack(spacing: 0) {
            VStack {
                StudentPictureView(size: 85)
                    .padding(.trailing)
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading) {
                        ForEach(OutlineMenu.allCases) { menu in
                            ZStack(alignment: .leading) {
                                OutlineRow(item: menu, selectedMenu: self.$selectedMenu)
                                    .frame(height: 50)
                                if menu == self.selectedMenu {
                                    Rectangle()
                                        .foregroundColor(Color.secondary.opacity(0.1))
                                        .frame(height: 50)
                                }
                            }
                        }
                    }
                    .padding(.top, 32)
                    .frame(width: 300)
                }
            }.background(Color.primary.opacity(0.1))
            // View connected to the sidebar
          //  selectedMenu.contentView
            
            switch selectedMenu {
            case .compass:
                NavigationView { CompassView() }
            case .journey:
                MyJourneyMainView(selectedMenu: $selectedMenu)
            case .map:
                JourneyMainView()
            }
        }
        .environmentObject(self.studentLearningObj)
    }
}

struct OldSidebar: View {           // remove if new sidebar works properly
    
    @State private var sections = ["Dashboard", "Journey", "Notebook", "Portfolio", "Backpack"]
    @State private var selection: Int? = 1
    
    @StateObject var studentLearningObj = StudentLearningObjectivesStore()
    
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
            
        }.environmentObject(self.studentLearningObj)
    }
    
    
}
struct Sidebar_Previews: PreviewProvider {
    static var previews: some View {
        OldSidebar()
    }
}


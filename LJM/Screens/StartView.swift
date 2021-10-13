import Foundation
import SwiftUI

struct StartView: View {
    @State var selectedMenu: OutlineMenu = .compass
    
    // new data flow element
    @State var path : [learning_Path] = []
    @State var rubric : [rubric_Level] = []
    
    @ViewBuilder
    var body: some View {
        HStack(spacing: 0) {
            VStack {
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
                }
            }.background(Color.primary.opacity(0.1))
            
            // View connected to the sidebar
            
            switch selectedMenu {
            case .compass:
                CompassView()
            case .journey:
                MyJourneyMainView(selectedMenu: $selectedMenu, path: $path)
            case .map:
                MapMainView(path: $path, rubric: $rubric)
            }
            
        }
    }
}


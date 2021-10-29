import Foundation
import SwiftUI

struct StartView: View {
    
    // core data elements
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var objectives: FetchedResults<EvaluatedObject>
    
    @State var selectedMenu: OutlineMenu = .compass
    
    // new data flow element
    @State var path : [learning_Path] = []

    
    @EnvironmentObject var learningObjectiveStore: LearningObjectivesStore
    
    @State var filter_Path = "Design"
    
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
                                        .frame(height: 54)
                                    if menu == self.selectedMenu {
                                        Rectangle()
                                            .foregroundColor(Color.secondary.opacity(0.1))
                                            .frame(height: 54)
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
                CompassView(path: $filter_Path)
            case .journey:
                MyJourneyMainView(selectedMenu: $selectedMenu)
            case .map:
                MapMainView()
            }
        }
        .onAppear {
//            learningObjectiveStore.load_Status(objectives: objectives)
        }
    }
}


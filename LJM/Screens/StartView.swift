import Foundation
import SwiftUI

struct StartView: View {
    
    @Binding var isLoading : Bool
    
    // core data elements
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var objectives: FetchedResults<EvaluatedObject>
    
    @State var selectedMenu: OutlineMenu = .compass
    
    @StateObject var totalNumberLearningObjectivesStore = TotalNumberOfLearningObjectivesStore()
    @StateObject var learningPathsStore = LearningPathStore()
    @StateObject var strandsStore = StrandsStore()
    
    @EnvironmentObject var learningObjectiveStore: LearningObjectivesStore
    
    @State var filter_Path = "Select a Path"
    
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
                                        .frame(height: 54).padding([.leading, .trailing], 10)
                                    if menu == self.selectedMenu {
                                        RoundedRectangle(cornerRadius: 8)
                                            .foregroundColor(Color.secondary.opacity(0.1))
                                            .frame(height: 54)
                                            .padding([.leading, .trailing], 10)
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
            if isLoading {
                HStack{
                    Spacer()
                    VStack{
                        Spacer()
                        Text("Loading...")
                        Spacer()
                    }
                    Spacer()
                }
            } else {
                switch selectedMenu {
                case .compass:
                    CompassView(path: $filter_Path)
                        .environmentObject(totalNumberLearningObjectivesStore)
                        .environmentObject(learningPathsStore)
                        .environmentObject(strandsStore)
                case .journey:
                    MyJourneyMainView(selectedMenu: $selectedMenu)
                        .environmentObject(totalNumberLearningObjectivesStore)
                        .environmentObject(learningPathsStore)
                        .environmentObject(strandsStore)
                case .map:
                    MapMainView()
                        .environmentObject(totalNumberLearningObjectivesStore)
                        .environmentObject(learningPathsStore)
                        .environmentObject(strandsStore)
                }
            }
            
        }
        .onAppear(perform: {
            learningObjectiveStore.load_Test_Data() {
                PersistenceController.shared.fetched_Learning_Objectives = objectives
                learningObjectiveStore.load_Status(objectives: objectives)
                learningPathsStore.load_Learning_Path()
                strandsStore.setupStrandsOnNativeFilter(learningObjectives: learningObjectiveStore.learningObjectives)
            }
            
        })
    }
    
}


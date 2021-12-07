import Foundation
import SwiftUI

struct StartView: View {
    
    @Binding var isLoading : Bool
    
    // core data elements
    @Environment(\.managedObjectContext)
    private var viewContext
    @FetchRequest(fetchRequest: EvaluatedObject.get_Evaluated_Object_List_Request(), animation: .default)
    private var objectives: FetchedResults<EvaluatedObject>
    
    @StateObject var totalNumberLearningObjectivesStore = TotalNumberOfLearningObjectivesStore()
    @StateObject var learningPathsStore = LearningPathStore()
    @StateObject var strandsStore = StrandsStore()
    @EnvironmentObject var learningObjectiveStore: LearningObjectivesStore
    
    @State var selectedMenu: OutlineMenu = .compass
    @State var filter_Path = "None"
    
    func selectedView() -> AnyView {
        switch selectedMenu {
        case .compass:
            return AnyView(CompassView(path: $filter_Path))
        case .journey:
            return AnyView(MyJourneyMainView(selectedMenu: $selectedMenu))
//            return AnyView(CompassView(path: $filter_Path).background(Color.yellow))

        case .map:
            return AnyView(MapMainView())
        }
    }
    
    @ViewBuilder
    var body: some View {

        NavigationView {
            
            VStack(alignment: .leading) {
                ForEach(OutlineMenu.allCases) { menu in
                    ZStack(alignment: .leading) {
                        OutlineRow(item: menu, selectedMenu: self.$selectedMenu)
                            .frame(height: 40)
                            .padding([.leading, .trailing], 10)
                        if menu == self.selectedMenu {
                            RoundedRectangle(cornerRadius: 8)
                                .foregroundColor(Color.secondary.opacity(0.1))
                                .frame(height: 40)
                                .padding([.leading, .trailing], 10)
                        }
                    }
                }
                
                Spacer()
                StudentPictureView()
            }
            .toolbar {
                Image(systemName: "sidebar.left")
                    .onTapGesture {
                        // It will switch the presence of the sidebar
                        NSApp.sendAction(#selector(NSSplitViewController.toggleSidebar(_:)), to: nil, from: nil)
                    }
            }
            
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
                selectedView()
                    .environmentObject(totalNumberLearningObjectivesStore)
                    .environmentObject(learningPathsStore)
                    .environmentObject(strandsStore)
                    .frame(minWidth: NSScreen.screenWidth! - 403, idealWidth: nil, maxWidth: nil, minHeight: nil, idealHeight: nil, maxHeight: nil, alignment: .leading)
            }
        }
        .navigationViewStyle(.automatic)
        .onTapGesture {
            NSApp.keyWindow?.makeFirstResponder(nil)
        }
        .onAppear(perform: {
            
            learningObjectiveStore.load_Test_Data() {
                learningObjectiveStore.load_Status(objectives: objectives)
                learningPathsStore.load_Learning_Path()
                strandsStore.setupStrandsOnNativeFilter(learningObjectives: learningObjectiveStore.learningObjectives)
                isLoading = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.001) {
                    isLoading = false
                }
                
            }
        })
    }
}

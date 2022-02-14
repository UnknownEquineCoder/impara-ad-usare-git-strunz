import Foundation
import SwiftUI
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

struct StartView: View {
    
    @AppStorage("fullScreen") var fullScreen: Bool = FullScreenSettings.fullScreen
    
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
    let blank = false
    @State var selectedMenu: OutlineMenu = .compass
    @State var filter_Path = "None"
    
    @State private var showingAlertTest = false
    
    @State var testDataServer : User?
    
    func selectedView() -> AnyView {
        switch selectedMenu {
        case .compass:
            return AnyView(MainCompassView( filter_Path: $filter_Path))
        case .journey:
            return AnyView(MyJourneyMainView(selectedMenu: $selectedMenu))
        case .map:
            return AnyView(MapMainView())
        case .challenge:
            return AnyView(ChallengeView())
        }
    }
    
    @ViewBuilder
    var body: some View {
        
        HSplitView {
            ZStack{
                Color.clear
                    .ignoresSafeArea()
                    .visualEffect(material: .sidebar)
                    .padding(.top, -70)
                    
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(OutlineMenu.allCases) { menu in
//                        ZStack(alignment: .leading) {
                            
                            OutlineRow(item: menu, selectedMenu: self.$selectedMenu)
                                .frame(height: 28)
                                .padding([.leading, .trailing], 4)
//
//                        }
                    }
                    
                    Spacer()
                    
                    Spacer()
                    StudentPictureView()
                        .padding(.trailing,-15)
                } 
            }
            .padding(.top, fullScreen == true ? 70 : 20)
            .frame(width: 200)
            
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
            }
        }
        .onTapGesture {
            NSApp.keyWindow?.makeFirstResponder(nil)
        }
        .onAppear(perform: {
            
            isLoading = true
            learningObjectiveStore.load_Test_Data() {
                DispatchQueue.main.async {
                    learningObjectiveStore.load_Status(objectives: objectives)
                    learningPathsStore.load_Learning_Path()
                    strandsStore.setupStrandsOnNativeFilter(learningObjectives: learningObjectiveStore.learningObjectives)
                    isLoading = false
                }
            }
        })
    }
}

struct User : Codable {
    let _id: String
    let email: String
    let username: String
}

extension View {
    func visualEffect(
        material: NSVisualEffectView.Material,
        blendingMode: NSVisualEffectView.BlendingMode = .behindWindow,
        emphasized: Bool = false
    ) -> some View {
        background(
            VisualEffectBackground(
                material: material,
                blendingMode: blendingMode,
                emphasized: emphasized
            )
        )
    }
}

struct VisualEffectBackground: NSViewRepresentable {
    private let material: NSVisualEffectView.Material
    private let blendingMode: NSVisualEffectView.BlendingMode
    private let isEmphasized: Bool
    
    fileprivate init(
        material: NSVisualEffectView.Material,
        blendingMode: NSVisualEffectView.BlendingMode,
        emphasized: Bool) {
        self.material = material
        self.blendingMode = blendingMode
        self.isEmphasized = emphasized
    }
    
    func makeNSView(context: Context) -> NSVisualEffectView {
        let view = NSVisualEffectView()
        
        // Not certain how necessary this is
        view.autoresizingMask = [.width, .height]
        
        return view
    }
    
    func updateNSView(_ nsView: NSVisualEffectView, context: Context) {
        nsView.material = material
        nsView.blendingMode = blendingMode
        nsView.isEmphasized = isEmphasized
    }
}
